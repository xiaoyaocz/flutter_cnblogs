import 'package:flutter/material.dart';
import 'package:flutter_cnblogs/generated/locales.g.dart';
import 'package:flutter_cnblogs/modules/user/login/login_controller.dart';
import 'package:flutter_cnblogs/widgets/status/app_error_widget.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.login_title.tr),
      ),
      body: Stack(
        children: [
          Obx(
            () => Offstage(
              offstage: controller.pageError.value,
              child: InAppWebView(
                key: controller.webViewkey,
                initialOptions: controller.webViewGroupOptions,
                onWebViewCreated: controller.onWebViewCreated,
                onLoadStart: controller.onLoadStart,
                onLoadError: controller.onLoadError,
                onLoadStop: controller.onLoadStop,
                shouldOverrideUrlLoading: controller.shouldOverrideUrlLoading,
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
          ),
        ],
      ),
    );
  }
}
