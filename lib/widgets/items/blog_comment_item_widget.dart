import 'package:flutter/material.dart';
import 'package:flutter_cnblogs/app/app_style.dart';
import 'package:flutter_cnblogs/app/utils.dart';
import 'package:flutter_cnblogs/models/blogs/blog_comment_item_model.dart';
import 'package:flutter_cnblogs/widgets/custom_html.dart';
import 'package:flutter_cnblogs/widgets/net_image.dart';

class BlogCommentItemWidget extends StatelessWidget {
  final BlogCommentItemModel item;
  const BlogCommentItemWidget(this.item, {Key? key}) : super(key: key);

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
          CustomHtml(
            content: item.body,
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
          item.faceUrl.isEmpty
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
                  item.faceUrl,
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
                  item.author,
                  style: const TextStyle(fontSize: 14),
                ),
                Text(
                  Utils.parseTime(item.postDateTime),
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),
          Text(
            "#${item.floor}",
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          )
        ],
      ),
    );
  }
}
