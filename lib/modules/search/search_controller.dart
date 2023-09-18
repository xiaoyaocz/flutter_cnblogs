import 'package:flutter/material.dart';
import 'package:flutter_cnblogs/app/controller/base_controller.dart';
import 'package:flutter_cnblogs/generated/locales.g.dart';
import 'package:flutter_cnblogs/modules/search/search_list_view_controlelr.dart';
import 'package:flutter_cnblogs/routes/app_navigation.dart';
import 'package:flutter_cnblogs/widgets/number_step_dialog.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AppSearchController extends BaseController
    with GetSingleTickerProviderStateMixin {
  SearchType type;
  final GlobalKey<ScaffoldState> scaffoldkey = GlobalKey();
  final TextEditingController searchTextController = TextEditingController();
  late TabController tabController;
  AppSearchController(this.type) {
    tabController = TabController(
        length: tabs.length, initialIndex: type.index, vsync: this);
  }

  var startDate = "".obs;
  var endDate = "".obs;
  var view = 0.obs;
  final tabs = [
    LocaleKeys.search_type_blog,
    LocaleKeys.search_type_news,
    LocaleKeys.search_type_question,
    LocaleKeys.search_type_kb,
  ];

  @override
  void onInit() {
    for (var tag in tabs) {
      Get.put(SearchListController(tag), tag: tag);
    }
    tabController.animation?.addListener(tabChanged);
    super.onInit();
  }

  int _currentIndex = 0;
  void tabChanged() {
    var currentIndex = (tabController.animation?.value ?? 0).round();
    if (_currentIndex == currentIndex) {
      return;
    }
    _currentIndex = currentIndex;

    SearchListController controller =
        Get.find<SearchListController>(tag: tabs[_currentIndex]);
    if (controller.list.isEmpty) {
      controller.refreshData();
    }
  }

  void doSearch() {
    var tabIndex = tabController.index;
    setSearchInfo();
    SearchListController controller =
        Get.find<SearchListController>(tag: tabs[tabIndex]);
    controller.refreshData();
  }

  void setSearchInfo() {
    for (var tag in tabs) {
      SearchListController controller =
          Get.find<SearchListController>(tag: tag);
      controller.keyword = searchTextController.text;
      controller.startDate = startDate.value;
      controller.endDate = endDate.value;
      controller.view = view.value;
      controller.list.clear();
    }
  }

  void openDrawer() {
    scaffoldkey.currentState?.openEndDrawer();
  }

  static DateFormat dateFormat = DateFormat("yyyy-MM-dd");
  void setStartDate() async {
    DateTime? result = await Get.dialog(
      DatePickerDialog(
        initialDate: DateTime.now().subtract(const Duration(days: 7)),
        firstDate: DateTime(1990, 1, 1),
        lastDate: DateTime.now(),
      ),
    );
    if (result != null) {
      startDate.value = dateFormat.format(result);
    } else {
      startDate.value = "";
    }
  }

  void setEndDate() async {
    DateTime? result = await Get.dialog(
      DatePickerDialog(
        initialDate: DateTime.now(),
        firstDate: DateTime(1990, 1, 1),
        lastDate: DateTime.now(),
      ),
    );
    if (result != null) {
      endDate.value = dateFormat.format(result);
    } else {
      endDate.value = "";
    }
  }

  void setView() async {
    var result = await Get.dialog(
      NumberStepDialog(
        value: view.value,
        min: 0,
        max: 999999,
      ),
    );
    if (result != null) {
      view.value = result;
    } else {
      view.value = 0;
    }
  }
}
