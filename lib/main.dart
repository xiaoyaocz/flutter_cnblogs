import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cnblogs/app/controller/app_settings_controller.dart';
import 'package:flutter_cnblogs/app/app_style.dart';
import 'package:flutter_cnblogs/app/utils.dart';
import 'package:flutter_cnblogs/generated/locales.g.dart';
import 'package:flutter_cnblogs/modules/other/debug_log_page.dart';
import 'package:flutter_cnblogs/requests/base/api.dart';
import 'package:flutter_cnblogs/routes/app_pages.dart';
import 'package:flutter_cnblogs/routes/route_path.dart';
import 'package:flutter_cnblogs/services/api_service.dart';
import 'package:flutter_cnblogs/services/local_storage_service.dart';
import 'package:flutter_cnblogs/services/user_service.dart';
import 'package:flutter_cnblogs/widgets/status/app_loadding_widget.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'app/log.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  //初始化服务
  await initServices();
  //设置状态栏为透明
  SystemUiOverlayStyle systemUiOverlayStyle = const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
  );
  SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  runZonedGuarded(
    () {
      runApp(const MyApp());
    },
    (error, stackTrace) {
      //全局异常
      Log.e(error.toString(), stackTrace);
    },
  );
}

Future initServices() async {
  //读取环境变量,初始化密钥
  await dotenv.load(fileName: ".env");
  Api.kClientID = dotenv.env['CLIENT_ID'] ?? "";
  Api.kClientSecret = dotenv.env['CLIENT_SECRET'] ?? "";

  //包信息
  Utils.packageInfo = await PackageInfo.fromPlatform();
  //本地存储
  Log.d("Init LocalStorage Service");
  await Get.put(LocalStorageService()).init();

  //Api服务
  Get.put(ApiService()).init();

  //用户信息
  Log.d("Init User Service");
  Get.put(UserService()).init();

  //初始化设置控制器
  Get.put(AppSettingsController());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: LocaleKeys.app_name.tr,
      theme: AppStyle.lightTheme,
      darkTheme: AppStyle.darkTheme,
      themeMode:
          ThemeMode.values[Get.find<AppSettingsController>().themeMode.value],
      initialRoute: RoutePath.kIndex,
      getPages: AppPages.routes,
      //国际化
      locale: Get.find<AppSettingsController>().locale,
      fallbackLocale: AppSettingsController.zhLocale,
      translationsKeys: AppTranslation.translations,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        AppSettingsController.zhLocale,
        AppSettingsController.enLocale,
      ],
      logWriterCallback: (text, {bool? isError}) {
        Log.addDebugLog(text, (isError ?? false) ? Colors.red : Colors.grey);
      },
      //debugShowCheckedModeBanner: false,
      navigatorObservers: [FlutterSmartDialog.observer],
      builder: FlutterSmartDialog.init(
        loadingBuilder: ((msg) => const AppLoaddingWidget()),
        //字体大小不跟随系统变化
        builder: (context, child) => MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          child: Stack(
            children: [
              child!,
              //查看DEBUG日志按钮
              //只在Debug、Profile模式显示
              Visibility(
                visible: !kReleaseMode,
                child: Positioned(
                  right: 12,
                  bottom: 100 + context.mediaQueryViewPadding.bottom,
                  child: Opacity(
                    opacity: 0.4,
                    child: ElevatedButton(
                      child: const Text("DEBUG LOG"),
                      onPressed: () {
                        Get.bottomSheet(
                          const DebugLogPage(),
                        );
                        //Get.toNamed(RoutePath.kDebugLog);
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
