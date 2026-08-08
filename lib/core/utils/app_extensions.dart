import 'package:flutter/material.dart';
import 'package:intl/intl.dart';



//  BUILD CONTEXT EXTENSIONS
extension ContextExtensions on BuildContext {
  double get width => MediaQuery.of(this).size.width;

  double get height => MediaQuery.of(this).size.height;

  ThemeData get theme => Theme.of(this);

  TextTheme get textTheme => Theme.of(this).textTheme;

  // Checks whether the keyboard is currently open
  bool get isKeyboardOpen => MediaQuery.of(this).viewInsets.bottom > 0;

  // Safe area padding (status bar / notch area)
  EdgeInsets get padding => MediaQuery.of(this).padding;

  // Checks whether dark mode is currently active
  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;

  // Quick way to hide/dismiss the keyboard
  void hideKeyboard() => FocusScope.of(this).unfocus();
}

//  STRING EXTENSIONS ----------------
extension StringExtensions on String {
  String get capitalizeFirst {
    if (isEmpty) return this; // nothing to capitalize on empty string
    return this[0].toUpperCase() + substring(1);
  }

  // Capitalizes the first letter of every word
  String get capitalizeWords {
    if (isEmpty) return this;
    return split(' ').map((word) => word.capitalizeFirst).join(' ');
  }

  // Checks whether the string is a valid email address
  bool get isValidEmail {
    final regex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return regex.hasMatch(this);
  }

  // Checks whether the string is a valid phone number
  bool get isValidPhone {
    final regex = RegExp(r'^[0-9]{10,15}$');
    return regex.hasMatch(this);
  }

  // Safe check for null/empty
  bool get isNullOrEmpty => trim().isEmpty;

  // Truncates the string to the given length and appends
  String truncate(int maxLength) {
    if (length <= maxLength) return this;
    return '${substring(0, maxLength)}...';
  }

  // Safely converts the string to an int, returns null if invalid
  int? get toIntOrNull => int.tryParse(this);

  // Safely converts the string to a double, returns null if invalid
  double? get toDoubleOrNull => double.tryParse(this);
}

//  NULLABLE STRING EXTENSIONS
extension NullableStringExtensions on String? {
  // Single place to check null OR empty for a nullable string
  bool get isNullOrEmpty => this == null || this!.trim().isEmpty;

  // Returns a fallback value if the string is null/empty
  String orDefault([String fallback = '-']) {
    if (isNullOrEmpty) return fallback;
    return this!;
  }
}

//  DATETIME EXTENSIONS
extension DateTimeExtensions on DateTime {
  // Formats date like "24 Jul 2025"
  String toFormattedDate({String pattern = 'dd MMM yyyy'}) {
    return DateFormat(pattern).format(this);
  }

  // Formats time like "05:30 PM"
  String toFormattedTime({String pattern = 'hh:mm a'}) {
    return DateFormat(pattern).format(this);
  }

  // Formats full date + time like "24 Jul 2025, 05:30 PM"
  String toFormattedDateTime({String pattern = 'dd MMM yyyy, hh:mm a'}) {
    return DateFormat(pattern).format(this);
  }

  // Checks whether this date is today's date
  bool get isToday {
    final now = DateTime.now();
    return year == now.year && month == now.month && day == now.day;
  }

  // Human readable relative time -> "2 hours ago", "3 days ago" etc.
  String get timeAgo {
    final diff = DateTime.now().difference(this);
    if (diff.inSeconds < 60) return 'Just now';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    if (diff.inDays < 30) return '${diff.inDays}d ago';
    if (diff.inDays < 365) return '${(diff.inDays / 30).floor()}mo ago';
    return '${(diff.inDays / 365).floor()}y ago';
  }
}

//  NUM / DOUBLE EXTENSIONS
extension NumExtensions on num {
  String get toCommaSeparated {
    return toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (match) => '${match[1]},',
    );
  }

  String toCurrency({String symbol = '₹'}) {
    return '$symbol${toStringAsFixed(2)}';
  }

  // Shortcut for vertical spacing -> 16.height (returns a SizedBox)
  SizedBox get height => SizedBox(height: toDouble());

  // Shortcut for horizontal spacing -> 16.width (returns a SizedBox)
  SizedBox get width => SizedBox(width: toDouble());
}

//  WIDGET EXTENSIONS
extension WidgetExtensions on Widget {
  // Adds padding on all sides -> myWidget.paddingAll(16)
  Widget paddingAll(double value) => Padding(
        padding: EdgeInsets.all(value),
        child: this,
      );

  // Adds padding only on left/right -> myWidget.paddingHorizontal(16)
  Widget paddingHorizontal(double value) => Padding(
        padding: EdgeInsets.symmetric(horizontal: value),
        child: this,
      );

  // Adds padding only on top/bottom -> myWidget.paddingVertical(16)
  Widget paddingVertical(double value) => Padding(
        padding: EdgeInsets.symmetric(vertical: value),
        child: this,
      );

  // Makes any widget tappable
  Widget onTap(VoidCallback onTap) => GestureDetector(
        onTap: onTap,
        child: this,
      );

  // Centers the widget on screen
  Widget get centered => Center(child: this);

  // Shows/hides the widget without
  Widget visible(bool isVisible) => Visibility(
        visible: isVisible,
        child: this,
      );
}

//  LIST EXTENSIONS
extension ListExtensions<T> on List<T> {
  // Checks whether the list is empty
  bool get isNullOrEmpty => isEmpty;

  T? getOrNull(int index) {
    if (index < 0 || index >= length) return null;
    return this[index];
  }
}
