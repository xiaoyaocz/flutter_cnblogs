import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_cnblogs/app/controller/base_controller.dart';
import 'package:flutter_cnblogs/app/event_bus.dart';
import 'package:flutter_cnblogs/generated/locales.g.dart';
import 'package:flutter_cnblogs/modules/questions/home/questions_list_controller.dart';

import 'package:get/get.dart';

class QuestionsHomeController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;
  QuestionsHomeController() {
    tabController = TabController(length: tabs.length, vsync: this);
  }
  final tabs = [
    LocaleKeys.questions_home_unsolved,
    LocaleKeys.questions_home_highscore,
    LocaleKeys.questions_home_noanswer,
    LocaleKeys.questions_home_solved,
    LocaleKeys.questions_home_myquestion,
  ];
  StreamSubscription<dynamic>? streamSubscription;
  @override
  void onInit() {
    streamSubscription = EventBus.instance.listen(
      EventBus.kBottomNavigationBarClicked,
      (index) {
        if (index == 3) {
          refreshOrScrollTop();
        }
      },
    );
    for (var tag in tabs) {
      Get.put(QuestionsListController(tag), tag: tag);
    }

    super.onInit();
  }

  void refreshOrScrollTop() {
    var tabIndex = tabController.index;
    BasePageController controller =
        Get.find<QuestionsListController>(tag: tabs[tabIndex]);

    controller.scrollToTopOrRefresh();
  }

  @override
  void onClose() {
    streamSubscription?.cancel();
    super.onClose();
  }
}
