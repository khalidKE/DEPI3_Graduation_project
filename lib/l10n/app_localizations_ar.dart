// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get welcome_back => '👋 مرحبا بعودتك';

  @override
  String get sign_to_your_account => 'تسجيل الدخول الى حسابك';

  @override
  String get email => 'الايميل';

  @override
  String get password => 'كلمة المرور';

  @override
  String get forget_password => 'نسيت كلمة المرور';

  @override
  String get login => 'تسجيل الدخول';

  @override
  String get your_email => 'الايميل الخاص بك';

  @override
  String get your_password => 'كلمة المرور الخاصة بك';

  @override
  String get dont_have_account => ' ليس لديك حساب ؟';

  @override
  String get sign_up => 'انشئ حساب';

  @override
  String get or_with => 'او باستخدام';

  @override
  String get sign_in_with_google => 'سجل باستخدام جوجل';

  @override
  String get success => 'نجحت العملية';

  @override
  String get login_is_done_successfully => 'تم تسجيل الدخول بنجاح';

  @override
  String get error => 'خطأ';

  @override
  String get login_failed => 'فشلت عملية تسجيل الدخول';

  @override
  String get the_email_must_contain => 'يجب ان يحتوي الايميل على علامة @';
}
