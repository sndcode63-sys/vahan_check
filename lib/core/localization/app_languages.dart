import 'package:flutter/material.dart';

class AppLanguage {
  final String code;
  final String name;
  final Locale locale;

  const AppLanguage({
    required this.code,
    required this.name,
    required this.locale,
  });
}

class AppLanguages {
  AppLanguages._();

  static const List<AppLanguage> supported = [
    AppLanguage(code: "en", name: "English", locale: Locale("en", "US")),
    AppLanguage(code: "hi", name: "हिन्दी", locale: Locale("hi", "IN")),
    AppLanguage(code: "ta", name: "தமிழ்", locale: Locale("ta", "IN")),
    AppLanguage(code: "te", name: "తెలుగు", locale: Locale("te", "IN")),
    AppLanguage(code: "bn", name: "বাংলা", locale: Locale("bn", "IN")),
    AppLanguage(code: "gu", name: "ગુજરાતી", locale: Locale("gu", "IN")),
  ];

  static const Locale fallback = Locale("en", "US");

  static AppLanguage fromCode(String code) {
    return supported.firstWhere(
      (lang) => lang.code == code,
      orElse: () => supported.first,
    );
  }
}
