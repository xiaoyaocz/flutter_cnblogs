import 'package:flutter/material.dart';
import 'package:flutter_cnblogs/app/app_style.dart';
import 'package:flutter_cnblogs/app/utils.dart';
import 'package:flutter_cnblogs/generated/locales.g.dart';
import 'package:flutter_cnblogs/models/blogs/knowledge_list_item_model.dart';
import 'package:flutter_cnblogs/models/news/news_list_item_model.dart';
import 'package:flutter_cnblogs/models/search/search_item_model.dart';
import 'package:flutter_cnblogs/modules/search/search_list_view_controlelr.dart';
import 'package:flutter_cnblogs/routes/app_navigation.dart';
import 'package:flutter_cnblogs/widgets/keep_alive_wrapper.dart';
import 'package:flutter_cnblogs/widgets/page_list_view.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:remixicon/remixicon.dart';

class SearchListView extends StatelessWidget {
  final String tag;
  const SearchListView(this.tag, {Key? key}) : super(key: key);
  SearchListController get controller =>
      Get.find<SearchListController>(tag: tag);
  @override
  Widget build(BuildContext context) {
    return KeepAliveWrapper(
      child: PageListView(
        pageController: controller,
        padding: AppStyle.edgeInsetsA4,
        firstRefresh: false,
        showPageLoadding: true,
        itemBuilder: (_, i) {
          var item = controller.list[i];
          if (tag == LocaleKeys.search_type_blog) {
            return buildBlogItem(item);
          } else if (tag == LocaleKeys.search_type_news) {
            return buildNewsItem(item);
          } else if (tag == LocaleKeys.search_type_question) {
            return buildQuestionItem(item);
          } else if (tag == LocaleKeys.search_type_kb) {
            return buildKbItem(item);
          }
          return ListTile(
            title: Html(
              data: item.title ?? '',
            ),
          );
        },
      ),
    );
  }

