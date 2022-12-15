import 'package:flutter/material.dart';
import 'package:flutter_cnblogs/app/app_style.dart';
import 'package:flutter_cnblogs/generated/locales.g.dart';

import 'package:flutter_cnblogs/modules/questions/comment/answer_comment_controller.dart';
import 'package:flutter_cnblogs/widgets/items/answer_comment_item_widget.dart';
import 'package:flutter_cnblogs/widgets/page_list_view.dart';
import 'package:get/get.dart';

class AnswerCommentPage extends GetView<AnswerCommentController> {
  const AnswerCommentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.blog_comment_title.tr),
      ),
      body: PageListView(
        pageController: controller,
        padding: AppStyle.edgeInsetsA12,
        firstRefresh: true,
        separatorBuilder: ((context, index) {
          return AppStyle.vGap12;
        }),
        itemBuilder: (_, i) {
          var item = controller.list[i];
          return AnswerCommentItemWidget(item);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: controller.showAddCommentDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}
