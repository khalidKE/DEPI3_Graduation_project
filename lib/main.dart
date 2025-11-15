import 'package:books/core/widgets/error_boundary.dart';
import 'package:books/core/services/language_service.dart';
import 'package:books/l10n/app_localizations.dart';
import 'package:books/secrets/secrets.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'firebase_options.dart';
import 'package:books/features/onboarding_feature/data/hive_helper.dart';
import 'package:books/features/splash_feature/presentation/views/splash_screen.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

@pragma('vm:entry-point')
Future<void> _backgroundHandler(RemoteMessage message) async {
  // Handle background message
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  debugPrint('Handling background message: ${message.messageId}');
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Hive
  await Hive.initFlutter();
  await HiveHelper.initialize();
  await HiveHelper.getShowOnboardingState();
  
  // Initialize Firebase
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    debugPrint('Firebase initialized successfully');
    
    // Initialize Firebase Messaging
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      debugPrint('Message data: ${message.data}');
      if (message.notification != null) {
        debugPrint('Message also contained a notification: ${message.notification}');
      }
    });
    
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      debugPrint('Message clicked! ${message.messageId}');
    });
    
    await FirebaseMessaging.instance.requestPermission();
    FirebaseMessaging.onBackgroundMessage(_backgroundHandler);
  } catch (e) {
    debugPrint('Error initializing Firebase: $e');
    runApp(const ErrorApp(error: 'Failed to initialize Firebase'));
    return;
  }
  
  // Initialize language service
  try {
    await LanguageService.initialize();
  } catch (e) {
    debugPrint('Error initializing language service: $e');
  }
  
  // Initialize Google Sign-In
  try {
    await GoogleSignIn.instance.initialize(
      clientId: Secrets.clientID,
    );
  } catch (e) {
    debugPrint('Error initializing Google Sign-In: $e');
  }

  runApp(const MyApp());
}

class ErrorApp extends StatelessWidget {
  final String error;
  
  const ErrorApp({super.key, required this.error});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('Initialization Error: $error'),
        ),
      ),
    );
  }
}

// Global navigator key - must be outside the widget class to persist across rebuilds
final GlobalKey<NavigatorState> _appNavigatorKey = GlobalKey<NavigatorState>();

// Store initial locale - this never changes, ensuring GetMaterialApp never rebuilds
late final Locale _initialLocale;

// Flag to ensure locale handling is initialized only once
bool _localeHandlingInitialized = false;

// Cache GetMaterialApp widget to ensure it's never rebuilt
Widget? _cachedGetMaterialApp;

// Initialize locale handling once
void _initializeLocaleHandling() {
  if (_localeHandlingInitialized) return;
  _localeHandlingInitialized = true;
  
  _initialLocale = LanguageService.getCurrentLocale();
  Get.updateLocale(_initialLocale);
  
  // Listen for locale changes and sync with GetX
  LanguageService.localeNotifier.addListener(() {
    final newLocale = LanguageService.localeNotifier.value;
    if (Get.locale != newLocale) {
      Get.updateLocale(newLocale);
    }
  });
  
  // Build GetMaterialApp once and cache it
  _cachedGetMaterialApp = GetMaterialApp(
    key: const ValueKey('stable_get_material_app'),
    navigatorKey: _appNavigatorKey,
    debugShowCheckedModeBanner: false,
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
    // Don't provide locale - GetMaterialApp will use Get.locale automatically
    // This ensures GetMaterialApp never rebuilds when locale changes
    home: const _LocaleAwareWrapper(child: SplashScreen()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize locale handling once (this also builds and caches GetMaterialApp)
    _initializeLocaleHandling();
    
    // Always return the cached GetMaterialApp - it's built once and never rebuilt
    return ErrorBoundary(
      child: RepaintBoundary(
        child: _cachedGetMaterialApp!,
      ),
    );
  }
}

// Separate widget to handle locale-dependent UI updates
class _LocaleAwareWrapper extends StatelessWidget {
  final Widget child;
  
  const _LocaleAwareWrapper({required this.child});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Locale>(
      valueListenable: LanguageService.localeNotifier,
      builder: (context, locale, _) {
        final currentLocale = locale;
        final isRTL = currentLocale.languageCode == 'ar';
        
        // Sync with GetX - update Get.locale without rebuilding GetMaterialApp
        if (Get.locale != currentLocale) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Get.updateLocale(currentLocale);
          });
        }
        
        return Directionality(
          textDirection: isRTL ? TextDirection.rtl : TextDirection.ltr,
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return FadeTransition(
                opacity: animation,
                child: SlideTransition(
                  position: Tween<Offset>(
                    begin: Offset(isRTL ? 0.1 : -0.1, 0),
                    end: Offset.zero,
                  ).animate(CurvedAnimation(
                    parent: animation,
                    curve: Curves.easeInOut,
                  )),
                  child: child,
                ),
              );
            },
            child: MediaQuery(
              key: ValueKey('media_${currentLocale.languageCode}'),
              data: MediaQuery.of(context).copyWith(
                // Ensure text size respects accessibility settings
                textScaler: MediaQuery.textScalerOf(context).clamp(minScaleFactor: 0.8, maxScaleFactor: 1.5),
              ),
              child: child,
            ),
          ),
        );
      },
    );
  }
}
