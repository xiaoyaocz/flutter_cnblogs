import 'package:flutter_cnblogs/app/controller/base_controller.dart';
import 'package:flutter_cnblogs/models/user/bookmark_list_item_model.dart';
import 'package:flutter_cnblogs/requests/user_request.dart';
import 'package:flutter_cnblogs/routes/app_navigation.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

class BookmarkController extends BasePageController<BookmarkListItemModel> {
  final UserRequest userRequest = UserRequest();

  @override
  Future<List<BookmarkListItemModel>> getData(int page, int pageSize) async {
    return await userRequest.getBookmarks(pageIndex: page);
  }

  @override
  void onLogin() {
    easyRefreshController.callRefresh();
    super.onLogin();
  }

  void openUrl(BookmarkListItemModel item) {
    AppNavigator.toWebView(item.linkUrl);
  }

  void delete(BookmarkListItemModel item) async {
    try {
      await userRequest.deleteBookmark(item.wzLinkId);
      list.remove(item);
    } catch (e) {
      SmartDialog.showToast(e.toString());
    }
  }
}
