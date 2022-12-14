import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_cnblogs/app/controller/base_controller.dart';
import 'package:flutter_cnblogs/app/event_bus.dart';
import 'package:flutter_cnblogs/generated/locales.g.dart';
import 'package:flutter_cnblogs/modules/blogs/home/blogs_list_controller.dart';
import 'package:flutter_cnblogs/modules/blogs/home/knowledge/blogs_knowledge_controller.dart';

import 'package:flutter_cnblogs/requests/blogs_request.dart';
import 'package:flutter_cnblogs/routes/app_navigation.dart';
import 'package:get/get.dart';

class BlogsHomeController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final BlogsRequest blogsRequest = BlogsRequest();
  late TabController tabController;
  BlogsHomeController() {
    tabController = TabController(length: tabs.length, vsync: this);
  }

  final tabs = [
    LocaleKeys.blogs_home_new,
    LocaleKeys.blogs_home_mostread,
    LocaleKeys.blogs_home_mostliked,
    LocaleKeys.blogs_home_picked,
    LocaleKeys.blogs_home_knowledge,
  ];

  StreamSubscription<dynamic>? streamSubscription;

  @override
  void onInit() {
    streamSubscription = EventBus.instance.listen(
      EventBus.kBottomNavigationBarClicked,
      (index) {
        if (index == 0) {
          refreshOrScrollTop();
        }
      },
    );
    for (var tag in tabs) {
      if (tag == LocaleKeys.blogs_home_knowledge) {
        Get.put(BlogsKnowledgeController());
      } else {
        Get.put(BlogsListController(tag), tag: tag);
      }
    }

    super.onInit();
  }

  void refreshOrScrollTop() {
    var tabIndex = tabController.index;
    BasePageController controller;
    if (tabIndex == 4) {
      controller = Get.find<BlogsKnowledgeController>();
    } else {
      controller = Get.find<BlogsListController>(tag: tabs[tabIndex]);
    }
    controller.scrollToTopOrRefresh();
  }

  void toSearch() {
    AppNavigator.toSearch(SearchType.blog);
  }

  @override
  void onClose() {
    streamSubscription?.cancel();
    super.onClose();
  }
}
