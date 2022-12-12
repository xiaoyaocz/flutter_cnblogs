import 'package:flutter/widgets.dart';
import 'package:flutter_cnblogs/app/controller/base_controller.dart';
import 'package:flutter_cnblogs/app/log.dart';
import 'package:flutter_cnblogs/requests/base/api.dart';
import 'package:flutter_cnblogs/requests/oauth_request.dart';
import 'package:flutter_cnblogs/services/user_service.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';

class LoginController extends BaseController {
  final UniqueKey webViewkey = UniqueKey();
  final OAuthRequest request = OAuthRequest();
  late InAppWebViewController? webViewController;
  final InAppWebViewGroupOptions webViewGroupOptions = InAppWebViewGroupOptions(
    crossPlatform: InAppWebViewOptions(
      transparentBackground: true,
      useShouldOverrideUrlLoading: true,
      clearCache: true,
    ),
  );
  void onWebViewCreated(InAppWebViewController controller) async {
    webViewController = controller;
    pageLoadding.value = true;

    goLogin();
  }

  void goLogin() {
    var uri = Uri(
      scheme: "https",
      host: "oauth.cnblogs.com",
      path: "connect/authorize",
      queryParameters: {
        "client_id": Api.kClientID,
        "scope": "openid profile CnBlogsApi offline_access",
        "response_type": "code id_token",
        "redirect_uri": "https://oauth.cnblogs.com/auth/callback",
        "state": DateTime.now().millisecondsSinceEpoch.toString(),
        "nonce": DateTime.now().millisecondsSinceEpoch.toString(),
      },
    );
    webViewController?.loadUrl(urlRequest: URLRequest(url: uri));
  }

  void refreshWeb() {
    webViewController?.reload();
  }

  void onLoadStart(InAppWebViewController controller, Uri? uri) {
    pageLoadding.value = true;
    pageError.value = false;
  }

  void onLoadStop(InAppWebViewController controller, Uri? uri) async {
    pageLoadding.value = false;
  }

  void onLoadError(
      InAppWebViewController controller, Uri? uri, int code, String e) {
    pageLoadding.value = false;
    pageError.value = true;
    errorMsg.value = "$code $e";
  }

  Future<NavigationActionPolicy?> shouldOverrideUrlLoading(
      InAppWebViewController controller, NavigationAction action) async {
    var uri = action.request.url!;
    var url = uri.toString();
    if (url.contains('oauth.cnblogs.com/auth/callback')) {
      var code = RegExp(r"code=(.*?)&").firstMatch(url)?.group(1) ?? "";
      Log.i(code);
      getToken(code);
      return NavigationActionPolicy.CANCEL;
    }

    Log.i(url);
    return NavigationActionPolicy.ALLOW;
  }

  void getToken(String code) async {
    try {
      pageLoadding.value = true;
      var userToken = await request.getUserToken(code);
      UserService.instance.setAuthInfo(userToken);
      Get.back(result: true);
    } catch (e) {
      Log.logPrint(e);
    } finally {
      pageLoadding.value = false;
    }
  }
}
