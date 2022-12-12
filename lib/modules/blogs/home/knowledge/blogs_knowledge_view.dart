import 'package:flutter/material.dart';
import 'package:flutter_cnblogs/app/app_style.dart';
import 'package:flutter_cnblogs/modules/blogs/home/knowledge/blogs_knowledge_controller.dart';
import 'package:flutter_cnblogs/widgets/keep_alive_wrapper.dart';
import 'package:flutter_cnblogs/widgets/items/knowledge_item_widget.dart';
import 'package:flutter_cnblogs/widgets/page_list_view.dart';
import 'package:get/get.dart';

class BlogsKnowledgeView extends GetView<BlogsKnowledgeController> {
  const BlogsKnowledgeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return KeepAliveWrapper(
      child: PageListView(
        pageController: controller,
        padding: AppStyle.edgeInsetsV12,
        firstRefresh: true,
        itemBuilder: (_, i) {
          var item = controller.list[i];
          return KnowledgeItemWidget(
            item,
          );
        },
      ),
    );
  }
}
