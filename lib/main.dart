import 'package:books/core/widgets/error_boundary.dart';
import 'package:books/core/services/language_service.dart';
import 'package:books/l10n/app_localizations.dart';
import 'package:books/secrets/secrets.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' show GetMaterialApp;
import 'package:google_sign_in/google_sign_in.dart';
import 'firebase_options.dart';
import 'package:books/features/onboarding_feature/data/hive_helper.dart';
import 'package:books/features/splash_feature/presentation/views/splash_screen.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:intl/intl.dart' show Bidi;

@pragma('vm:entry-point')
Future<void> _backgroundHandler(RemoteMessage message) async {
  // Handle background message
}
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    debugPrint('Message data: ${message.data}');
    if (message.notification != null) {
      debugPrint('Message also contained a notification: ${message.notification}');
    }
  });
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    debugPrint('Message clicked! ${message.messageId}');
  });
  
  FirebaseMessaging.onBackgroundMessage(_backgroundHandler);

  await HiveHelper.initialize();
  await HiveHelper.getShowOnboardingState();
  
  // Initialize language service
  await LanguageService.initialize();
  
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    debugPrint('Firebase initialized successfully');
  } catch (e) {
    debugPrint('Error initializing Firebase: $e');
  }
  final google = await GoogleSignIn.instance.initialize(
    clientId: Secrets.clientID,
  );

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _currentLocale = LanguageService.getCurrentLocale();

  @override
  void initState() {
    super.initState();
    // Listen for locale changes (this will be triggered when language is changed)
    // We'll use a ValueNotifier or similar mechanism for real-time updates
    // For now, the locale will update on app restart or when explicitly refreshed
  }

  void _updateLocale(Locale newLocale) {
    setState(() {
      _currentLocale = newLocale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ErrorBoundary(
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: _currentLocale,
        home: const SplashScreen(),
        // Add a builder to handle locale changes dynamically
        builder: (context, child) {
          // Update locale from service when widget rebuilds
          final serviceLocale = LanguageService.getCurrentLocale();
          if (serviceLocale != _currentLocale) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (mounted) {
                _updateLocale(serviceLocale);
              }
            });
          }
          
          // Ensure we have a valid context before using it
          if (child == null) return const SizedBox.shrink();
          
          // Get the current locale and set text direction
          final locale = Localizations.localeOf(context);
          final isRTL = Bidi.isRtlLanguage(locale.languageCode);
          
          return Directionality(
            textDirection: isRTL ? TextDirection.rtl : TextDirection.ltr,
            child: MediaQuery(
              data: MediaQuery.of(context).copyWith(
                // Ensure text size respects accessibility settings
                textScaleFactor: MediaQuery.textScaleFactorOf(context).clamp(0.8, 1.5),
              ),
              child: child,
            ),
          );
        },
      ),
    );
  }
}
