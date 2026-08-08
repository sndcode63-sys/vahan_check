import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/localization/app_languages.dart';

class LanguageController extends GetxController {
  static LanguageController get instance => Get.find<LanguageController>();

  static const String storageKey = "selected_language_code";

  LanguageController({required AppLanguage initialLanguage})
      : currentLanguage = initialLanguage.obs;
  final Rx<AppLanguage> currentLanguage;

  static Future<AppLanguage> loadSavedLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    final savedCode = prefs.getString(storageKey);
    if (savedCode != null) {
      return AppLanguages.fromCode(savedCode);
    }
    return AppLanguages.supported.first;
  }

  Future<void> changeLanguage(AppLanguage language) async {
    currentLanguage.value = language;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(storageKey, language.code);
    Get.updateLocale(language.locale);
  }
}
