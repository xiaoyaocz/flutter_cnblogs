import 'package:flutter_cnblogs/generated/locales.g.dart';
import 'package:flutter_cnblogs/services/local_storage_service.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppSettingsController extends GetxController {
  var themeMode = 0.obs;
  var language = "en".obs;
  static const Locale zhLocale = Locale("zh");
  static const Locale enLocale = Locale("en");
  Locale? locale;
  @override
  void onInit() {
    themeMode.value = LocalStorageService.instance
        .getValue(LocalStorageService.kThemeMode, 0);
    _getLanguage();
    super.onInit();
  }

  void _getLanguage() {
    var languageCode = LocalStorageService.instance
        .getValue(LocalStorageService.kLanguage, "");
    if (languageCode.isEmpty) {
      var deviceLocale = Get.deviceLocale;
      //无法获取到语言，默认设置为英文
      if (deviceLocale == null) {
        locale = enLocale;
        LocalStorageService.instance
            .setValue(LocalStorageService.kLanguage, "en");
      } else {
        locale = deviceLocale;
      }
    } else {
      locale = Locale(languageCode);
    }
    language.value = locale!.languageCode;
  }

  void changeTheme() {
    Get.dialog(
      SimpleDialog(
        title: Text(LocaleKeys.settings_theme.tr),
        children: [
          RadioListTile<int>(
            title: Text(LocaleKeys.settings_system_theme.tr),
            value: 0,
            groupValue: themeMode.value,
            onChanged: (e) {
              Get.back();
              setTheme(e ?? 0);
            },
          ),
          RadioListTile<int>(
            title: Text(LocaleKeys.settings_light_theme.tr),
            value: 1,
            groupValue: themeMode.value,
            onChanged: (e) {
              Get.back();
              setTheme(e ?? 1);
            },
          ),
          RadioListTile<int>(
            title: Text(LocaleKeys.settings_dark_theme.tr),
            value: 2,
            groupValue: themeMode.value,
            onChanged: (e) {
              Get.back();
              setTheme(e ?? 2);
            },
          ),
        ],
      ),
    );
  }

  void changeLanguage() {
    Get.dialog(
      SimpleDialog(
        title: Text(LocaleKeys.settings_language.tr),
        children: [
          RadioListTile(
            title: const Text("简体中文"),
            value: "zh",
            groupValue: Get.locale?.languageCode ?? "",
            onChanged: (e) {
              Get.back();
              setLanguage(zhLocale);
            },
          ),
          RadioListTile(
            title: const Text("English"),
            value: "en",
            groupValue: Get.locale?.languageCode ?? "",
            onChanged: (e) {
              Get.back();
              setLanguage(enLocale);
            },
          ),
        ],
      ),
    );
  }

  void setTheme(int i) {
    themeMode.value = i;
    var mode = ThemeMode.values[i];

    LocalStorageService.instance.setValue(LocalStorageService.kThemeMode, i);
    Get.changeThemeMode(mode);
  }

  void setLanguage(Locale locale) {
    LocalStorageService.instance
        .setValue(LocalStorageService.kLanguage, locale.languageCode);
    Get.updateLocale(locale);
  }
}
