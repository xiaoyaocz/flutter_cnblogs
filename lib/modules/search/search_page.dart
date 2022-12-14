import 'package:flutter/material.dart';
import 'package:flutter_cnblogs/app/app_style.dart';
import 'package:flutter_cnblogs/generated/locales.g.dart';
import 'package:flutter_cnblogs/modules/search/search_controller.dart';
import 'package:flutter_cnblogs/modules/search/search_list_view.dart';
import 'package:get/get.dart';

class SearchPage extends GetView<SearchController> {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: controller.scaffoldkey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        titleSpacing: 8,
        actions: <Widget>[Container()],
        title: TextField(
          controller: controller.searchTextController,
          textInputAction: TextInputAction.search,
          decoration: InputDecoration(
            filled: true,
            fillColor: Theme.of(context).cardColor,
            border: OutlineInputBorder(
              borderRadius: AppStyle.radius8,
              borderSide: BorderSide(
                color: Colors.grey.withOpacity(.2),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: AppStyle.radius8,
              borderSide: BorderSide(
                color: Colors.grey.withOpacity(.2),
              ),
            ),
            contentPadding: EdgeInsets.zero,
            hintText: LocaleKeys.search_hint_text.tr,
            prefixIcon: IconButton(
              onPressed: Get.back,
              icon: const Icon(
                Icons.arrow_back,
              ),
            ),
            suffixIcon: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: controller.openDrawer,
                  icon: const Icon(
                    Icons.filter_alt_outlined,
                  ),
                ),
                IconButton(
                  onPressed: controller.doSearch,
                  icon: const Icon(
                    Icons.search,
                  ),
                ),
              ],
            ),
          ),
          onSubmitted: (e) {
            controller.doSearch();
          },
        ),
        bottom: TabBar(
          controller: controller.tabController,
          tabs: controller.tabs
              .map(
                (e) => Tab(
                  text: e.tr,
                ),
              )
              .toList(),
          padding: AppStyle.edgeInsetsH12,
          labelPadding: AppStyle.edgeInsetsH20,
          isScrollable: false,
          indicatorSize: TabBarIndicatorSize.tab,
        ),
      ),
      endDrawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: Text(LocaleKeys.search_start_date.tr),
              subtitle: Obx(
                () => Text(
                  controller.startDate.isEmpty
                      ? LocaleKeys.search_unlimit.tr
                      : controller.startDate.value,
                ),
              ),
              trailing: const Icon(Icons.chevron_right),
              onTap: controller.setStartDate,
            ),
            ListTile(
              title: Text(LocaleKeys.search_end_date.tr),
              subtitle: Obx(
                () => Text(
                  controller.endDate.isEmpty
                      ? LocaleKeys.search_unlimit.tr
                      : controller.endDate.value,
                ),
              ),
              trailing: const Icon(Icons.chevron_right),
              onTap: controller.setEndDate,
            ),
            ListTile(
              title: Text(LocaleKeys.search_view.tr),
              subtitle: Obx(
                () => Text(
                  controller.view <= 0
                      ? LocaleKeys.search_unlimit.tr
                      : controller.view.value.toString(),
                ),
              ),
              trailing: const Icon(Icons.chevron_right),
              onTap: controller.setView,
            ),
            Padding(
              padding: AppStyle.edgeInsetsA12,
              child: ElevatedButton(
                onPressed: () {
                  Get.back();
                  controller.doSearch();
                },
                child: Text(LocaleKeys.search_research.tr),
              ),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: controller.tabController,
        children: controller.tabs
            .map(
              (e) => SearchListView(
                e,
              ),
            )
            .toList(),
      ),
    );
  }
}
