import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app.dart';
import 'core/localization/app_languages.dart';
import 'core/utils/app_logger.dart';
import 'presentation/providers/language_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final AppLanguage initialLanguage = await LanguageNotifier.loadSavedLanguage();
  AppLogger.enableLogs = !kReleaseMode;

  runApp(
    ProviderScope(
      overrides: [
        languageProvider.overrideWith(() => LanguageNotifier(initialLanguage)),
      ],
      child: const MyApp(),
    ),
  );
}