  Widget buildBlogItem(SearchItemModel item) {
    return Container(
      margin: AppStyle.edgeInsetsB8,
      child: Material(
        color: Get.theme.cardColor,
        borderRadius: AppStyle.radius4,
        child: InkWell(
          onTap: () {
            AppNavigator.toBlogContent(
              url: item.uri ?? '',
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
                buildTitle(item.title ?? ""),
                AppStyle.vGap8,
                Text(
                  LocaleKeys.blogs_home_posttime.trParams({
                    "time": Utils.parseTime(item.postDateTime),
                  }),
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
                AppStyle.vGap8,
                buildContent(item.content ?? ""),
                AppStyle.vGap8,
                Row(
                  children: [
                    Text(
                      item.userName ?? "",
                      style: const TextStyle(fontSize: 12),
                    ),
                    const Expanded(child: SizedBox()),
                    const Icon(
                      Remix.eye_line,
                      size: 16,
                      color: Colors.grey,
                    ),
                    AppStyle.hGap4,
                    Text(
                      item.viewTimes.toString(),
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
                      item.voteTimes.toString(),
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
                      item.commentTimes.toString(),
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildNewsItem(SearchItemModel item) {
    return Container(
      margin: AppStyle.edgeInsetsB8,
      child: Material(
        color: Get.theme.cardColor,
        borderRadius: AppStyle.radius4,
        child: InkWell(
          onTap: () {
            var id = int.parse(item.id ?? '');
            AppNavigator.toNewsContent(
              NewsListItemModel(
                id: id,
                title: (item.title ?? "")
                    .replaceAll("<strong>", "")
                    .replaceAll("</strong>", ""),
                summary: (item.content ?? "")
                    .replaceAll("<strong>", "")
                    .replaceAll("</strong>", ""),
                topicId: 0,
                viewCount: item.viewTimes,
                commentCount: item.commentTimes,
                diggCount: item.voteTimes,
                dateAdded: item.publishTime,
              ),
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
                buildTitle(item.title ?? ""),
                AppStyle.vGap8,
                Text(
                  LocaleKeys.blogs_home_posttime.trParams({
                    "time": Utils.parseTime(item.postDateTime),
                  }),
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
                AppStyle.vGap8,
                buildContent(item.content ?? ""),
                AppStyle.vGap8,
                Row(
                  children: [
                    const Icon(
                      Remix.eye_line,
                      size: 16,
                      color: Colors.grey,
                    ),
                    AppStyle.hGap4,
                    Text(
                      item.viewTimes.toString(),
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildQuestionItem(SearchItemModel item) {
    return Container(
      margin: AppStyle.edgeInsetsB8,
      child: Material(
        color: Get.theme.cardColor,
        borderRadius: AppStyle.radius4,
        child: InkWell(
          onTap: () {
            var regex = RegExp(r"https://q.cnblogs.com/q/(\d+)/");
            var match = regex.firstMatch(item.uri ?? "");
            var id = int.tryParse(match?.group(1) ?? "");
            if (id == null) {
              return;
            }
            AppNavigator.toQuestionDetail(id);
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
                buildTitle(item.title ?? ""),
                AppStyle.vGap8,
                Text(
                  LocaleKeys.blogs_home_posttime.trParams({
                    "time": Utils.parseTime(item.postDateTime),
                  }),
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
                AppStyle.vGap8,
                buildContent(item.content ?? ""),
                AppStyle.vGap8,
                Row(
                  children: [
                    Text(
                      item.userName ?? "",
                      style: const TextStyle(fontSize: 12),
                    ),
                    const Expanded(child: SizedBox()),
                    const Icon(
                      Remix.eye_line,
                      size: 16,
                      color: Colors.grey,
                    ),
                    AppStyle.hGap4,
                    Text(
                      item.viewTimes.toString(),
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
                      item.voteTimes.toString(),
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
                      item.commentTimes.toString(),
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildKbItem(SearchItemModel item) {
    return Container(
      margin: AppStyle.edgeInsetsB8,
      child: Material(
        color: Get.theme.cardColor,
        borderRadius: AppStyle.radius4,
        child: InkWell(
          onTap: () {
            var id = int.parse(item.id ?? '');
            AppNavigator.toKnowledgeContent(
              KnowledgeListItemModel(
                id: id,
                title: (item.title ?? "")
                    .replaceAll("<strong>", "")
                    .replaceAll("</strong>", ""),
                summary: (item.content ?? "")
                    .replaceAll("<strong>", "")
                    .replaceAll("</strong>", ""),
                author: item.userName ?? "",
                viewcount: item.viewTimes,
                diggcount: item.voteTimes,
                dateadded: item.publishTime,
              ),
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
                buildTitle(item.title ?? ""),
                AppStyle.vGap8,
                Text(
                  LocaleKeys.blogs_home_posttime.trParams({
                    "time": Utils.parseTime(item.postDateTime),
                  }),
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
                AppStyle.vGap8,
                buildContent(item.content ?? ""),
                AppStyle.vGap8,
                Row(
                  children: [
                    Text(
                      item.userName ?? "",
                      style: const TextStyle(fontSize: 12),
                    ),
                    const Expanded(child: SizedBox()),
                    const Icon(
                      Remix.eye_line,
                      size: 16,
                      color: Colors.grey,
                    ),
                    AppStyle.hGap4,
                    Text(
                      item.viewTimes.toString(),
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTitle(String text) {
    return Html(
      data: text,
      shrinkWrap: true,
      style: {
        "body": Style(
          margin: Margins.zero,
          padding: HtmlPaddings.zero,
          fontSize: FontSize(16),
        ),
      },
      //style: const TextStyle(fontSize: 16),
    );
  }

  Widget buildContent(String text) {
    return Html(
      data: text,
      shrinkWrap: true,
      style: {
        "body": Style(
            margin: Margins.zero,
            padding: HtmlPaddings.zero,
            fontSize: FontSize(14),
            color: Colors.grey,
            maxLines: 2,
            textOverflow: TextOverflow.ellipsis),
      },
    );
  }
}
