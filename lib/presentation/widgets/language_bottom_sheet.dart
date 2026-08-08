import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/localization/app_languages.dart';
import '../controllers/language_controller.dart';

void showLanguagePicker() {
  final controller = LanguageController.instance;

  Get.bottomSheet(
    Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Text(
              "select_language".tr,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
          ),
          const Divider(height: 1),
          Obx(
            () => Column(
              children: AppLanguages.supported.map((lang) {
                final isSelected = controller.currentLanguage.value.code == lang.code;
                return ListTile(
                  title: Text(lang.name),
                  trailing: isSelected
                      ? const Icon(Icons.check_circle, color: Colors.blue)
                      : null,
                  onTap: () {
                    controller.changeLanguage(lang);
                    Get.back();
                  },
                );
              }).toList(),
            ),
          ),
        ],
      ),
    ),
  );
}
