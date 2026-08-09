import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../presentation/providers/language_provider.dart';
import 'app_translations.dart';

/// Rebuilds automatically whenever [languageProvider] changes.
final translationsProvider = Provider<Map<String, String>>((ref) {
  final language = ref.watch(languageProvider);
  return AppTranslations.forLanguageCode(language.code);
});

/// Replaces GetX's `"key".tr` — use `ref.tr("key")` inside any
/// ConsumerWidget / ConsumerState instead.
extension TranslationExtension on WidgetRef {
  String tr(String key) {
    final map = read(translationsProvider);
    return map[key] ?? key;
  }
}
