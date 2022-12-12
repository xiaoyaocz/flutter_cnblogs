import 'dart:convert';

import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:flutter_cnblogs/app/log.dart';

class LocalStorageService extends GetxService {
  static LocalStorageService get instance => Get.find<LocalStorageService>();

  /// 显示模式
  /// * [0] 跟随系统
  /// * [1] 浅色模式
  /// * [2] 深色模式
  static const String kThemeMode = "ThemeMode";

  /// 语言
  /// * [zh] 简体中文
  /// * [en] 英文
  static const String kLanguage = "Language";

  /// DEBUG模式
  static const String kDebugModeKey = "DebugMode";

  /// ACCESS_TOKEN
  static const String kAccessToken = "AccessToken";

  /// ACCESS_TOKEN过期时间
  static const String kAccessTokenExpiresTime = "AccessTokenExpiresTime";

  /// ACCESS_TOKEN
  static const String kUserAccessToken = "UserAccessToken";

  /// REFRESH_TOKEN
  static const String kUserRefreshToken = "UserRefreshToken";

  /// ACCESS_TOKEN过期时间
  static const String kUserAccessTokenExpiresTime =
      "UserAccessTokenExpiresTime";

  /// UserID
  static const String kUserID = "UserID";

  late Box settingsBox;
  Future init() async {
    settingsBox = await Hive.openBox(
      "LocalStorage",
      //加密存储信息，密钥需要32位
      encryptionCipher: HiveAesCipher(
        utf8.encode(r"ASMCd6hy$n!!@DrU6tc^7@hEBLLWHr0r"),
      ),
    );
  }

  T getValue<T>(dynamic key, T defaultValue) {
    var value = settingsBox.get(key, defaultValue: defaultValue) as T;
    Log.d("Get LocalStorage：$key\r\n$value");
    return value;
  }

  Future setValue<T>(dynamic key, T value) async {
    Log.d("Set LocalStorage：$key\r\n$value");
    return await settingsBox.put(key, value);
  }

  Future removeValue<T>(dynamic key) async {
    Log.d("Remove LocalStorage：$key");
    return await settingsBox.delete(key);
  }
}
