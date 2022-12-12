import 'package:flutter_cnblogs/models/user/bookmark_list_item_model.dart';
import 'package:flutter_cnblogs/models/user/user_info_model.dart';
import 'package:flutter_cnblogs/requests/base/http_client.dart';

class UserRequest {
  Future<UserInfoModel> getUserInfo() async {
    var result = await HttpClient.instance.get(
      '/api/users',
      withUserAuth: true,
    );

    return UserInfoModel.fromJson(result);
  }

  /// 分页获取收藏列表
  /// - https://api.cnblogs.com/api/Bookmarks?pageIndex={pageIndex}&pageSize={pageSize}
  Future<List<BookmarkListItemModel>> getBookmarks(
      {required int pageIndex, int pageSize = 20}) async {
    List<BookmarkListItemModel> ls = [];
    var result = await HttpClient.instance.get(
      '/api/Bookmarks',
      queryParameters: {
        'pageIndex': pageIndex,
        'pageSize': pageSize,
      },
      withUserAuth: true,
    );
    for (var item in result) {
      ls.add(BookmarkListItemModel.fromJson(item));
    }
    return ls;
  }

  /// 根据id删除收藏
  /// - https://api.cnblogs.com/api/bookmarks/{id}
  Future<bool> deleteBookmark(int id) async {
    await HttpClient.instance.delete(
      '/api/bookmarks/$id',
      data: {},
      withUserAuth: true,
    );
    return true;
  }

  /// 根据url删除收藏
  /// - https://api.cnblogs.com/api/Bookmarks?url={url}
  Future<bool> deleteBookmarkByUrl(String url) async {
    await HttpClient.instance.delete(
      '/api/Bookmarks',
      queryParameters: {
        'url': Uri.encodeComponent(url),
      },
      data: {},
      withUserAuth: true,
    );
    return true;
  }

  /// 根据URL检查收藏是否已存在
  /// - https://api.cnblogs.com/api/Bookmarks?url={url}
  Future<bool> checkBookmark(String url) async {
    return await HttpClient.instance.head(
      '/api/Bookmarks',
      queryParameters: {
        "url": Uri.encodeComponent(url),
      },
      withUserAuth: true,
    );
  }

  /// 添加收藏
  /// - https://api.cnblogs.com/api/Bookmarks
  Future<bool> addBookmark(String title, String url) async {
    await HttpClient.instance.post(
      '/api/Bookmarks',
      data: {
        "Title": title,
        "LinkUrl": url,
        "Summary": "",
        "Tags": <String>[],
      },
      withUserAuth: true,
    );
    return true;
  }
}
