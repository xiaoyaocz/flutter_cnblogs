import 'package:flutter/widgets.dart';
import 'package:flutter_cnblogs/app/event_bus.dart';
import 'package:flutter_cnblogs/app/utils.dart';
import 'package:flutter_cnblogs/modules/blogs/home/blogs_home_page.dart';
import 'package:flutter_cnblogs/modules/news/home/news_home_controller.dart';
import 'package:flutter_cnblogs/modules/news/home/news_home_page.dart';
import 'package:flutter_cnblogs/modules/questions/home/questions_home_controller.dart';
import 'package:flutter_cnblogs/modules/questions/home/questions_home_page.dart';
import 'package:flutter_cnblogs/modules/statuses/home/statuses_home_controller.dart';
import 'package:flutter_cnblogs/modules/statuses/home/statuses_home_page.dart';
import 'package:flutter_cnblogs/modules/user/home/user_home_page.dart';
import 'package:get/get.dart';

class IndexedController extends GetxController {
  var index = 0.obs;
  RxList<Widget> pages = RxList<Widget>([
    const BlogsHomePage(),
    const SizedBox(),
    const SizedBox(),
    const SizedBox(),
    const SizedBox(),
  ]);

  void setIndex(i) {
    if (pages[i] is SizedBox) {
      switch (i) {
        case 1:
          Get.put(NewsHomeController());
          pages[i] = const NewsHomePage();
          break;
        case 2:
          Get.put(StatusesHomeController());
          pages[i] = const StatusesHomePage();
          break;
        case 3:
          Get.put(QuestionsHomeController());
          pages[i] = const QuestionsHomePage();
          break;
        case 4:
          pages[i] = const UserHomePage();
          break;
        default:
      }
    }
    if (index.value == i) {
      EventBus.instance.emit<int>(EventBus.kBottomNavigationBarClicked, i);
    }
    index.value = i;
  }

  @override
  void onInit() {
    Utils.checkUpdate();
    super.onInit();
  }
}
