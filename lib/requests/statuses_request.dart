import 'package:flutter_cnblogs/models/statuses/statuses_comment_item_model.dart';
import 'package:flutter_cnblogs/models/statuses/statuses_list_item_model.dart';
import 'package:flutter_cnblogs/requests/base/http_client.dart';

class StatusesRequest {
  /// 根据类型获取闪存列表
  /// - https://api.cnblogs.com/api/statuses/@{type}?pageIndex={pageIndex}&pageSize={pageSize}&tag={tag}
  Future<List<StatusesListItemModel>> getStatuses({
    required String type,
    String tag = "",
    required int pageIndex,
    int pageSize = 20,
    required bool withUserAuth,
  }) async {
    List<StatusesListItemModel> ls = [];
    var result = await HttpClient.instance.get(
      '/api/statuses/@$type',
      queryParameters: {
        'pageIndex': pageIndex,
        'pageSize': pageSize,
        'tag': tag,
      },
      withApiAuth: withUserAuth ? false : true,
      withUserAuth: withUserAuth,
    );
    for (var item in result) {
      ls.add(StatusesListItemModel.fromJson(item));
    }
    return ls;
  }

  /// 根据ID获取闪存详情
  /// - https://api.cnblogs.com/api/statuses/{id}
  Future<StatusesListItemModel> getStatusesById({
    required int id,
  }) async {
    var result = await HttpClient.instance.get(
      '/api/statuses/$id',
      queryParameters: {},
      withUserAuth: true,
    );

    return StatusesListItemModel.fromJson(result);
  }

  /// 根据类型获取闪存评论列表
  /// - https://api.cnblogs.com/api/statuses/{statusId}/comments
  Future<List<StatusesCommentItemModel>> getStatusesComments({
    required int statusId,
  }) async {
    List<StatusesCommentItemModel> ls = [];
    var result = await HttpClient.instance.get(
      '/api/statuses/$statusId/comments',
      queryParameters: {},
      withUserAuth: true,
    );
    for (var item in result) {
      ls.add(StatusesCommentItemModel.fromJson(item));
    }
    return ls;
  }

  /// 发布闪存评论
  /// - https://api.cnblogs.com/api/statuses/{statusId}/comments
  Future<bool> postStatusesComment({
    required int statusId,
    required int replyTo,
    required int parentCommentId,
    required String content,
  }) async {
    await HttpClient.instance.post(
      '/api/statuses/$statusId/comments',
      data: {
        "ReplyTo": replyTo,
        "ParentCommentId": parentCommentId,
        "Content": content,
      },
      withUserAuth: true,
    );

    return true;
  }

  /// 删除闪存评论
  /// - https://api.cnblogs.com/api/statuses/{statusId}/comments/{id}
  Future<bool> deleteStatusesComment({
    required int statusId,
    required int commentId,
  }) async {
    await HttpClient.instance.delete(
      '/api/statuses/$statusId/comments/$commentId',
      withUserAuth: true,
    );

    return true;
  }

  /// 删除闪存
  /// - https://api.cnblogs.com/api/statuses/{id}
  Future<bool> deleteStatuses({
    required int statusId,
  }) async {
    await HttpClient.instance.delete(
      '/api/statuses/$statusId',
      withUserAuth: true,
    );

    return true;
  }

  /// 发布闪存
  /// - https://api.cnblogs.com/api/statuses
  Future<bool> postStatuses({
    required bool isPrivate,
    required String content,
  }) async {
    await HttpClient.instance.post(
      '/api/statuses',
      data: {
        "IsPrivate": isPrivate,
        "Content": content,
      },
      withUserAuth: true,
    );

    return true;
  }
}
