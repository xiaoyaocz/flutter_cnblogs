import 'dart:io';

import 'package:extended_image/extended_image.dart';
import 'package:flutter_cnblogs/app/app_style.dart';
import 'package:flutter_cnblogs/app/log.dart';
import 'package:flutter_cnblogs/generated/locales.g.dart';
import 'package:flutter_cnblogs/requests/common_request.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:intl/intl.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
// ignore_for_file: depend_on_referenced_packages
import 'package:path/path.dart' as p;
import 'package:photo_view/photo_view_gallery.dart';
import 'package:url_launcher/url_launcher_string.dart';

class Utils {
  static late PackageInfo packageInfo;
  static DateFormat dateFormat = DateFormat("MM-dd HH:mm");
  static DateFormat dateFormatWithYear = DateFormat("yyyy-MM-dd HH:mm");

  /// 处理时间
  static String parseTime(DateTime? dt) {
    if (dt == null) {
      return "";
    }

    var dtNow = DateTime.now();
    if (dt.year == dtNow.year &&
        dt.month == dtNow.month &&
        dt.day == dtNow.day) {
      return "${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}";
    }

    if (dt.year == dtNow.year) {
      return dateFormat.format(dt);
    }

    return dateFormatWithYear.format(dt);
  }

  /// 处理博问等级
  /// - https://q.cnblogs.com/q/faq#qt
  /// - 1	初学一级	0-200
  /// - 2	菜鸟二级	201-500
  /// - 3	小虾三级	501-2000
  /// - 4	老鸟四级	2001-5000
  /// - 5	大侠五级	5001-10000
  /// - 6	专家六级	10001-20000
  /// - 7	高人七级	20001-50000
  /// - 8	牛人八级	50001-100000
  /// - 9	大牛九级	100000以上
  static String parseQuestionLevel(int coin) {
    if (coin <= 200) {
      return "初学一级";
    } else if (coin > 200 && coin <= 500) {
      return "菜鸟二级";
    } else if (coin > 500 && coin <= 2000) {
      return "小虾三级";
    } else if (coin > 2000 && coin <= 5000) {
      return "老鸟四级";
    } else if (coin > 5000 && coin <= 10000) {
      return "大侠五级";
    } else if (coin > 10000 && coin <= 20000) {
      return "专家六级";
    } else if (coin > 20000 && coin <= 50000) {
      return "高人七级";
    } else if (coin > 50000 && coin <= 100000) {
      return "牛人八级";
    } else {
      return "大牛九级";
    }
  }

  /// 提示弹窗
  /// - `content` 内容
  /// - `title` 弹窗标题
  /// - `confirm` 确认按钮内容，留空为确定
  /// - `cancel` 取消按钮内容，留空为取消
  static Future<bool> showAlertDialog(
    String content, {
    String title = '',
    String confirm = '',
    String cancel = '',
    bool selectable = false,
    List<Widget>? actions,
  }) async {
    var result = await Get.dialog(
      AlertDialog(
        title: Text(title),
        content: Padding(
          padding: AppStyle.edgeInsetsV12,
          child: selectable ? SelectableText(content) : Text(content),
        ),
        actions: [
          TextButton(
            onPressed: (() => Get.back(result: false)),
            child: Text(cancel.isEmpty ? LocaleKeys.dialog_cancel.tr : cancel),
          ),
          TextButton(
            onPressed: (() => Get.back(result: true)),
            child:
                Text(confirm.isEmpty ? LocaleKeys.dialog_confirm.tr : confirm),
          ),
          ...?actions,
        ],
      ),
    );
    return result ?? false;
  }

  /// 提示弹窗
  /// - `content` 内容
  /// - `title` 弹窗标题
  /// - `confirm` 确认按钮内容，留空为确定
  static Future<bool> showMessageDialog(String content,
      {String title = '', String confirm = '', bool selectable = false}) async {
    var result = await Get.dialog(
      AlertDialog(
        title: Text(title),
        content: Padding(
          padding: AppStyle.edgeInsetsV12,
          child: selectable ? SelectableText(content) : Text(content),
        ),
        actions: [
          TextButton(
            onPressed: (() => Get.back(result: true)),
            child:
                Text(confirm.isEmpty ? LocaleKeys.dialog_confirm.tr : confirm),
          ),
        ],
      ),
    );
    return result ?? false;
  }

