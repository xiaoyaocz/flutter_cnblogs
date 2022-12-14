import 'package:flutter/services.dart';

import 'package:flutter_cnblogs/app/controller/base_webview_controller.dart';
import 'package:flutter_cnblogs/app/utils.dart';
import 'package:flutter_cnblogs/models/blogs/knowledge_list_item_model.dart';
import 'package:flutter_cnblogs/requests/blogs_request.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher_string.dart';

class KnowledgeContentController extends BaseWebViewController {
  final BlogsRequest request = BlogsRequest();
  final KnowledgeListItemModel item;
  KnowledgeContentController(this.item);

  @override
  void onWebViewCreated(InAppWebViewController controller) {
    super.onWebViewCreated(controller);
    loadData();
  }

  Future loadData() async {
    try {
      pageError.value = false;
      pageLoadding.value = true;
      var content = await request.getKnowledgeContent(id: item.id);
      var highlightScript = await getHighlightScript();
      var commonScript = await getCommonScript();

      var style = await loadStyle();
      var htmlTemplate = await loadTemplate();
      htmlTemplate = htmlTemplate.replaceAll("@highlightJs", highlightScript);
      htmlTemplate = htmlTemplate.replaceAll("@commonJs", commonScript);

      htmlTemplate = htmlTemplate.replaceAll("@style", style);

      htmlTemplate = htmlTemplate.replaceAll("@title", item.title);
      htmlTemplate = htmlTemplate.replaceAll("@username", item.author);
      htmlTemplate = htmlTemplate.replaceAll(
          "@puttime", Utils.dateFormatWithYear.format(item.postDateTime));
      htmlTemplate = htmlTemplate.replaceAll(
          "@stat", "${item.viewcount}浏览&nbsp; &nbsp; ${item.diggcount}推荐");
      htmlTemplate = htmlTemplate.replaceAll("@content", content);
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
    return await rootBundle.loadString('assets/templates/blog/knowledge.html');
  }

  Future<String> loadStyle() async {
    return await rootBundle.loadString(Get.isDarkMode
        ? 'assets/templates/blog/dark.css'
        : 'assets/templates/blog/light.css');
  }

  void share() {
    Share.share('《${item.title}》\r\nhttps://kb.cnblogs.com/page/${item.id}/');
  }

  void openBrowser() {
    launchUrlString(
      'https://kb.cnblogs.com/page/${item.id}/',
      mode: LaunchMode.externalApplication,
    );
  }
}
