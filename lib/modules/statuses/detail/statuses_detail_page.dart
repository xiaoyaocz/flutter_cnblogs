import 'package:flutter/material.dart';
import 'package:flutter_cnblogs/app/app_style.dart';
import 'package:flutter_cnblogs/generated/locales.g.dart';
import 'package:flutter_cnblogs/modules/statuses/detail/statuses_detail_controller.dart';
import 'package:flutter_cnblogs/widgets/status/app_empty_widget.dart';
import 'package:flutter_cnblogs/widgets/status/app_error_widget.dart';
import 'package:flutter_cnblogs/widgets/status/app_loadding_widget.dart';
import 'package:flutter_cnblogs/widgets/status/app_not_login_widget.dart';
import 'package:flutter_cnblogs/widgets/items/statuses_comment_item_widget.dart';
import 'package:flutter_cnblogs/widgets/items/statuses_item_widget.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:get/get.dart';
import 'package:sticky_headers/sticky_headers.dart';

class StatusesDetailPage extends GetView<StatusesDetailController> {
  const StatusesDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.statuses_detail_title.tr),
      ),
      body: Obx(
        () => EasyRefresh(
          onRefresh: controller.refreshData,
          header: MaterialHeader(),
          child: ListView(
            padding: AppStyle.edgeInsetsA12,
            children: [
              SizedBox(
                child: controller.detail.value != null
                    ? StatusesItemWidget(
                        controller.detail.value!,
                        onDelete: controller.delete,
                      )
                    : null,
              ),
              StickyHeader(
                header: Container(
                  padding: AppStyle.edgeInsetsV12.copyWith(left: 4),
                  color: Theme.of(context).scaffoldBackgroundColor,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    LocaleKeys.statuses_detail_comment_title.trParams({
                      "count": (controller.detail.value?.commentCount ?? 0)
                          .toString(),
                    }),
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                content: Stack(
                  children: [
                    ListView.builder(
                      itemCount: controller.list.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (_, i) {
                        var item = controller.list[i];
                        return StatusesCommentItemWidget(
                          item,
                          onReply: () {
                            controller.showAddCommentDialog(item: item);
                          },
                          onDelete: () {
                            controller.deleteComment(item);
                          },
                        );
                      },
                    ),
                    Offstage(
                      offstage: !controller.pageLoadding.value,
                      child: const AppLoaddingWidget(),
                    ),
                    Offstage(
                      offstage: !controller.pageEmpty.value,
                      child: AppEmptyWidget(
                        onRefresh: () => controller.refreshData(),
                      ),
                    ),
                    Offstage(
                      offstage: !controller.pageError.value,
                      child: AppErrorWidget(
                        onRefresh: () => controller.refreshData(),
                      ),
                    ),
                    Offstage(
                      offstage: !controller.notLogin.value,
                      child: const AppNotLoginWidget(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => controller.showAddCommentDialog(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
