import 'package:flutter/material.dart';
import 'package:flutter_cnblogs/generated/locales.g.dart';
import 'package:flutter_cnblogs/modules/indexed/indexed_controller.dart';
import 'package:get/get.dart';
import 'package:remixicon/remixicon.dart';

class IndexedPage extends GetView<IndexedController> {
  const IndexedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => IndexedStack(
          index: controller.index.value,
          children: controller.pages,
        ),
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          currentIndex: controller.index.value,
          onTap: controller.setIndex,
          selectedFontSize: 12,
          unselectedFontSize: 12,
          iconSize: 24,
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: true,
          showUnselectedLabels: false,
          elevation: 4,
          items: [
            //博客
            BottomNavigationBarItem(
              icon: const Icon(Remix.home_smile_line),
              activeIcon: const Icon(Remix.home_smile_fill),
              label: LocaleKeys.indexed_blogs.tr,
            ),
            //新闻
            BottomNavigationBarItem(
              icon: const Icon(Remix.article_line),
              activeIcon: const Icon(Remix.article_fill),
              label: LocaleKeys.indexed_news.tr,
            ),
            //闪存
            BottomNavigationBarItem(
              icon: const Icon(Remix.star_smile_line),
              activeIcon: const Icon(Remix.star_smile_fill),
              label: LocaleKeys.indexed_statuses.tr,
            ),
            //博问
            BottomNavigationBarItem(
              icon: const Icon(Remix.question_line),
              activeIcon: const Icon(Remix.question_fill),
              label: LocaleKeys.indexed_questions.tr,
            ),
            //用户
            BottomNavigationBarItem(
              icon: const Icon(Remix.user_smile_line),
              activeIcon: const Icon(Remix.user_smile_fill),
              label: LocaleKeys.indexed_user.tr,
            ),
          ],
        ),
      ),
    );
  }
}
