import 'package:flutter/material.dart';
import 'package:flutter_cnblogs/app/app_style.dart';
import 'package:flutter_cnblogs/app/utils.dart';
import 'package:flutter_cnblogs/models/questions/answer_comment_list_item_model.dart';
import 'package:flutter_cnblogs/widgets/net_image.dart';
import 'package:remixicon/remixicon.dart';

class AnswerCommentItemWidget extends StatelessWidget {
  final AnswerCommentListItemModel item;
  const AnswerCommentItemWidget(this.item, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
          Text(
            item.content,
          ),
          AppStyle.vGap12,
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              AppStyle.hGap16,
              const Icon(
                Remix.thumb_up_line,
                size: 16,
                color: Colors.grey,
              ),
              AppStyle.hGap4,
              Text(
                item.diggCount.toString(),
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildAuthor() {
    return InkWell(
      onTap: () {},
      borderRadius: AppStyle.radius4,
      child: Row(
        children: [
          item.postUserInfo.iconName.isEmpty
              ? Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: AppStyle.radius24,
                    border: Border.all(
                      color: Colors.grey.withOpacity(.2),
                    ),
                  ),
                  child: const Icon(
                    Icons.account_circle,
                    color: Colors.grey,
                  ),
                )
              : NetImage(
                  item.postUserInfo.iconName,
                  borderRadius: 24,
                  width: 40,
                  height: 40,
                ),
          AppStyle.hGap8,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.postUserName,
                  style: const TextStyle(fontSize: 14),
                ),
                Text(
                  Utils.parseTime(item.addDateTime),
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
