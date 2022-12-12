import 'package:flutter_cnblogs/app/controller/base_controller.dart';
import 'package:flutter_cnblogs/app/utils.dart';
import 'package:flutter_cnblogs/generated/locales.g.dart';
import 'package:flutter_cnblogs/models/statuses/statuses_list_item_model.dart';
import 'package:flutter_cnblogs/requests/statuses_request.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';

class StatusesListController extends BasePageController<StatusesListItemModel> {
  final String title;
  StatusesListController(this.title);
  final StatusesRequest statusesRequest = StatusesRequest();

  @override
  Future<List<StatusesListItemModel>> getData(int page, int pageSize) async {
    if (title == LocaleKeys.statuses_all) {
      return await statusesRequest.getStatuses(
        type: 'all',
        withUserAuth: false,
        pageIndex: page,
      );
    } else if (title == LocaleKeys.statuses_recentcomment) {
      return await statusesRequest.getStatuses(
        type: 'recentcomment',
        withUserAuth: true,
        pageIndex: page,
      );
    } else if (title == LocaleKeys.statuses_comment) {
      return await statusesRequest.getStatuses(
        type: 'comment',
        withUserAuth: true,
        pageIndex: page,
      );
    } else if (title == LocaleKeys.statuses_following) {
      return await statusesRequest.getStatuses(
        type: 'following',
        withUserAuth: true,
        pageIndex: page,
      );
    } else if (title == LocaleKeys.statuses_mention) {
      return await statusesRequest.getStatuses(
        type: 'mention',
        withUserAuth: true,
        pageIndex: page,
      );
    } else if (title == LocaleKeys.statuses_my) {
      return await statusesRequest.getStatuses(
        type: 'my',
        withUserAuth: true,
        pageIndex: page,
      );
    } else if (title == LocaleKeys.statuses_mycomment) {
      return await statusesRequest.getStatuses(
        type: 'mycomment',
        withUserAuth: true,
        pageIndex: page,
      );
    }
    return [];
  }

  @override
  void onLogin() {
    if (title != LocaleKeys.statuses_all) {
      refreshData();
    }

    super.onLogin();
  }

  @override
  void onLogout() {
    if (title != LocaleKeys.statuses_all) {
      refreshData();
    }
    super.onLogout();
  }

  void delete(int id) async {
    try {
      var result = await Utils.showAlertDialog(
        LocaleKeys.statuses_detail_delete_tip.tr,
        title: LocaleKeys.statuses_detail_delete.tr,
      );
      if (!result) {
        return;
      }
      SmartDialog.showLoading(msg: '');
      await statusesRequest.deleteStatuses(
        statusId: id,
      );
      refreshData();
    } catch (e) {
      SmartDialog.showToast(e.toString());
    } finally {
      SmartDialog.dismiss(status: SmartStatus.loading);
    }
  }
}
