import 'package:flutter/material.dart';
import 'package:flutter_cnblogs/app/app_style.dart';
import 'package:flutter_cnblogs/modules/user/blogs/user_blogs_controller.dart';
import 'package:flutter_cnblogs/widgets/items/blog_item_widget.dart';

import 'package:flutter_cnblogs/widgets/page_list_view.dart';
import 'package:get/get.dart';

class UserBlogsPage extends StatelessWidget {
  final String blogApp;
  const UserBlogsPage(this.blogApp, {Key? key}) : super(key: key);
  UserBlogsController get controller => Get.put(
        UserBlogsController(blogApp),
        tag: blogApp,
      );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(
          () => Text(controller.name.value),
        ),
      ),
      body: PageListView(
        pageController: controller,
        padding: AppStyle.edgeInsetsV8,
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
