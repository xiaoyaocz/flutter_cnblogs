import 'package:flutter/material.dart';
import 'package:flutter_cnblogs/app/app_style.dart';
import 'package:flutter_cnblogs/generated/locales.g.dart';
import 'package:flutter_cnblogs/routes/route_path.dart';
import 'package:get/get.dart';

class AppNotLoginWidget extends StatelessWidget {
  final Function()? onLoginSuccess;

  const AppNotLoginWidget({this.onLoginSuccess, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: AppStyle.edgeInsetsA12,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              LocaleKeys.state_not_login.tr,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
            AppStyle.vGap12,
            ElevatedButton(
              onPressed: () async {
                var result = await Get.toNamed(RoutePath.kUserLogin);
                if (result != null && result) {
                  onLoginSuccess?.call();
                }
              },
              child: Text(LocaleKeys.login_title.tr),
            ),
          ],
        ),
      ),
    );
  }
}
