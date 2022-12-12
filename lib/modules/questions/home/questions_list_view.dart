import 'package:flutter/material.dart';
import 'package:flutter_cnblogs/app/app_style.dart';
import 'package:flutter_cnblogs/modules/questions/home/questions_list_controller.dart';
import 'package:flutter_cnblogs/widgets/keep_alive_wrapper.dart';
import 'package:flutter_cnblogs/widgets/page_list_view.dart';
import 'package:flutter_cnblogs/widgets/items/question_item_widget.dart';
import 'package:get/get.dart';

class QuestionsListView extends StatelessWidget {
  final String tag;
  const QuestionsListView(this.tag, {Key? key}) : super(key: key);
  QuestionsListController get controller =>
      Get.find<QuestionsListController>(tag: tag);
  @override
  Widget build(BuildContext context) {
    return KeepAliveWrapper(
      child: PageListView(
        pageController: controller,
        padding: AppStyle.edgeInsetsA4,
        firstRefresh: true,
        itemBuilder: (_, i) {
          var item = controller.list[i];
          return QuestionItemWidget(
            item,
          );
        },
      ),
    );
  }
}
