import 'package:flutter/material.dart';
import 'package:flutter_cnblogs/app/app_style.dart';
import 'package:flutter_cnblogs/app/utils.dart';
import 'package:flutter_cnblogs/models/news/news_list_item_model.dart';
import 'package:flutter_cnblogs/routes/app_navigation.dart';
import 'package:flutter_cnblogs/widgets/net_image.dart';
import 'package:remixicon/remixicon.dart';

class NewsItemWidget extends StatelessWidget {
  final NewsListItemModel item;

  const NewsItemWidget(this.item, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        AppNavigator.toNewsContent(item);
      },
      child: Container(
        padding: AppStyle.edgeInsetsA8,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: AppStyle.radius4,
              ),
              padding: AppStyle.edgeInsetsA12,
              width: 72,
              height: 72,
              child: NetImage(
                item.topicIcon ?? '',
                borderRadius: 4,
                height: 72,
                width: 72,
                fit: BoxFit.contain,
              ),
            ),
            AppStyle.hGap12,
            Expanded(
              child: SizedBox(
                height: 72,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        item.title,
                        style: const TextStyle(fontSize: 16),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          Utils.parseTime(item.postDateTime),
                          style:
                              const TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                        const Expanded(child: SizedBox()),
                        buildStat(),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
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
          item.viewCount.toString(),
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
          item.diggCount.toString(),
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
          item.commentCount.toString(),
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        ),
      ],
    );
  }
}
