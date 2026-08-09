import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/localization/app_languages.dart';
import '../../core/localization/translation_provider.dart';
import '../providers/language_provider.dart';

/// Was `Get.bottomSheet` + `Obx`; now `showModalBottomSheet` + a
/// `Consumer` watching `languageProvider`.
void showLanguagePicker(BuildContext context, WidgetRef ref) {
  showModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
    ),
    builder: (context) {
      return SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 16.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
                child: Text(
                  ref.tr('select_language'),
                  style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
                ),
              ),
              const Divider(height: 1),
              Consumer(
                builder: (context, ref, _) {
                  final currentLanguage = ref.watch(languageProvider);
                  return Column(
                    children: AppLanguages.supported.map((lang) {
                      final isSelected = currentLanguage.code == lang.code;
                      return ListTile(
                        title: Text(lang.name),
                        trailing: isSelected
                            ? const Icon(Icons.check_circle, color: Colors.blue)
                            : null,
                        onTap: () {
                          ref.read(languageProvider.notifier).changeLanguage(lang);
                          Navigator.of(context).pop();
                        },
                      );
                    }).toList(),
                  );
                },
              ),
            ],
          ),
        ),
      );
    },
  );
}
