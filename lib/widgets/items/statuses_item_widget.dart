import 'package:flutter/material.dart';
import 'package:flutter_cnblogs/app/app_style.dart';
import 'package:flutter_cnblogs/app/utils.dart';
import 'package:flutter_cnblogs/generated/locales.g.dart';
import 'package:flutter_cnblogs/models/statuses/statuses_list_item_model.dart';
import 'package:flutter_cnblogs/routes/app_navigation.dart';
import 'package:flutter_cnblogs/services/user_service.dart';
import 'package:flutter_cnblogs/widgets/net_image.dart';
import 'package:flutter_cnblogs/widgets/statuses_content.dart';
import 'package:get/get.dart';
import 'package:remixicon/remixicon.dart';

class StatusesItemWidget extends StatelessWidget {
  final StatusesListItemModel item;
  final Function()? onDelete;
  const StatusesItemWidget(
    this.item, {
    this.onDelete,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: AppStyle.edgeInsetsB8,
      child: InkWell(
        borderRadius: AppStyle.radius4,
        onTap: () {
          AppNavigator.toStatusesDetail(item.id);
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: AppStyle.radius4,
            color: Theme.of(context).cardColor,
          ),
          padding: AppStyle.edgeInsetsA12,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildAuthor(),
              AppStyle.vGap12,
              StatusesContent(
                content: item.content,
                luckyIndex: item.luckyIndex,
                isLucky: item.isLucky,
              ),
              AppStyle.vGap12,
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Visibility(
                    visible: item.userId == UserService.instance.userId,
                    child: InkWell(
                      onTap: onDelete,
                      child: Text(
                        LocaleKeys.statuses_detail_delete.tr,
                        style:
                            const TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                    ),
                  ),
                  const Expanded(child: SizedBox()),
                  buildStat(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildAuthor() {
    return InkWell(
      onTap: () {
        AppNavigator.toWebView('https://home.cnblogs.com/u/${item.userId}/');
      },
      borderRadius: AppStyle.radius4,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          NetImage(
            item.userIconUrl,
            borderRadius: 24,
            width: 40,
            height: 40,
          ),
          AppStyle.hGap8,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.userDisplayName,
                style: const TextStyle(fontSize: 14),
              ),
              Text(
                Utils.parseTime(item.postDateTime),
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget buildStat() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(
          Remix.message_2_line,
          size: 20,
          color: Colors.grey,
        ),
        AppStyle.hGap8,
        Text(
          item.commentCount.toString(),
          style: const TextStyle(fontSize: 14, color: Colors.grey),
        ),
      ],
    );
  }
}
