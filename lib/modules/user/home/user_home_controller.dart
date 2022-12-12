import 'package:flutter/material.dart';
import 'package:flutter_cnblogs/app/controller/app_settings_controller.dart';
import 'package:flutter_cnblogs/app/utils.dart';
import 'package:flutter_cnblogs/generated/locales.g.dart';
import 'package:flutter_cnblogs/routes/app_navigation.dart';
import 'package:flutter_cnblogs/routes/route_path.dart';
import 'package:flutter_cnblogs/services/user_service.dart';
import 'package:get/get.dart';

class UserHomeController extends GetxController {
  final AppSettingsController settingController =
      Get.find<AppSettingsController>();
  @override
  void onInit() {
    UserService.instance.refreshProfile();
    super.onInit();
  }

  /// 登录
  void login() {
    UserService.instance.login();
  }

  /// 退出登录
  void logout() async {
    var result = await Utils.showAlertDialog(
      LocaleKeys.user_home_logout_msg.tr,
      title: LocaleKeys.user_home_logout.tr,
    );
    if (result) {
      UserService.instance.logout();
    }
  }

  /// 我的博客
  void myBlog() async {
    if (!UserService.instance.logined.value &&
        !(await UserService.instance.login())) {
      return;
    }
    var blogApp = UserService.instance.userProfile.value?.blogApp ?? "";
    if (blogApp.isNotEmpty) {
      AppNavigator.toUserBlog(blogApp);
    }
  }

  /// 我的收藏
  void myBookmark() {
    Get.toNamed(RoutePath.kUserBookmark);
  }

  /// 主题设置
  void setTheme() {
    settingController.changeTheme();
  }

  /// 语言设置
  void setLanguage() {
    settingController.changeLanguage();
  }

  /// 关于我们
  void about() {
    Get.dialog(AboutDialog(
      applicationIcon: Image.asset(
        'assets/images/logo.png',
        width: 48,
        height: 48,
      ),
      applicationName: LocaleKeys.app_name.tr,
      applicationVersion: LocaleKeys.app_slogan.tr,
      applicationLegalese: LocaleKeys.user_home_about_msg.trParams({
        "version": Utils.packageInfo.version,
      }),
    ));
  }

  /// 检查更新
  void checkUpdate() {
    Utils.checkUpdate(showMsg: true);
  }
}
