import 'package:flutter/services.dart';

import 'package:flutter_cnblogs/app/controller/base_webview_controller.dart';
import 'package:flutter_cnblogs/app/utils.dart';
import 'package:flutter_cnblogs/models/news/news_list_item_model.dart';
import 'package:flutter_cnblogs/requests/news_request.dart';
import 'package:flutter_cnblogs/routes/app_navigation.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher_string.dart';

class NewsContentController extends BaseWebViewController {
  final NewsRequest request = NewsRequest();
  final NewsListItemModel item;

  NewsContentController(this.item) {
    commentCount.value = item.commentCount;
  }

  @override
  void onWebViewCreated(InAppWebViewController controller) {
    super.onWebViewCreated(controller);
    loadData();
  }

  var commentCount = 0.obs;
  Future loadData() async {
    try {
      pageError.value = false;
      pageLoadding.value = true;
      var content = await request.getNewsContent(id: item.id);

      var commonScript = await getCommonScript();
      var style = await loadStyle();
      var htmlTemplate = await loadTemplate();
      htmlTemplate = htmlTemplate.replaceAll("@commonJs", commonScript);
      htmlTemplate = htmlTemplate.replaceAll("@style", style);

      htmlTemplate = htmlTemplate.replaceAll("@title", item.title);
      htmlTemplate = htmlTemplate.replaceAll(
          "@puttime", Utils.dateFormatWithYear.format(item.postDateTime));
      htmlTemplate = htmlTemplate.replaceAll("@content", content);
      htmlTemplate = htmlTemplate.replaceAll("@stat",
          "${item.viewCount}浏览&nbsp; &nbsp; ${item.diggCount}推荐&nbsp; &nbsp; ${item.commentCount}评论");
      webViewController?.loadData(
        data: htmlTemplate,
      );
    } catch (e) {
      pageError.value = true;

      errorMsg.value = e.toString();
    } finally {
      pageLoadding.value = false;
    }
  }

  Future<String> loadTemplate() async {
    return await rootBundle.loadString('assets/templates/news/news.html');
  }

  Future<String> loadStyle() async {
    return await rootBundle.loadString(Get.isDarkMode
        ? 'assets/templates/news/dark.css'
        : 'assets/templates/news/light.css');
  }

  void share() {
    Share.share('《${item.title}》\r\nhttps://news.cnblogs.com/n/${item.id}/');
  }

  void openBrowser() {
    launchUrlString(
      'https://news.cnblogs.com/n/${item.id}/',
      mode: LaunchMode.externalApplication,
    );
  }

  void openComment() {
    AppNavigator.toNewsComment(
      newsId: item.id,
    );
  }
}
