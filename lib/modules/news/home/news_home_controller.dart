import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_cnblogs/app/controller/base_controller.dart';
import 'package:flutter_cnblogs/app/event_bus.dart';
import 'package:flutter_cnblogs/generated/locales.g.dart';
import 'package:flutter_cnblogs/modules/news/home/news_list_controller.dart';
import 'package:flutter_cnblogs/routes/app_navigation.dart';

import 'package:get/get.dart';

class NewsHomeController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;
  NewsHomeController() {
    tabController = TabController(length: tabs.length, vsync: this);
  }
  final tabs = [
    LocaleKeys.news_home_new,
    LocaleKeys.news_home_recommended,
    LocaleKeys.news_home_hot,
    LocaleKeys.news_home_hot_week,
  ];
  StreamSubscription<dynamic>? streamSubscription;
  @override
  void onInit() {
    streamSubscription = EventBus.instance.listen(
      EventBus.kBottomNavigationBarClicked,
      (index) {
        if (index == 1) {
          refreshOrScrollTop();
        }
      },
    );
    for (var tag in tabs) {
      Get.put(NewsListController(tag), tag: tag);
    }

    super.onInit();
  }

  void refreshOrScrollTop() {
    var tabIndex = tabController.index;
    BasePageController controller =
        Get.find<NewsListController>(tag: tabs[tabIndex]);

    controller.scrollToTopOrRefresh();
  }

  void toSearch() {
    AppNavigator.toSearch(SearchType.news);
  }

  @override
  void onClose() {
    streamSubscription?.cancel();
    super.onClose();
  }
}