  /// 文本编辑的弹窗
  /// - `content` 编辑框默认的内容
  /// - `title` 弹窗标题
  /// - `confirm` 确认按钮内容
  /// - `cancel` 取消按钮内容
  static Future<String?> showEditTextDialog(String content,
      {String title = '',
      String? hintText,
      String confirm = '',
      String cancel = ''}) async {
    final TextEditingController textEditingController =
        TextEditingController(text: content);
    var result = await Get.dialog(
      AlertDialog(
        title: Text(title),
        content: Padding(
          padding: AppStyle.edgeInsetsT12,
          child: TextField(
            controller: textEditingController,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              //prefixText: title,
              contentPadding: AppStyle.edgeInsetsA12,
              hintText: hintText ?? title,
            ),
            // style: TextStyle(
            //     height: 1.0,
            //     color: Get.isDarkMode ? Colors.white : Colors.black),
            autofocus: true,
          ),
        ),
        actions: [
          TextButton(
            onPressed: Get.back,
            child: Text(LocaleKeys.dialog_cancel.tr),
          ),
          TextButton(
            onPressed: () {
              Get.back(result: textEditingController.text);
            },
            child: Text(LocaleKeys.dialog_confirm.tr),
          ),
        ],
      ),
      // barrierColor:
      //     Get.isDarkMode ? Colors.grey.withOpacity(.3) : Colors.black38,
    );
    return result;
  }

  static Future<T?> showOptionDialog<T>(
    List<T> contents,
    T value, {
    String title = '',
  }) async {
    var result = await Get.dialog(
      SimpleDialog(
        title: Text(title),
        children: contents
            .map(
              (e) => RadioListTile<T>(
                title: Text(e.toString()),
                value: e,
                groupValue: value,
                onChanged: (e) {
                  Get.back(result: e);
                },
              ),
            )
            .toList(),
      ),
    );
    return result;
  }

  static Future<T?> showMapOptionDialog<T>(
    Map<T, String> contents,
    T value, {
    String title = '',
  }) async {
    var result = await Get.dialog(
      SimpleDialog(
        title: Text(title),
        children: contents.keys
            .map(
              (e) => RadioListTile<T>(
                title: Text((contents[e] ?? '-').tr),
                value: e,
                groupValue: value,
                onChanged: (e) {
                  Get.back(result: e);
                },
              ),
            )
            .toList(),
      ),
    );
    return result;
  }

  static void showImageViewer(int initIndex, List<String> images) {
    var index = initIndex.obs;
    Get.dialog(
      Scaffold(
        backgroundColor: Colors.black87,
        body: Stack(
          children: [
            PhotoViewGallery.builder(
              itemCount: images.length,
              builder: (_, i) {
                return PhotoViewGalleryPageOptions(
                  imageProvider: ExtendedNetworkImageProvider(images[i]),
                  onTapUp: ((context, details, controllerValue) => Get.back()),
                );
              },
              loadingBuilder: (context, event) => const Center(
                child: CircularProgressIndicator(),
              ),
              pageController: PageController(
                initialPage: index.value,
              ),
              onPageChanged: ((i) {
                index.value = i;
              }),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              margin: AppStyle.edgeInsetsA24,
              child: Obx(
                () => Text(
                  "${index.value + 1}/${images.length}",
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
            Positioned(
              right: 12,
              top: 12,
              child: TextButton.icon(
                onPressed: () {
                  saveImage(images[index.value]);
                },
                icon: const Icon(Icons.save),
                label: Text(LocaleKeys.dialog_save.tr),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 检查相册权限
  static Future<bool> checkPhotoPermission() async {
    try {
      var status = await Permission.photos.status;
      if (status == PermissionStatus.granted) {
        return true;
      }
      status = await Permission.photos.request();
      if (status.isGranted) {
        return true;
      } else {
        SmartDialog.showToast(
          LocaleKeys.permission_denied_msg.trParams(
            {"permission": LocaleKeys.permission_photo.tr},
          ),
        );
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  /// 保存图片
  static void saveImage(String url) async {
    if (Platform.isIOS && !await Utils.checkPhotoPermission()) {
      return;
    }
    try {
      var provider = ExtendedNetworkImageProvider(url, cache: true);
      var data = await provider.getNetworkImageData();
      if (data == null) {
        SmartDialog.showToast(LocaleKeys.dialog_save_image_failure.tr);
        return;
      }
      var cacheDir = await getTemporaryDirectory();
      var file = File(p.join(cacheDir.path, p.basename(url)));
      await file.writeAsBytes(data);
      final result = await ImageGallerySaver.saveFile(
        file.path,
        name: p.basename(url),
        isReturnPathOfIOS: true,
      );
      Log.d(result.toString());
      SmartDialog.showToast(LocaleKeys.dialog_save_image_successful.tr);
    } catch (e) {
      SmartDialog.showToast(LocaleKeys.dialog_save_image_failure.tr);
    }
  }

  /// Markdown图片转为Html
  static String markdownImageConvert(String content) {
    //\!\[.*?\]\((.*?)\)
    var reg = RegExp(r"\!\[.*?\]\((.*?)\)");
    var matches = reg.allMatches(content);
    for (var match in matches) {
      var mdImg = match.group(0) ?? "";
      var src = match.group(1) ?? "";
      var imgHtml = '<img src="$src"/>';

      content = content.replaceAll(mdImg, imgHtml);
    }
    return content;
  }

  static void checkUpdate({bool showMsg = false}) async {
    try {
      int currentVer = Utils.parseVersion(packageInfo.version);
      CommonRequest request = CommonRequest();
      var versionInfo = await request.checkUpdate();
      if (versionInfo.versionNum > currentVer) {
        Get.dialog(
          AlertDialog(
            title: Text(
              "${LocaleKeys.about_new_version.tr} ${versionInfo.version}",
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18),
            ),
            content: Text(
              versionInfo.versionDesc,
              style: const TextStyle(fontSize: 14, height: 1.4),
            ),
            actionsPadding: AppStyle.edgeInsetsH12,
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: Text(LocaleKeys.dialog_cancel.tr),
                    ),
                  ),
                  AppStyle.hGap12,
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                      ),
                      onPressed: () {
                        launchUrlString(
                          versionInfo.downloadUrl,
                          mode: LaunchMode.externalApplication,
                        );
                      },
                      child: Text(LocaleKeys.about_update.tr),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      } else {
        if (showMsg) {
          SmartDialog.showToast(LocaleKeys.about_not_new_version.tr);
        }
      }
    } catch (e) {
      Log.logPrint(e);
      if (showMsg) {
        SmartDialog.showToast(LocaleKeys.about_not_new_version.tr);
      }
    }
  }

  static int parseVersion(String version) {
    var sp = version.split('.');
    var num = "";
    for (var item in sp) {
      num = num + item.padLeft(2, '0');
    }
    return int.parse(num);
  }
}
