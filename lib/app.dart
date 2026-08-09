import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'core/localization/app_languages.dart';
import 'core/theme/app_theme.dart';
import 'presentation/providers/language_provider.dart';
import 'presentation/routes/app_router.dart';


class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  static const Size _designSize = Size(375, 812);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AppLanguage currentLanguage = ref.watch(languageProvider);

    return ScreenUtilInit(
      designSize: _designSize,
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp.router(
          title: "My App",
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: ThemeMode.light,
          locale: currentLanguage.locale,
          supportedLocales: AppLanguages.supported.map((l) => l.locale),
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],

          // -- ROUTING --
          routerConfig: appRouter,
        );
      },
    );
  }
}
