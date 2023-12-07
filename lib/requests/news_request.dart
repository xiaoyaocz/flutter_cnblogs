import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_cnblogs/models/news/news_comment_item_model.dart';
import 'package:flutter_cnblogs/models/news/news_list_item_model.dart';
import 'package:flutter_cnblogs/requests/base/http_client.dart';

class NewsRequest {
  /// 分页获取本周内热门新闻
  /// - https://api.cnblogs.com/api/newsitems/@hot-week?pageIndex={pageIndex}&pageSize={pageSize}
  Future<List<NewsListItemModel>> getHotWeek(
      {required int pageIndex, int pageSize = 20}) async {
    List<NewsListItemModel> ls = [];
    var result = await HttpClient.instance.get(
      '/api/newsitems/@hot-week',
      queryParameters: {
        'pageIndex': pageIndex,
        'pageSize': pageSize,
      },
      withApiAuth: true,
    );
    for (var item in result) {
      ls.add(NewsListItemModel.fromJson(item));
    }
    return ls;
  }

  /// 分页获取热门新闻
  /// - https://api.cnblogs.com/api/newsitems/@hot?startDate={startDate}&endDate={endDate}&pageIndex={pageIndex}&pageSize={pageSize}
  Future<List<NewsListItemModel>> getHot(
      {required int pageIndex, int pageSize = 20}) async {
    List<NewsListItemModel> ls = [];
    var result = await HttpClient.instance.get(
      '/api/newsitems/@hot',
      queryParameters: {
        'pageIndex': pageIndex,
        'pageSize': pageSize,
      },
      withApiAuth: true,
    );
    for (var item in result) {
      ls.add(NewsListItemModel.fromJson(item));
    }
    return ls;
  }

  /// 分页获取推荐新闻
  /// - https://api.cnblogs.com/api/newsitems/@recommended?pageIndex={pageIndex}&pageSize={pageSize}
  Future<List<NewsListItemModel>> getRecommended(
      {required int pageIndex, int pageSize = 20}) async {
    List<NewsListItemModel> ls = [];
    var result = await HttpClient.instance.get(
      '/api/newsitems/@recommended',
      queryParameters: {
        'pageIndex': pageIndex,
        'pageSize': pageSize,
      },
      withApiAuth: true,
    );
    for (var item in result) {
      ls.add(NewsListItemModel.fromJson(item));
    }
    return ls;
  }

  /// 分页获取最新新闻
  /// - https://api.cnblogs.com/api/NewsItems?pageIndex={pageIndex}&pageSize={pageSize}
  Future<List<NewsListItemModel>> getNew(
      {required int pageIndex, int pageSize = 20}) async {
    List<NewsListItemModel> ls = [];
    var result = await HttpClient.instance.get(
      '/api/newsitems',
      queryParameters: {
        'pageIndex': pageIndex,
        'pageSize': pageSize,
      },
      withApiAuth: true,
    );
    for (var item in result) {
      ls.add(NewsListItemModel.fromJson(item));
    }
    return ls;
  }

  /// 获取新闻内容
  /// - https://api.cnblogs.com/api/newsitems/{id}/body
  Future<String> getNewsContent({required int id}) async {
    var result = await HttpClient.instance.get(
      '/api/newsitems/$id/body',
      queryParameters: {},
      withApiAuth: true,
      responseType: ResponseType.plain,
    );
    var jsonContent = json.decode('{"content":$result}');
    return jsonContent["content"];
  }

  /// 获取新闻的评论列表
  /// -https://api.cnblogs.com/api/news/{newsId}/comments?pageIndex={pageIndex}&pageSize={pageSize}
  Future<List<NewsCommentItemModel>> getNewsComment({
    required int newsId,
    required int pageIndex,
    int pageSize = 20,
  }) async {
    List<NewsCommentItemModel> ls = [];
    var result = await HttpClient.instance.get(
      '/api/news/$newsId/comments',
      queryParameters: {
        'pageIndex': pageIndex,
        'pageSize': pageSize,
      },
      withApiAuth: true,
    );
    for (var item in result) {
      ls.add(NewsCommentItemModel.fromJson(item));
    }
    return ls;
  }

  /// 添加新闻评论
  /// -https://api.cnblogs.com/api/news/$newsId/comments
  Future<bool> postNewsComment({
    required int newsId,
    required String body,
    int parentId = 0,
  }) async {
    //TODO 返回201空数据
    await HttpClient.instance.post(
      '/api/news/$newsId/comments',
      data: {
        "ParentId": parentId,
        "Content": body,
      },
      withUserAuth: true,
    );

    return true;
  }
}
