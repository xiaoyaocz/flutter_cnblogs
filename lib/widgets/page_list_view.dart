import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cnblogs/app/controller/base_controller.dart';
import 'package:flutter_cnblogs/widgets/status/app_empty_widget.dart';
import 'package:flutter_cnblogs/widgets/status/app_error_widget.dart';
import 'package:flutter_cnblogs/widgets/status/app_loadding_widget.dart';
import 'package:flutter_cnblogs/widgets/status/app_not_login_widget.dart';
import 'package:get/get.dart';

typedef IndexedWidgetBuilder = Widget Function(BuildContext context, int index);

class PageListView extends StatelessWidget {
  final BasePageController pageController;
  final IndexedWidgetBuilder itemBuilder;
  final IndexedWidgetBuilder? separatorBuilder;
  final EdgeInsets? padding;
  final bool firstRefresh;
  final Function()? onLoginSuccess;
  final bool showPageLoadding;
  const PageListView({
    required this.itemBuilder,
    required this.pageController,
    this.padding,
    this.firstRefresh = false,
    this.showPageLoadding = false,
    this.separatorBuilder,
    this.onLoginSuccess,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Stack(
        children: [
          EasyRefresh(
            header: const MaterialHeader(),
            footer: const MaterialFooter(
              infiniteOffset: 100,
              clamping: false,
            ),
            controller: pageController.easyRefreshController,
            refreshOnStart: firstRefresh,
            onLoad: pageController.loadData,
            onRefresh: pageController.refreshData,
            child: ListView.separated(
              padding: padding,
              itemCount: pageController.list.length,
              itemBuilder: itemBuilder,
              controller: pageController.scrollController,
              separatorBuilder:
                  separatorBuilder ?? (context, i) => const SizedBox(),
            ),
          ),
          Offstage(
            offstage: !pageController.pageEmpty.value,
            child: AppEmptyWidget(
              onRefresh: () => pageController.refreshData(),
            ),
          ),
          Offstage(
            offstage: !(showPageLoadding && pageController.pageLoadding.value),
            child: const AppLoaddingWidget(),
          ),
          Offstage(
            offstage: !pageController.pageError.value,
            child: AppErrorWidget(
              errorMsg: pageController.errorMsg.value,
              onRefresh: () => pageController.refreshData(),
            ),
          ),
          Offstage(
            offstage: !pageController.notLogin.value,
            child: AppNotLoginWidget(
              onLoginSuccess: onLoginSuccess,
            ),
          ),
        ],
      ),
    );
  }
}
