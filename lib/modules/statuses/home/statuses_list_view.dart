import 'package:flutter/material.dart';
import 'package:flutter_cnblogs/app/app_style.dart';
import 'package:flutter_cnblogs/modules/statuses/home/statuses_list_controller.dart';
import 'package:flutter_cnblogs/widgets/keep_alive_wrapper.dart';
import 'package:flutter_cnblogs/widgets/page_list_view.dart';
import 'package:flutter_cnblogs/widgets/items/statuses_item_widget.dart';
import 'package:get/get.dart';

class StatusesListView extends StatelessWidget {
  final String tag;
  const StatusesListView(this.tag, {Key? key}) : super(key: key);
  StatusesListController get controller =>
      Get.find<StatusesListController>(tag: tag);
  @override
  Widget build(BuildContext context) {
    return KeepAliveWrapper(
      child: PageListView(
        pageController: controller,
        padding: AppStyle.edgeInsetsA8,
        firstRefresh: true,
        itemBuilder: (_, i) {
          var item = controller.list[i];
          return StatusesItemWidget(
            item,
            onDelete: () => controller.delete(item.id),
          );
        },
      ),
    );
  }
}
