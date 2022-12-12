import 'package:flutter/material.dart';
import 'package:flutter_cnblogs/app/app_style.dart';
import 'package:flutter_cnblogs/modules/blogs/home/blogs_list_controller.dart';
import 'package:flutter_cnblogs/widgets/items/blog_item_widget.dart';
import 'package:flutter_cnblogs/widgets/keep_alive_wrapper.dart';

import 'package:flutter_cnblogs/widgets/page_list_view.dart';
import 'package:get/get.dart';

class BlogsListView extends StatelessWidget {
  final String tag;
  const BlogsListView(this.tag, {Key? key}) : super(key: key);
  BlogsListController get controller => Get.find<BlogsListController>(tag: tag);
  @override
  Widget build(BuildContext context) {
    return KeepAliveWrapper(
      child: PageListView(
        pageController: controller,
        padding: AppStyle.edgeInsetsA4,
        firstRefresh: true,
        itemBuilder: (_, i) {
          var item = controller.list[i];
          return BlogItemWidget(
            item,
          );
        },
      ),
    );
  }
}
