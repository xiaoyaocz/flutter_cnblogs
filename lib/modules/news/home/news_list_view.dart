import 'package:flutter/material.dart';
import 'package:flutter_cnblogs/app/app_style.dart';
import 'package:flutter_cnblogs/modules/news/home/news_list_controller.dart';
import 'package:flutter_cnblogs/widgets/keep_alive_wrapper.dart';
import 'package:flutter_cnblogs/widgets/items/news_item_widget.dart';
import 'package:flutter_cnblogs/widgets/page_list_view.dart';
import 'package:get/get.dart';

class NewsListView extends StatelessWidget {
  final String tag;
  const NewsListView(this.tag, {Key? key}) : super(key: key);
  NewsListController get controller => Get.find<NewsListController>(tag: tag);
  @override
  Widget build(BuildContext context) {
    return KeepAliveWrapper(
      child: PageListView(
        pageController: controller,
        padding: AppStyle.edgeInsetsA4,
        firstRefresh: true,
        itemBuilder: (_, i) {
          var item = controller.list[i];
          return NewsItemWidget(
            item,
          );
        },
        separatorBuilder: ((context, index) => Divider(
              height: 12,
              color: Colors.grey.withOpacity(.2),
              endIndent: 8,
              indent: 8,
            )),
      ),
    );
  }
}
