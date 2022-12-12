import 'package:flutter/material.dart';
import 'package:flutter_cnblogs/app/app_style.dart';
import 'package:flutter_cnblogs/modules/statuses/home/statuses_home_controller.dart';
import 'package:flutter_cnblogs/modules/statuses/home/statuses_list_view.dart';
import 'package:get/get.dart';

class StatusesHomePage extends GetView<StatusesHomeController> {
  const StatusesHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 8,
        title: Container(
          alignment: Alignment.centerLeft,
          child: TabBar(
            controller: controller.tabController,
            tabs: controller.tabs
                .map(
                  (e) => Tab(
                    text: e.tr,
                  ),
                )
                .toList(),
            labelPadding: AppStyle.edgeInsetsH20,
            isScrollable: true,
            indicatorSize: TabBarIndicatorSize.tab,
          ),
        ),
      ),
      body: TabBarView(
        controller: controller.tabController,
        children: controller.tabs
            .map(
              (e) => StatusesListView(
                e,
              ),
            )
            .toList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: controller.addDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}
