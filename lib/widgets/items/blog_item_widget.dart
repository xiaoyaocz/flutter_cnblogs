import 'package:flutter/material.dart';
import 'package:flutter_cnblogs/app/app_style.dart';
import 'package:flutter_cnblogs/app/utils.dart';
import 'package:flutter_cnblogs/generated/locales.g.dart';
import 'package:flutter_cnblogs/models/blogs/blog_list_item_model.dart';
import 'package:flutter_cnblogs/routes/app_navigation.dart';
import 'package:flutter_cnblogs/widgets/net_image.dart';
import 'package:get/get.dart';
import 'package:remixicon/remixicon.dart';

class BlogItemWidget extends StatelessWidget {
  final BlogListItemModel item;

  const BlogItemWidget(this.item, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: AppStyle.edgeInsetsB8,
      child: Material(
        color: Theme.of(context).cardColor,
        borderRadius: AppStyle.radius4,
        child: InkWell(
          onTap: () {
            AppNavigator.toBlogContent(
              url: item.url,
            );
          },
          borderRadius: AppStyle.radius4,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: AppStyle.radius4,
            ),
            padding: AppStyle.edgeInsetsA12,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: const TextStyle(fontSize: 16),
                ),
                AppStyle.vGap8,
                Text(
                  LocaleKeys.blogs_home_posttime.trParams({
                    "time": Utils.parseTime(item.postDateTime),
                  }),
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
                AppStyle.vGap8,
                Text(
                  item.description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
                AppStyle.vGap8,
                Row(
                  children: [
                    buildAuthor(),
                    const Expanded(child: SizedBox()),
                    buildStat(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildAuthor() {
    return InkWell(
      onTap: () {
        AppNavigator.toUserBlog(item.blogapp);
      },
      borderRadius: AppStyle.radius4,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          NetImage(
            item.avatar,
            borderRadius: 24,
            width: 24,
            height: 24,
          ),
          AppStyle.hGap8,
          Text(
            item.author,
            style: const TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget buildStat() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(
          Remix.eye_line,
          size: 16,
          color: Colors.grey,
        ),
        AppStyle.hGap4,
        Text(
          item.viewcount.toString(),
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        ),
        AppStyle.hGap16,
        const Icon(
          Remix.thumb_up_line,
          size: 16,
          color: Colors.grey,
        ),
        AppStyle.hGap4,
        Text(
          item.diggcount.toString(),
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        ),
        AppStyle.hGap16,
        const Icon(
          Remix.message_2_line,
          size: 16,
          color: Colors.grey,
        ),
        AppStyle.hGap4,
        Text(
          item.commentcount.toString(),
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        ),
      ],
    );
  }
}
