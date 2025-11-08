import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en')
  ];

  /// No description provided for @welcome_back.
  ///
  /// In en, this message translates to:
  /// **'Welcome Back 👋'**
  String get welcome_back;

  /// No description provided for @sign_to_your_account.
  ///
  /// In en, this message translates to:
  /// **'Sign to your account'**
  String get sign_to_your_account;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'email'**
  String get email;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'password'**
  String get password;

  /// No description provided for @forget_password.
  ///
  /// In en, this message translates to:
  /// **'forget password'**
  String get forget_password;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'login'**
  String get login;

  /// No description provided for @your_email.
  ///
  /// In en, this message translates to:
  /// **'your email'**
  String get your_email;

  /// No description provided for @your_password.
  ///
  /// In en, this message translates to:
  /// **'your password'**
  String get your_password;

  /// No description provided for @dont_have_account.
  ///
  /// In en, this message translates to:
  /// **'Don’t have an account?'**
  String get dont_have_account;

  /// No description provided for @sign_up.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get sign_up;

  /// No description provided for @or_with.
  ///
  /// In en, this message translates to:
  /// **'Or with'**
  String get or_with;

  /// No description provided for @sign_in_with_google.
  ///
  /// In en, this message translates to:
  /// **'Sign in with Google'**
  String get sign_in_with_google;

  /// No description provided for @success.
  ///
  /// In en, this message translates to:
  /// **'Success'**
  String get success;

  /// No description provided for @login_is_done_successfully.
  ///
  /// In en, this message translates to:
  /// **'login is done successfully'**
  String get login_is_done_successfully;

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// No description provided for @login_failed.
  ///
  /// In en, this message translates to:
  /// **'login failed'**
  String get login_failed;

  /// No description provided for @the_email_must_contain.
  ///
  /// In en, this message translates to:
  /// **'the email must contain @ '**
  String get the_email_must_contain;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @this_field_cant_be_empty.
  ///
  /// In en, this message translates to:
  /// **'this field can\'t be empty'**
  String get this_field_cant_be_empty;

  /// No description provided for @your_name.
  ///
  /// In en, this message translates to:
  /// **'your name'**
  String get your_name;

  /// No description provided for @phone_number.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get phone_number;

  /// No description provided for @your_number.
  ///
  /// In en, this message translates to:
  /// **'your number'**
  String get your_number;

  /// No description provided for @signup_is_done_successfully.
  ///
  /// In en, this message translates to:
  /// **'signup is done successfully'**
  String get signup_is_done_successfully;

  /// No description provided for @signup_failed.
  ///
  /// In en, this message translates to:
  /// **'signup failed'**
  String get signup_failed;

  /// No description provided for @create_account_and_choose_favorite_menu.
  ///
  /// In en, this message translates to:
  /// **'Create account and choose favorite menu'**
  String get create_account_and_choose_favorite_menu;

  /// No description provided for @have_an_account.
  ///
  /// In en, this message translates to:
  /// **'Have an account?'**
  String get have_an_account;

  /// No description provided for @sign_In.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get sign_In;

  /// No description provided for @by_clicking_Register_you_agree_to_our.
  ///
  /// In en, this message translates to:
  /// **'By clicking Register, you agree to our  '**
  String get by_clicking_Register_you_agree_to_our;

  /// No description provided for @terms_and_Data_Policy.
  ///
  /// In en, this message translates to:
  /// **'Terms and Data Policy.'**
  String get terms_and_Data_Policy;

  /// No description provided for @please_enter_your_phone_number.
  ///
  /// In en, this message translates to:
  /// **'Please enter your phone number, so we can more easily deliver your order'**
  String get please_enter_your_phone_number;

  /// No description provided for @continuee.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continuee;

  /// No description provided for @phone_number_is_not_correct.
  ///
  /// In en, this message translates to:
  /// **'phone number is not correct'**
  String get phone_number_is_not_correct;

  /// No description provided for @congratulation.
  ///
  /// In en, this message translates to:
  /// **'Congratulation!'**
  String get congratulation;

  /// No description provided for @your_account_is_complete.
  ///
  /// In en, this message translates to:
  /// **'your account is complete, please enjoy the best menu from us.'**
  String get your_account_is_complete;

  /// No description provided for @get_Started.
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get get_Started;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
