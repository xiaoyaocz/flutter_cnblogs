import 'package:flutter/material.dart';
import 'package:flutter_cnblogs/app/app_style.dart';
import 'package:flutter_cnblogs/generated/locales.g.dart';
import 'package:flutter_cnblogs/modules/blogs/comment/blog_comment_controller.dart';
import 'package:flutter_cnblogs/widgets/items/blog_comment_item_widget.dart';
import 'package:flutter_cnblogs/widgets/page_list_view.dart';
import 'package:get/get.dart';

class BlogCommentPage extends GetView<BlogCommentController> {
  const BlogCommentPage({Key? key}) : super(key: key);

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
          return BlogCommentItemWidget(item);
        },
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: controller.showAddCommentDialog,
      //   child: const Icon(Icons.add),
      // ),
    );
  }
}
