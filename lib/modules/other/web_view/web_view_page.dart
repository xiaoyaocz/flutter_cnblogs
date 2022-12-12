import 'package:flutter/material.dart';
import 'package:flutter_cnblogs/modules/other/web_view/web_view_controller.dart';
import 'package:flutter_cnblogs/widgets/status/app_error_widget.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class WebViewPage extends GetView<AppWebViewController> {
  const WebViewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text(controller.title.value)),
      ),
      body: Stack(
        children: [
          Obx(
            () => Offstage(
              offstage: controller.pageError.value,
              child: InAppWebView(
                key: controller.webViewkey,
                initialUrlRequest: URLRequest(url: Uri.parse(controller.url)),
                initialOptions: controller.webViewGroupOptions,
                onWebViewCreated: controller.onWebViewCreated,
                onLoadStart: controller.onLoadStart,
                onLoadError: controller.onLoadError,
                onLoadStop: controller.onLoadStop,
                onTitleChanged: controller.onTitleChanged,
                shouldOverrideUrlLoading: (controller, navigationAction) async {
                  var uri = navigationAction.request.url!;

                  if (![
                    "http",
                    "https",
                    "file",
                    "chrome",
                    "data",
                    "javascript",
                    "about"
                  ].contains(uri.scheme)) {
                    return NavigationActionPolicy.CANCEL;
                  }

                  return NavigationActionPolicy.ALLOW;
                },
              ),
            ),
          ),
          Obx(
            () => Offstage(
              offstage: !controller.pageError.value,
              child: AppErrorWidget(
                errorMsg: controller.errorMsg.value,
                onRefresh: () => controller.refreshWeb(),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Stack(
        children: [
          BottomAppBar(
            child: SizedBox(
              height: 56,
              child: Row(
                children: [
                  Expanded(
                    child: IconButton(
                      onPressed: () {
                        controller.webViewController?.goBack();
                      },
                      icon: const Icon(
                        Icons.chevron_left,
                      ),
                    ),
                  ),
                  Expanded(
                    child: IconButton(
                      onPressed: () {
                        controller.webViewController?.reload();
                      },
                      icon: const Icon(
                        Icons.refresh,
                      ),
                    ),
                  ),
                  Expanded(
                    child: IconButton(
                      onPressed: () {
                        controller.webViewController?.goForward();
                      },
                      icon: const Icon(
                        Icons.chevron_right,
                      ),
                    ),
                  ),
                  Expanded(
                    child: IconButton(
                      onPressed: () async {
                        Share.share(
                            (await controller.webViewController?.getUrl())
                                .toString());
                      },
                      icon: const Icon(
                        Icons.share,
                        size: 20,
                      ),
                    ),
                  ),
                  Expanded(
                    child: IconButton(
                      onPressed: () async {
                        var url = await controller.webViewController?.getUrl();
                        if (url != null) {
                          launchUrl(url, mode: LaunchMode.externalApplication);
                        }
                      },
                      icon: const Icon(
                        Icons.open_in_browser,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned.fill(
            top: 0,
            left: 0,
            child: Obx(
              () => Offstage(
                offstage: !controller.pageLoadding.value,
                child: Container(
                  alignment: Alignment.topLeft,
                  child: const LinearProgressIndicator(),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
