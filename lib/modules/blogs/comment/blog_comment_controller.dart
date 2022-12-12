import 'package:flutter/material.dart';
import 'package:flutter_cnblogs/app/controller/base_controller.dart';
import 'package:flutter_cnblogs/generated/locales.g.dart';
import 'package:flutter_cnblogs/models/blogs/blog_comment_item_model.dart';
import 'package:flutter_cnblogs/services/user_service.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';

import '../../../requests/blogs_request.dart';

class BlogCommentController extends BasePageController<BlogCommentItemModel> {
  final String blogApp;
  final int postId;
  BlogCommentController({
    required this.blogApp,
    required this.postId,
  });
  final BlogsRequest blogsRequest = BlogsRequest();

  @override
  Future<List<BlogCommentItemModel>> getData(int page, int pageSize) async {
    return await blogsRequest.getBlogComment(
      pageIndex: page,
      pageSize: pageSize,
      blogApp: blogApp,
      postId: postId,
    );
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
      await blogsRequest.postBlogComment(
        blogApp: blogApp,
        body: text,
        postId: postId,
      );
      refreshData();
    } catch (e) {
      SmartDialog.showToast(e.toString());
    } finally {
      SmartDialog.dismiss(status: SmartStatus.loading);
    }
  }
}
