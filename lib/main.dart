import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'core/utils/app_logger.dart';
import 'core/theme/app_theme.dart';
import 'core/localization/app_translations.dart';
import 'core/localization/app_languages.dart';
import 'presentation/routes/app_pages.dart';
import 'presentation/routes/app_routes.dart';
import 'presentation/controllers/language_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final AppLanguage initialLanguage = await LanguageController.loadSavedLanguage();
  AppLogger.enableLogs = !kReleaseMode;
  Get.put(LanguageController(initialLanguage: initialLanguage), permanent: true);

  runApp(MyApp(initialLocale: initialLanguage.locale));
}

class MyApp extends StatelessWidget {
  final Locale initialLocale;

  const MyApp({super.key, required this.initialLocale});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "app_name".tr,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.light,

      // -- LANGUAGE / TRANSLATIONS --
      translations: AppTranslations(),
      fallbackLocale: AppLanguages.fallback,

      // -- ROUTES --
      initialRoute: AppRoutes.user,
      getPages: AppPages.pages,
      defaultTransition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 350),
    );
  }
}
