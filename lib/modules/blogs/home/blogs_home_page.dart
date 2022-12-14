import 'package:flutter/material.dart';
import 'package:flutter_cnblogs/app/app_style.dart';
import 'package:flutter_cnblogs/generated/locales.g.dart';
import 'package:flutter_cnblogs/modules/blogs/home/blogs_home_controller.dart';
import 'package:flutter_cnblogs/modules/blogs/home/blogs_list_view.dart';
import 'package:flutter_cnblogs/modules/blogs/home/knowledge/blogs_knowledge_view.dart';
import 'package:get/get.dart';

class BlogsHomePage extends GetView<BlogsHomeController> {
  const BlogsHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 8,
        title: Container(
          alignment: Alignment.centerLeft,
          child: TabBar(
            controller: controller.tabController,
            padding: EdgeInsets.zero,
            tabs: controller.tabs
                .map(
                  (e) => Tab(
                    text: e.tr,
                  ),
                )
                .toList(),
            labelPadding: AppStyle.edgeInsetsH20,
            isScrollable: true,
            indicatorSize: TabBarIndicatorSize.tab,
          ),
        ),
        actions: [
          IconButton(
            onPressed: controller.toSearch,
            icon: const Icon(Icons.search),
          )
        ],
      ),
      body: TabBarView(
        controller: controller.tabController,
        children: controller.tabs
            .map(
              (e) => e == LocaleKeys.blogs_home_knowledge
                  ? const BlogsKnowledgeView()
                  : BlogsListView(
                      e,
                    ),
            )
            .toList(),
      ),
    );
  }
}
