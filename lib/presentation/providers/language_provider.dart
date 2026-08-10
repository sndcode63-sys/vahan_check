import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/localization/app_languages.dart';


class LanguageNotifier extends Notifier<AppLanguage> {
  static const String storageKey = "selected_language_code";

  final AppLanguage initialLanguage;

  LanguageNotifier(this.initialLanguage);

  @override
  AppLanguage build() => initialLanguage;

  static Future<AppLanguage> loadSavedLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    final savedCode = prefs.getString(storageKey);
    if (savedCode != null) {
      return AppLanguages.fromCode(savedCode);
    }
    return AppLanguages.supported.first;
  }

  Future<void> changeLanguage(AppLanguage language) async {
    state = language;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(storageKey, language.code);
  }
}

final languageProvider = NotifierProvider<LanguageNotifier, AppLanguage>(
  () => throw UnimplementedError('languageProvider must be overridden in main.dart'),
);
