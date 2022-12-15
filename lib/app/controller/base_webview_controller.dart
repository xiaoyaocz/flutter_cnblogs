import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cnblogs/app/controller/base_controller.dart';
import 'package:flutter_cnblogs/app/log.dart';
import 'package:flutter_cnblogs/app/utils.dart';
import 'package:flutter_cnblogs/routes/app_navigation.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class BaseWebViewController extends BaseController {
  final UniqueKey webViewkey = UniqueKey();
  late InAppWebViewController? webViewController;
  final InAppWebViewGroupOptions webViewGroupOptions = InAppWebViewGroupOptions(
    crossPlatform: InAppWebViewOptions(
      transparentBackground: true,
      useShouldOverrideUrlLoading: true,
    ),
  );
  void onWebViewCreated(InAppWebViewController controller) {
    webViewController = controller;
    webViewController?.addJavaScriptHandler(
      handlerName: 'showImage',
      callback: (args) {
        openImageViewer(
          args[0].toString(),
          (args[1] as List<dynamic>).map((e) => e as String).toList(),
        );
      },
    );
    webViewController?.addJavaScriptHandler(
      handlerName: 'showAuthor',
      callback: (args) {
        openUserBlogs();
      },
    );
  }

  final RegExp blogRegExp1 = RegExp(r'cnblogs.com/(.*?)/p/(.*?).html');
  final RegExp blogRegExp2 =
      RegExp(r'cnblogs.com/(.*?)/archive/\d+/\d+/\d+/(.*?).html');
  Future<NavigationActionPolicy?> shouldOverrideUrlLoading(
      InAppWebViewController controller, NavigationAction action) async {
    var uri = action.request.url!;
    var url = uri.toString();
    if (url.startsWith("about:blank")) {
      return NavigationActionPolicy.ALLOW;
    }
    if (blogRegExp1.hasMatch(url)) {
      AppNavigator.toBlogContent(url: url);
      return NavigationActionPolicy.CANCEL;
    }

    var match2 = blogRegExp2.firstMatch(url);
    if (match2 != null) {
      String blogApp = match2.group(1)!;
      String blogPostId = match2.group(2)!;
      AppNavigator.toBlogContent(
          url: "http://www.cnblogs.com/$blogApp/p/$blogPostId.html");
      return NavigationActionPolicy.CANCEL;
    }

    Log.i(uri.toString());
    //使用WebView打开
    // launchUrl(uri, mode: LaunchMode.inAppWebView);
    AppNavigator.toWebView(url);
    return NavigationActionPolicy.CANCEL;
  }

  void openImageViewer(String img, List<String> allImgs) {
    Utils.showImageViewer(allImgs.indexOf(img), allImgs);
  }

  Future<String> getHighlightScript() async {
    return await rootBundle.loadString('assets/templates/js/highlight.js');
  }

  Future<String> getCommonScript() async {
    return await rootBundle.loadString('assets/templates/js/common.js');
  }

  void openUserBlogs() {}
}
