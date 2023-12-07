import 'package:flutter/material.dart';
import 'package:flutter_cnblogs/generated/locales.g.dart';
import 'package:flutter_cnblogs/modules/news/content/news_content_controller.dart';
import 'package:flutter_cnblogs/widgets/status/app_error_widget.dart';
import 'package:flutter_cnblogs/widgets/status/app_loadding_widget.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:remixicon/remixicon.dart';

class NewsContentPage extends GetView<NewsContentController> {
  const NewsContentPage({Key? key}) : super(key: key);

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
      bottomNavigationBar: Obx(
        () => Visibility(
          visible:
              !controller.pageLoadding.value && !controller.pageError.value,
          child: BottomAppBar(
            child: SizedBox(
              height: 56,
              child: Row(
                children: [
                  Expanded(
                    child: TextButton.icon(
                      onPressed: controller.openComment,
                      icon: const Icon(
                        Remix.message_2_line,
                        size: 20,
                      ),
                      label: Text(controller.commentCount > 0
                          ? controller.commentCount.toString()
                          : LocaleKeys.blog_content_comment.tr),
                    ),
                  ),
                  Expanded(
                    child: TextButton.icon(
                      onPressed: controller.share,
                      icon: const Icon(
                        Remix.share_line,
                        size: 20,
                      ),
                      label: Text(LocaleKeys.blog_content_share.tr),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
