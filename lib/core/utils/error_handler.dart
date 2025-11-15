import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:books/l10n/app_localizations.dart';

/// Error handler utility class with localization support
class ErrorHandler {
  /// Get user-friendly error message from Firebase Auth exceptions
  /// Uses localization if available, falls back to English
  static String getAuthErrorMessage(BuildContext context, dynamic error) {
    final localizations = AppLocalizations.of(context);
    
    if (error is FirebaseAuthException) {
      switch (error.code) {
        case 'user-not-found':
          return localizations?.error_user_not_found ?? 
                 'No user found with this email address. Please check your email and try again.';
        case 'wrong-password':
          return localizations?.error_wrong_password ?? 
                 'Incorrect password. Please check your password and try again.';
        case 'email-already-in-use':
          return localizations?.error_email_already_in_use ?? 
                 'An account already exists with this email address. Please sign in instead.';
        case 'weak-password':
          return localizations?.error_weak_password ?? 
                 'Password is too weak. Please use a stronger password with at least 6 characters.';
        case 'invalid-email':
          return localizations?.error_invalid_email ?? 
                 'Invalid email address. Please check your email format and try again.';
        case 'user-disabled':
          return localizations?.error_user_disabled ?? 
                 'This account has been disabled. Please contact support for assistance.';
        case 'too-many-requests':
          return localizations?.error_too_many_requests ?? 
                 'Too many requests. Please wait a moment and try again later.';
        case 'operation-not-allowed':
          return localizations?.error_operation_not_allowed ?? 
                 'This operation is not allowed. Please contact support if you need assistance.';
        case 'network-request-failed':
          return localizations?.error_network_failed ?? 
                 'Network error. Please check your internet connection and try again.';
        case 'timeout':
          return localizations?.error_timeout ?? 
                 'Request timed out. Please check your connection and try again.';
        default:
          return localizations?.error_generic ?? 
                 'An error occurred. Please try again.';
      }
    }
    
    // Handle generic errors
    if (error.toString().toLowerCase().contains('network') || 
        error.toString().toLowerCase().contains('connection')) {
      return localizations?.error_network_failed ?? 
             'Network error. Please check your internet connection and try again.';
    }
    
    if (error.toString().toLowerCase().contains('timeout')) {
      return localizations?.error_timeout ?? 
             'Request timed out. Please try again.';
    }
    
    return localizations?.error_unexpected ?? 
           'An unexpected error occurred. Please try again.';
  }

  /// Get error message key for Firebase Auth exceptions (for localization)
  static String? getAuthErrorKey(dynamic error) {
    if (error is FirebaseAuthException) {
      switch (error.code) {
        case 'user-not-found':
          return 'error_user_not_found';
        case 'wrong-password':
          return 'error_wrong_password';
        case 'email-already-in-use':
          return 'error_email_already_in_use';
        case 'weak-password':
          return 'error_weak_password';
        case 'invalid-email':
          return 'error_invalid_email';
        case 'user-disabled':
          return 'error_user_disabled';
        case 'too-many-requests':
          return 'error_too_many_requests';
        case 'operation-not-allowed':
          return 'error_operation_not_allowed';
        case 'network-request-failed':
          return 'error_network_failed';
        case 'timeout':
          return 'error_timeout';
        default:
          return 'error_generic';
      }
    }
    return 'error_unexpected';
  }

  /// Show error snackbar with localized message
  static void showErrorSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 4),
        action: SnackBarAction(
          label: AppLocalizations.of(context)?.dismiss ?? 'Dismiss',
          textColor: Colors.white,
          onPressed: () {},
        ),
      ),
    );
  }

  /// Show success snackbar with localized message
  static void showSuccessSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  /// Show error dialog with localized message
  static Future<void> showErrorDialog(
    BuildContext context, {
    required String title,
    required String message,
    String? buttonText,
  }) async {
    final localizations = AppLocalizations.of(context);
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text(buttonText ?? localizations?.ok ?? 'OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  /// Show network error message
  static void showNetworkError(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    showErrorSnackBar(
      context,
      localizations?.error_network_failed ?? 
      'Network error. Please check your internet connection and try again.',
    );
  }

  /// Show timeout error message
  static void showTimeoutError(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    showErrorSnackBar(
      context,
      localizations?.error_timeout ?? 
      'Request timed out. Please try again.',
    );
  }
}

