import 'package:flutter/material.dart';
import 'package:flutter_cnblogs/app/controller/base_controller.dart';
import 'package:flutter_cnblogs/app/utils.dart';
import 'package:flutter_cnblogs/generated/locales.g.dart';
import 'package:flutter_cnblogs/models/statuses/statuses_comment_item_model.dart';
import 'package:flutter_cnblogs/models/statuses/statuses_list_item_model.dart';
import 'package:flutter_cnblogs/requests/statuses_request.dart';
import 'package:flutter_cnblogs/services/user_service.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';

class StatusesDetailController
    extends BasePageController<StatusesCommentItemModel> {
  final int id;
  StatusesDetailController(this.id);
  final StatusesRequest request = StatusesRequest();
  Rx<StatusesListItemModel?> detail = Rx<StatusesListItemModel?>(null);
  @override
  Future<List<StatusesCommentItemModel>> getData(int page, int pageSize) async {
    if (page > 1) {
      return [];
    }
    detail.value = await request.getStatusesById(id: id);
    return await request.getStatusesComments(statusId: id);
  }

  @override
  void onLogin() {
    refreshData();
    super.onLogin();
  }

  void showAddCommentDialog({StatusesCommentItemModel? item}) async {
    if (!UserService.instance.logined.value &&
        !await UserService.instance.login()) {
      return;
    }
    TextEditingController controller = TextEditingController();

    var result = await Get.dialog(
      AlertDialog(
        title: Text(item == null
            ? LocaleKeys.add_comment_title.tr
            : LocaleKeys.add_comment_reply.trParams({
                'name': "@${item.userDisplayName}",
              })),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: controller,
              maxLines: 3,
              minLines: 3,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                hintText: LocaleKeys.add_comment_tip.tr,
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
    if (item != null) {
      controller.text =
          '<a href="https://home.cnblogs.com/u/${item.userId}/" target="_blank">@${item.userDisplayName}</a>：${controller.text}';
    }

    sendComment(controller.text, item);
  }

  void sendComment(String text, StatusesCommentItemModel? item) async {
    try {
      SmartDialog.showLoading(msg: '');
      await request.postStatusesComment(
        content: text,
        replyTo: item?.userId ?? 0,
        statusId: id,
        parentCommentId: item?.id ?? 0,
      );
      refreshData();
    } catch (e) {
      SmartDialog.showToast(e.toString());
    } finally {
      SmartDialog.dismiss(status: SmartStatus.loading);
    }
  }

  void deleteComment(StatusesCommentItemModel item) async {
    try {
      var result = await Utils.showAlertDialog(
        LocaleKeys.statuses_detail_delete_comment.tr,
        title: LocaleKeys.statuses_detail_delete.tr,
      );
      if (!result) {
        return;
      }
      SmartDialog.showLoading(msg: '');
      await request.deleteStatusesComment(
        statusId: id,
        commentId: item.id,
      );
      refreshData();
    } catch (e) {
      SmartDialog.showToast(e.toString());
    } finally {
      SmartDialog.dismiss(status: SmartStatus.loading);
    }
  }

  void delete() async {
    try {
      var result = await Utils.showAlertDialog(
        LocaleKeys.statuses_detail_delete_tip.tr,
        title: LocaleKeys.statuses_detail_delete.tr,
      );
      if (!result) {
        return;
      }
      SmartDialog.showLoading(msg: '');
      await request.deleteStatuses(
        statusId: id,
      );
      refreshData();
    } catch (e) {
      SmartDialog.showToast(e.toString());
    } finally {
      SmartDialog.dismiss(status: SmartStatus.loading);
    }
  }
}
