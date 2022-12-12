import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_cnblogs/app/app_style.dart';
import 'package:flutter_cnblogs/app/controller/base_controller.dart';
import 'package:flutter_cnblogs/app/event_bus.dart';
import 'package:flutter_cnblogs/generated/locales.g.dart';
import 'package:flutter_cnblogs/modules/statuses/home/statuses_list_controller.dart';
import 'package:flutter_cnblogs/requests/statuses_request.dart';
import 'package:flutter_cnblogs/services/user_service.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

import 'package:get/get.dart';

class StatusesHomeController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;
  StatusesHomeController() {
    tabController = TabController(length: tabs.length, vsync: this);
  }
  final StatusesRequest request = StatusesRequest();
  final tabs = [
    LocaleKeys.statuses_all,
    LocaleKeys.statuses_recentcomment,
    LocaleKeys.statuses_following,
    LocaleKeys.statuses_my,
    LocaleKeys.statuses_mention,
    LocaleKeys.statuses_mycomment,
    LocaleKeys.statuses_comment,
  ];
  StreamSubscription<dynamic>? streamSubscription;
  @override
  void onInit() {
    streamSubscription = EventBus.instance.listen(
      EventBus.kBottomNavigationBarClicked,
      (index) {
        if (index == 2) {
          refreshOrScrollTop();
        }
      },
    );
    for (var tag in tabs) {
      Get.put(StatusesListController(tag), tag: tag);
    }

    super.onInit();
  }

  void refreshOrScrollTop() {
    var tabIndex = tabController.index;
    BasePageController controller =
        Get.find<StatusesListController>(tag: tabs[tabIndex]);

    controller.scrollToTopOrRefresh();
  }

  @override
  void onClose() {
    streamSubscription?.cancel();
    super.onClose();
  }

  void addDialog() async {
    if (!UserService.instance.logined.value &&
        !await UserService.instance.login()) {
      return;
    }
    TextEditingController controller = TextEditingController();
    var private = false.obs;
    var result = await Get.dialog(
      AlertDialog(
        title: Text(LocaleKeys.add_statuses_title.tr),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: controller,
              maxLines: 3,
              minLines: 3,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                hintText: LocaleKeys.add_statuses_tip.tr,
              ),
            ),
            Obx(
              () => CheckboxListTile(
                value: private.value,
                contentPadding: EdgeInsets.zero,
                controlAffinity: ListTileControlAffinity.leading,
                title: Text(LocaleKeys.add_statuses_private.tr),
                onChanged: (e) {
                  private.value = e!;
                },
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.back(result: false);
            },
            child: Text(LocaleKeys.dialog_cancel.tr),
          ),
          TextButton(
            onPressed: () {
              Get.back(result: true);
            },
            child: Text(LocaleKeys.dialog_confirm.tr),
          ),
        ],
      ),
    );
    if (!(result ?? false)) {
      return;
    }
    if (controller.text.isEmpty) {
      return;
    }

    sendComment(controller.text, private.value);
  }

  void sendComment(String text, bool private) async {
    try {
      SmartDialog.showLoading(msg: '');
      await request.postStatuses(
        content: text,
        isPrivate: private,
      );
      SmartDialog.showToast(LocaleKeys.add_statuses_success.tr);
    } catch (e) {
      SmartDialog.showToast(e.toString());
    } finally {
      SmartDialog.dismiss(status: SmartStatus.loading);
    }
  }
}
