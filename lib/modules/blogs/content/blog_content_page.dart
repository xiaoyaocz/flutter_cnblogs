import 'package:flutter/material.dart';
import 'package:flutter_cnblogs/generated/locales.g.dart';
import 'package:flutter_cnblogs/modules/blogs/content/blog_content_controller.dart';
import 'package:flutter_cnblogs/widgets/status/app_error_widget.dart';
import 'package:flutter_cnblogs/widgets/status/app_loadding_widget.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:remixicon/remixicon.dart';

class BlogContentPage extends StatelessWidget {
  final String url;
  const BlogContentPage({required this.url, Key? key}) : super(key: key);
  //GetView+Tag的方式好像有BUG,手动添加控制器
  BlogContentController get controller => Get.put(
        BlogContentController(
          url: url,
        ),
        tag: url,
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(
          () => Text(
            controller.title.value,
          ),
        ),
        centerTitle: false,
        actions: [
          PopupMenuButton(
            itemBuilder: ((context) => [
                  PopupMenuItem(
                    onTap: controller.openBrowser,
                    child: Text(LocaleKeys.blog_content_browser.tr),
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
                      onPressed: controller.addOrDelBookmark,
                      icon: Obx(
                        () => Icon(
                          controller.bookmarked.value
                              ? Remix.star_fill
                              : Remix.star_line,
                          size: 20,
                        ),
                      ),
                      label: Text(LocaleKeys.blog_content_collect.tr),
                    ),
                  ),
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
