import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cnblogs/app/app_style.dart';
import 'package:flutter_cnblogs/generated/locales.g.dart';
import 'package:flutter_cnblogs/modules/user/home/user_home_controller.dart';
import 'package:flutter_cnblogs/services/user_service.dart';
import 'package:flutter_cnblogs/widgets/net_image.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:get/get.dart';
import 'package:remixicon/remixicon.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class UserHomePage extends GetView<UserHomeController> {
  const UserHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: Get.isDarkMode
            ? SystemUiOverlayStyle.light
            : SystemUiOverlayStyle.dark,
        child: SafeArea(
          child: EasyRefresh(
            header: MaterialHeader(),
            onRefresh: UserService.instance.refreshProfile,
            child: ListView(
              padding: AppStyle.edgeInsetsA4,
              children: [
                AppStyle.vGap12,
                // 用户名、头像
                Obx(
                  () => Visibility(
                    visible: UserService.instance.logined.value,
                    child: ListTile(
                      leading: _buildPhoto(
                          UserService.instance.userProfile.value?.avatar ?? ""),
                      title: Text(
                        UserService.instance.userProfile.value?.displayName ??
                            "",
                        style: const TextStyle(height: 1.0),
                      ),
                      subtitle: Text(LocaleKeys.user_home_seniority.trParams({
                        "seniority": (UserService
                                .instance.userProfile.value?.seniority ??
                            ""),
                      })),
                      trailing: IconButton(
                        onPressed: controller.logout,
                        icon: const Icon(Remix.logout_box_r_line),
                      ),
                    ),
                  ),
                ),
                Obx(
                  () => Visibility(
                    visible: !UserService.instance.logined.value,
                    child: ListTile(
                      leading: _buildPhoto(""),
                      title: Text(
                        LocaleKeys.user_home_not_login.tr,
                        style: const TextStyle(height: 1.0),
                      ),
                      subtitle: Text(
                        LocaleKeys.user_home_to_login.tr,
                      ),
                      trailing: const Icon(
                        Icons.chevron_right,
                        color: Colors.grey,
                      ),
                      onTap: controller.login,
                    ),
                  ),
                ),
                _buildCard(
                  context,
                  children: [
                    ListTile(
                      leading: const Icon(Remix.article_line),
                      title: Text(LocaleKeys.user_home_my_blog.tr),
                      trailing: const Icon(
                        Icons.chevron_right,
                        color: Colors.grey,
                      ),
                      onTap: controller.myBlog,
                    ),
                    ListTile(
                      leading: const Icon(Remix.star_line),
                      title: Text(LocaleKeys.user_home_bookmark.tr),
                      trailing: const Icon(
                        Icons.chevron_right,
                        color: Colors.grey,
                      ),
                      onTap: controller.myBookmark,
                    ),
                  ],
                ),
                _buildCard(
                  context,
                  children: [
                    ListTile(
                      leading: Icon(
                          Get.isDarkMode ? Remix.moon_line : Remix.sun_line),
                      title: Text(LocaleKeys.user_home_theme.tr),
                      trailing: const Icon(
                        Icons.chevron_right,
                        color: Colors.grey,
                      ),
                      onTap: controller.setTheme,
                    ),
                    ListTile(
                      leading: const Icon(Remix.translate),
                      title: Text(LocaleKeys.user_home_language.tr),
                      trailing: const Icon(
                        Icons.chevron_right,
                        color: Colors.grey,
                      ),
                      onTap: controller.setLanguage,
                    ),
                  ],
                ),
                _buildCard(
                  context,
                  children: [
                    ListTile(
                      leading: const Icon(Remix.github_fill),
                      title: Text(LocaleKeys.user_home_github.tr),
                      trailing: const Icon(
                        Icons.chevron_right,
                        color: Colors.grey,
                      ),
                      onTap: () {
                        launchUrlString(
                          "https://github.com/xiaoyaocz/flutter_cnblogs",
                          mode: LaunchMode.externalApplication,
                        );
                      },
                    ),
                    ListTile(
                      leading: const Icon(Remix.upload_2_line),
                      title: Text(LocaleKeys.user_home_update.tr),
                      trailing: const Icon(
                        Icons.chevron_right,
                        color: Colors.grey,
                      ),
                      onTap: controller.checkUpdate,
                    ),
                    ListTile(
                      leading: const Icon(Remix.information_line),
                      title: Text(LocaleKeys.user_home_about.tr),
                      trailing: const Icon(
                        Icons.chevron_right,
                        color: Colors.grey,
                      ),
                      onTap: controller.about,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPhoto(String? photo) {
    if (photo == null || photo.isEmpty) {
      return Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          color: Colors.lightBlue,
          borderRadius: BorderRadius.circular(56),
        ),
        child: const Icon(
          Remix.user_fill,
          color: Colors.white,
          size: 24,
        ),
      );
    }
    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        color: Colors.lightBlue,
        borderRadius: BorderRadius.circular(56),
      ),
      child: NetImage(
        photo,
        width: 56,
        height: 56,
        borderRadius: 56,
      ),
    );
  }

  Widget _buildCard(BuildContext context, {required List<Widget> children}) {
    return Container(
      margin: AppStyle.edgeInsetsH12.copyWith(top: 12),
      child: Material(
        color: Theme.of(context).cardColor,
        borderRadius: AppStyle.radius8,
        child: Theme(
          data: Theme.of(context).copyWith(
            listTileTheme: ListTileThemeData(
              shape: RoundedRectangleBorder(borderRadius: AppStyle.radius8),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: children,
          ),
        ),
      ),
    );
  }
}
