import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../presentation/providers/language_provider.dart';
import 'app_translations.dart';

final translationsProvider = Provider<Map<String, String>>((ref) {
  final language = ref.watch(languageProvider);
  return AppTranslations.forLanguageCode(language.code);
});


extension TranslationExtension on WidgetRef {
  String tr(String key) {
    final map = read(translationsProvider);
    return map[key] ?? key;
  }
}
