import 'package:flutter/material.dart';


class AppUtils {
  AppUtils._();

  //  SNACKBARS
  static void showSuccess(BuildContext context, String message, {String title = "Success"}) {
    _showSnackBar(
      context,
      message: message,
      backgroundColor: Colors.green.shade600,
      icon: Icons.check_circle,
    );
  }

  static void showError(BuildContext context, String message, {String title = "Error"}) {
    _showSnackBar(
      context,
      message: message,
      backgroundColor: Colors.red.shade600,
      icon: Icons.error,
    );
  }

  static void showInfo(BuildContext context, String message, {String title = "Info"}) {
    _showSnackBar(
      context,
      message: message,
      backgroundColor: Colors.blueGrey.shade600,
    );
  }

  static void _showSnackBar(
    BuildContext context, {
    required String message,
    required Color backgroundColor,
    IconData? icon,
  }) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: backgroundColor,
        margin: const EdgeInsets.all(12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        content: Row(
          children: [
            if (icon != null) Icon(icon, color: Colors.white),
            if (icon != null) const SizedBox(width: 10),
            Expanded(
              child: Text(message, style: const TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

  //  VALIDATORS
  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) return "Email is required";
    final regex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!regex.hasMatch(value)) return "Enter a valid email";
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) return "Password is required";
    if (value.length < 6) return "Password must be at least 6 characters";
    return null;
  }

  static String? validateNotEmpty(String? value, {String fieldName = "Field"}) {
    if (value == null || value.trim().isEmpty) return "$fieldName is required";
    return null;
  }

  static String? validatePhone(String? value) {
    if (value == null || value.trim().isEmpty) return "Phone number is required";
    if (value.length < 10) return "Enter a valid phone number";
    return null;
  }

  //  LOADING DIALOG
  static void showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(child: CircularProgressIndicator()),
    );
  }

  static void hideLoadingDialog(BuildContext context) {
    if (Navigator.of(context, rootNavigator: true).canPop()) {
      Navigator.of(context, rootNavigator: true).pop();
    }
  }

  //  MISC
  static void hideKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  static String capitalize(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1);
  }
}
