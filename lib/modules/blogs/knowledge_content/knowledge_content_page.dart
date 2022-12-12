import 'package:flutter/material.dart';
import 'package:flutter_cnblogs/generated/locales.g.dart';
import 'package:flutter_cnblogs/modules/blogs/knowledge_content/knowledge_content_controller.dart';
import 'package:flutter_cnblogs/widgets/status/app_error_widget.dart';
import 'package:flutter_cnblogs/widgets/status/app_loadding_widget.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';

class KnowledgeContentPage extends GetView<KnowledgeContentController> {
  const KnowledgeContentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(controller.item.title),
        centerTitle: false,
        actions: [
          PopupMenuButton(
            itemBuilder: ((context) => [
                  PopupMenuItem(
                    onTap: controller.openBrowser,
                    child: Text(LocaleKeys.blog_content_browser.tr),
                  ),
                  PopupMenuItem(
                    onTap: controller.share,
                    child: Text(LocaleKeys.blog_content_share.tr),
                  ),
                ]),
            child: const SizedBox(
              width: 48,
              height: 48,
              child: Icon(Icons.more_vert),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          InAppWebView(
            key: controller.webViewkey,
            initialOptions: controller.webViewGroupOptions,
            onWebViewCreated: controller.onWebViewCreated,
            shouldOverrideUrlLoading: controller.shouldOverrideUrlLoading,
          ),
          Obx(
            () => Offstage(
              offstage: !controller.pageLoadding.value,
              child: const AppLoaddingWidget(),
            ),
          ),
          Obx(
            () => Offstage(
              offstage: !controller.pageError.value,
              child: AppErrorWidget(
                errorMsg: controller.errorMsg.value,
                onRefresh: () => controller.loadData(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
