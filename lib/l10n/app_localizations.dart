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

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @my_account.
  ///
  /// In en, this message translates to:
  /// **'My Account'**
  String get my_account;

  /// No description provided for @offers_and_promos.
  ///
  /// In en, this message translates to:
  /// **'Offers & Promos'**
  String get offers_and_promos;

  /// No description provided for @your_favorites.
  ///
  /// In en, this message translates to:
  /// **'Your Favorites'**
  String get your_favorites;

  /// No description provided for @order_history.
  ///
  /// In en, this message translates to:
  /// **'Order History'**
  String get order_history;

  /// No description provided for @help_center.
  ///
  /// In en, this message translates to:
  /// **'Help Center'**
  String get help_center;

  /// No description provided for @change_picture.
  ///
  /// In en, this message translates to:
  /// **'Change Picture'**
  String get change_picture;

  /// No description provided for @save_changes.
  ///
  /// In en, this message translates to:
  /// **'Save Changes'**
  String get save_changes;

  /// No description provided for @october_2021.
  ///
  /// In en, this message translates to:
  /// **'October 2021'**
  String get october_2021;

  /// No description provided for @tell_us_how_we_can_help.
  ///
  /// In en, this message translates to:
  /// **'Tell us how we can help 👋'**
  String get tell_us_how_we_can_help;

  /// No description provided for @chapter_support_message.
  ///
  /// In en, this message translates to:
  /// **'Chapter are standing by for service & support!'**
  String get chapter_support_message;

  /// No description provided for @send_to_your_email.
  ///
  /// In en, this message translates to:
  /// **'Send to your email'**
  String get send_to_your_email;

  /// No description provided for @lorem_ipsum_text.
  ///
  /// In en, this message translates to:
  /// **'Lorem Ipsum is simply dummy text of the printing and typesetting industry.'**
  String get lorem_ipsum_text;

  /// No description provided for @you_have_5_coupons_to_use.
  ///
  /// In en, this message translates to:
  /// **'You Have 5 Copons to use'**
  String get you_have_5_coupons_to_use;

  /// No description provided for @notification.
  ///
  /// In en, this message translates to:
  /// **'Notification'**
  String get notification;

  /// No description provided for @current.
  ///
  /// In en, this message translates to:
  /// **'Current'**
  String get current;

  /// No description provided for @september_2021.
  ///
  /// In en, this message translates to:
  /// **'September 2021'**
  String get september_2021;

  /// No description provided for @buy_2_get_1_free.
  ///
  /// In en, this message translates to:
  /// **'Buy 2 get 1 free'**
  String get buy_2_get_1_free;

  /// No description provided for @books_offer_date.
  ///
  /// In en, this message translates to:
  /// **'or since books from 08 - 10 October 2021.'**
  String get books_offer_date;

  /// No description provided for @fifty_percent_discount.
  ///
  /// In en, this message translates to:
  /// **'50% discount'**
  String get fifty_percent_discount;

  /// No description provided for @novel_discount_description.
  ///
  /// In en, this message translates to:
  /// **'on all Books in Novel category with online orders worldwide.'**
  String get novel_discount_description;

  /// No description provided for @new_book_available.
  ///
  /// In en, this message translates to:
  /// **'There is a new book now available'**
  String get new_book_available;

  /// No description provided for @promotion.
  ///
  /// In en, this message translates to:
  /// **'Promotion'**
  String get promotion;

  /// No description provided for @today.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get today;

  /// No description provided for @information.
  ///
  /// In en, this message translates to:
  /// **'Information'**
  String get information;

  /// No description provided for @today_discount_chapter.
  ///
  /// In en, this message translates to:
  /// **'Today 50% discount on all books in Chapter with online orders'**
  String get today_discount_chapter;

  /// No description provided for @discount_feast_phrase.
  ///
  /// In en, this message translates to:
  /// **'Excuse me… Who could ever resist a discount feast? 👀'**
  String get discount_feast_phrase;

  /// No description provided for @chapter_discount_announcement.
  ///
  /// In en, this message translates to:
  /// **'Hear me out. Today, October 24, 2025, Chapter has a 50% discount for any book. What are you waiting for, let\'s order now before it runs out.'**
  String get chapter_discount_announcement;

  /// No description provided for @chapter_discount_details.
  ///
  /// In en, this message translates to:
  /// **'All books are discounted, just order through the Chapter app to enjoy this discount. From bestsellers to timeless classics, we’ve prepared the best collection for you. Discover, read, and enjoy your next great book with Chapter.'**
  String get chapter_discount_details;

  /// No description provided for @whats_your_pick.
  ///
  /// In en, this message translates to:
  /// **'So, what’s your pick? 📖 Don’t miss out—order your next read today 😉'**
  String get whats_your_pick;

  /// No description provided for @grab_it_now.
  ///
  /// In en, this message translates to:
  /// **'Grab it now!'**
  String get grab_it_now;

  /// No description provided for @shop_now.
  ///
  /// In en, this message translates to:
  /// **'Shop Now'**
  String get shop_now;

  /// No description provided for @delivery.
  ///
  /// In en, this message translates to:
  /// **'Delivery'**
  String get delivery;

  /// No description provided for @news.
  ///
  /// In en, this message translates to:
  /// **'News'**
  String get news;

  /// No description provided for @all_books.
  ///
  /// In en, this message translates to:
  /// **'On All Books'**
  String get all_books;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @category.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get category;

  /// No description provided for @all.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get all;

  /// No description provided for @novel.
  ///
  /// In en, this message translates to:
  /// **'Novel'**
  String get novel;

  /// No description provided for @self_love.
  ///
  /// In en, this message translates to:
  /// **'SelfLove'**
  String get self_love;

  /// No description provided for @science.
  ///
  /// In en, this message translates to:
  /// **'Science'**
  String get science;

  /// No description provided for @romantic.
  ///
  /// In en, this message translates to:
  /// **'Romantic'**
  String get romantic;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @recent_searches.
  ///
  /// In en, this message translates to:
  /// **'Recent Searches'**
  String get recent_searches;

  /// No description provided for @skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skip;

  /// No description provided for @sign_in.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get sign_in;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @book_details.
  ///
  /// In en, this message translates to:
  /// **'Book Details'**
  String get book_details;

  /// No description provided for @orders_screen_coming_soon.
  ///
  /// In en, this message translates to:
  /// **'Orders Screen - Coming Soon'**
  String get orders_screen_coming_soon;

  /// No description provided for @cart_screen_coming_soon.
  ///
  /// In en, this message translates to:
  /// **'Cart Screen - Coming Soon'**
  String get cart_screen_coming_soon;

  /// No description provided for @category_screen_coming_soon.
  ///
  /// In en, this message translates to:
  /// **'Category Screen - Coming Soon'**
  String get category_screen_coming_soon;

  /// No description provided for @product_subtotal.
  ///
  /// In en, this message translates to:
  /// **'Product Subtotal'**
  String get product_subtotal;

  /// No description provided for @shipping.
  ///
  /// In en, this message translates to:
  /// **'Shipping'**
  String get shipping;

  /// No description provided for @tax.
  ///
  /// In en, this message translates to:
  /// **'Tax'**
  String get tax;

  /// No description provided for @discount.
  ///
  /// In en, this message translates to:
  /// **'Discount'**
  String get discount;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @please_set_address.
  ///
  /// In en, this message translates to:
  /// **'Please set your address before proceeding'**
  String get please_set_address;

  /// No description provided for @please_fill_all_fields.
  ///
  /// In en, this message translates to:
  /// **'Please fill in all fields'**
  String get please_fill_all_fields;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @select_language.
  ///
  /// In en, this message translates to:
  /// **'Select Language'**
  String get select_language;

  /// No description provided for @arabic.
  ///
  /// In en, this message translates to:
  /// **'Arabic'**
  String get arabic;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// No description provided for @dismiss.
  ///
  /// In en, this message translates to:
  /// **'Dismiss'**
  String get dismiss;

  /// No description provided for @error_user_not_found.
  ///
  /// In en, this message translates to:
  /// **'No user found with this email address. Please check your email and try again.'**
  String get error_user_not_found;

  /// No description provided for @error_wrong_password.
  ///
  /// In en, this message translates to:
  /// **'Incorrect password. Please check your password and try again.'**
  String get error_wrong_password;

  /// No description provided for @error_email_already_in_use.
  ///
  /// In en, this message translates to:
  /// **'An account already exists with this email address. Please sign in instead.'**
  String get error_email_already_in_use;

  /// No description provided for @error_weak_password.
  ///
  /// In en, this message translates to:
  /// **'Password is too weak. Please use a stronger password with at least 6 characters.'**
  String get error_weak_password;

  /// No description provided for @error_invalid_email.
  ///
  /// In en, this message translates to:
  /// **'Invalid email address. Please check your email format and try again.'**
  String get error_invalid_email;

  /// No description provided for @error_user_disabled.
  ///
  /// In en, this message translates to:
  /// **'This account has been disabled. Please contact support for assistance.'**
  String get error_user_disabled;

  /// No description provided for @error_too_many_requests.
  ///
  /// In en, this message translates to:
  /// **'Too many requests. Please wait a moment and try again later.'**
  String get error_too_many_requests;

  /// No description provided for @error_operation_not_allowed.
  ///
  /// In en, this message translates to:
  /// **'This operation is not allowed. Please contact support if you need assistance.'**
  String get error_operation_not_allowed;

  /// No description provided for @error_network_failed.
  ///
  /// In en, this message translates to:
  /// **'Network error. Please check your internet connection and try again.'**
  String get error_network_failed;

  /// No description provided for @error_timeout.
  ///
  /// In en, this message translates to:
  /// **'Request timed out. Please check your connection and try again.'**
  String get error_timeout;

  /// No description provided for @error_generic.
  ///
  /// In en, this message translates to:
  /// **'An error occurred. Please try again.'**
  String get error_generic;

  /// No description provided for @error_unexpected.
  ///
  /// In en, this message translates to:
  /// **'An unexpected error occurred. Please try again.'**
  String get error_unexpected;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

  /// No description provided for @empty_state_no_books.
  ///
  /// In en, this message translates to:
  /// **'No books available at the moment'**
  String get empty_state_no_books;

  /// No description provided for @empty_state_no_orders.
  ///
  /// In en, this message translates to:
  /// **'No orders yet'**
  String get empty_state_no_orders;

  /// No description provided for @empty_state_no_favorites.
  ///
  /// In en, this message translates to:
  /// **'No favorites yet'**
  String get empty_state_no_favorites;

  /// No description provided for @try_again.
  ///
  /// In en, this message translates to:
  /// **'Try Again'**
  String get try_again;

  /// No description provided for @order_details.
  ///
  /// In en, this message translates to:
  /// **'Order Details'**
  String get order_details;

  /// No description provided for @price.
  ///
  /// In en, this message translates to:
  /// **'Price'**
  String get price;
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
