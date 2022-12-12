import 'package:flutter/material.dart';
import 'package:flutter_cnblogs/app/app_style.dart';
import 'package:flutter_cnblogs/app/utils.dart';
import 'package:flutter_cnblogs/generated/locales.g.dart';
import 'package:flutter_cnblogs/models/statuses/statuses_comment_item_model.dart';
import 'package:flutter_cnblogs/services/user_service.dart';
import 'package:flutter_cnblogs/widgets/net_image.dart';
import 'package:flutter_cnblogs/widgets/statuses_content.dart';
import 'package:get/get.dart';

class StatusesCommentItemWidget extends StatelessWidget {
  final StatusesCommentItemModel item;
  final Function()? onReply;
  final Function()? onDelete;
  const StatusesCommentItemWidget(this.item,
      {this.onReply, this.onDelete, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: AppStyle.edgeInsetsB12,
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
            AppStyle.vGap4,
            StatusesContent(
              content: item.content,
            ),
            AppStyle.vGap4,
            buildStat(),
          ],
        ),
      ),
    );
  }

  Widget buildAuthor() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        NetImage(
          item.userIconUrl,
          borderRadius: 24,
          width: 24,
          height: 24,
        ),
        AppStyle.hGap8,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              item.userDisplayName,
              style: const TextStyle(fontSize: 14),
            ),
          ],
        )
      ],
    );
  }

  Widget buildStat() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          Utils.parseTime(item.postDateTime),
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        ),
        const Expanded(child: Center()),
        Visibility(
          visible: item.userId == UserService.instance.userId,
          child: InkWell(
            onTap: onDelete,
            child: Text(
              LocaleKeys.statuses_detail_delete.tr,
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ),
        ),
        AppStyle.hGap12,
        InkWell(
          onTap: onReply,
          child: Text(
            LocaleKeys.statuses_detail_reply.tr,
            style: const TextStyle(fontSize: 14, color: Colors.grey),
          ),
        ),
      ],
    );
  }
}
