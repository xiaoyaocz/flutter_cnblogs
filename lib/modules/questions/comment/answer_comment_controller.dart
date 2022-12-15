import 'package:flutter/material.dart';
import 'package:flutter_cnblogs/app/controller/base_controller.dart';
import 'package:flutter_cnblogs/generated/locales.g.dart';
import 'package:flutter_cnblogs/models/questions/answer_comment_list_item_model.dart';
import 'package:flutter_cnblogs/requests/questions_request.dart';
import 'package:flutter_cnblogs/services/user_service.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';

class AnswerCommentController
    extends BasePageController<AnswerCommentListItemModel> {
  final int answerId;
  final int questionId;
  AnswerCommentController({
    required this.answerId,
    required this.questionId,
  });
  final QuestionsRequest request = QuestionsRequest();

  @override
  Future<List<AnswerCommentListItemModel>> getData(
      int page, int pageSize) async {
    if (page > 1) {
      return [];
    }
    return await request.getAnswerComments(answerId: answerId);
  }

  void showAddCommentDialog() async {
    if (!UserService.instance.logined.value &&
        !await UserService.instance.login()) {
      return;
    }
    TextEditingController controller = TextEditingController();
    var result = await Get.dialog(
      AlertDialog(
        title: Text(LocaleKeys.add_comment_title.tr),
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
    sendComment(controller.text);
  }

  void sendComment(String text) async {
    try {
      SmartDialog.showLoading(msg: '');
      await request.postAnswerComment(
        answerId: answerId,
        body: text,
        questionId: questionId,
      );
      refreshData();
    } catch (e) {
      SmartDialog.showToast(e.toString());
    } finally {
      SmartDialog.dismiss(status: SmartStatus.loading);
    }
  }
}
