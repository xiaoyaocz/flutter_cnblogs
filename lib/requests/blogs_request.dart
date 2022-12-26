import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_cnblogs/models/blogs/blog_comment_item_model.dart';
import 'package:flutter_cnblogs/models/blogs/blog_content_model.dart';
import 'package:flutter_cnblogs/models/blogs/blog_list_item_model.dart';
import 'package:flutter_cnblogs/models/blogs/blog_list_item_v2_model.dart';
import 'package:flutter_cnblogs/models/blogs/knowledge_list_item_model.dart';
import 'package:flutter_cnblogs/models/blogs/user_blog_info_model.dart';
import 'package:flutter_cnblogs/requests/base/http_client.dart';

class BlogsRequest {
  /// 分页获取网站首页博文列表
  /// - https://api.cnblogs.com/api/blogposts/@sitehome?pageIndex={pageIndex}&pageSize={pageSize}
  Future<List<BlogListItemModel>> getSitehome(
      {required int pageIndex, int pageSize = 20}) async {
    List<BlogListItemModel> ls = [];
    var result = await HttpClient.instance.get(
      '/api/blogposts/@sitehome',
      queryParameters: {
        'pageIndex': pageIndex,
        'pageSize': pageSize,
      },
      withApiAuth: true,
    );
    for (var item in result) {
      ls.add(BlogListItemModel.fromJson(item));
    }
    return ls;
  }

  /// 分页获取精华区博文列表
  /// - https://api.cnblogs.com/api/blogposts/@picked?pageIndex={pageIndex}&pageSize={pageSize}
  Future<List<BlogListItemModel>> getPicked(
      {required int pageIndex, int pageSize = 20}) async {
    List<BlogListItemModel> ls = [];
    var result = await HttpClient.instance.get(
      '/api/blogposts/@picked',
      queryParameters: {
        'pageIndex': pageIndex,
        'pageSize': pageSize,
      },
      withApiAuth: true,
    );
    for (var item in result) {
      ls.add(BlogListItemModel.fromJson(item));
    }
    return ls;
  }

  /// 分页获取10天推荐博文列表
  /// - https://api.cnblogs.com/api/blog/v2/blogposts/aggsites/mostliked?pageIndex=1&pageSize=10
  Future<List<BlogListItemModel>> getMostliked(
      {required int pageIndex, int pageSize = 20}) async {
    List<BlogListItemV2Model> ls = [];
    var result = await HttpClient.instance.get(
      '/api/blog/v2/blogposts/aggsites/mostliked',
      queryParameters: {
        'pageIndex': pageIndex,
        'pageSize': pageSize,
      },
      withApiAuth: true,
    );
    for (var item in result) {
      ls.add(BlogListItemV2Model.fromJson(item));
    }
    return ls
        .map((e) => BlogListItemModel(
              id: e.id,
              title: e.title,
              url: e.url,
              description: e.description,
              author: e.author,
              blogapp: e.blogUrl,
              avatar: e.avatar,
              postdate: e.dateAdded,
              viewcount: e.viewCount,
              commentcount: e.commentCount,
              diggcount: e.diggCount,
            ))
        .toList();
  }

  /// 分页获取48小时阅读排行博文列表
  /// - https://api.cnblogs.com/api/blog/v2/blogposts/aggsites/mostread?pageIndex=1&pageSize=10
  Future<List<BlogListItemModel>> getMostRead(
      {required int pageIndex, int pageSize = 20}) async {
    List<BlogListItemV2Model> ls = [];
    var result = await HttpClient.instance.get(
      '/api/blog/v2/blogposts/aggsites/mostread',
      queryParameters: {
        'pageIndex': pageIndex,
        'pageSize': pageSize,
      },
      withApiAuth: true,
    );
    for (var item in result) {
      ls.add(BlogListItemV2Model.fromJson(item));
    }
    return ls
        .map((e) => BlogListItemModel(
              id: e.id,
              title: e.title,
              url: e.url,
              description: e.description,
              author: e.author,
              blogapp: e.blogUrl,
              avatar: e.avatar,
              postdate: e.dateAdded,
              viewcount: e.viewCount,
              commentcount: e.commentCount,
              diggcount: e.diggCount,
            ))
        .toList();
  }

  /// 分页获取知识库文章列表
  /// - https://api.cnblogs.com/api/KbArticles?pageIndex={pageIndex}&pageSize={pageSize}
  Future<List<KnowledgeListItemModel>> getKbArticles(
      {required int pageIndex, int pageSize = 20}) async {
    List<KnowledgeListItemModel> ls = [];
    var result = await HttpClient.instance.get(
      '/api/KbArticles',
      queryParameters: {
        'pageIndex': pageIndex,
        'pageSize': pageSize,
      },
      withApiAuth: true,
    );
    for (var item in result) {
      ls.add(KnowledgeListItemModel.fromJson(item));
    }
    return ls;
  }

  /// 获取博文内容
  /// - https://api.cnblogs.com/api/blogposts/{id}/body
  Future<BlogContentModel?> getBlogContent({required String url}) async {
    try {
      var result = await HttpClient.instance.get(
        '/api/blog/v2/blogposts/url/${Uri.encodeComponent(url)}',
        queryParameters: {
          'includeTags': true,
          'includeCategories': true,
        },
        withApiAuth: true,
      );

      return BlogContentModel.fromJson(result);
    } catch (e) {
      return null;
    }
  }

  /// 获取博文内容
  /// - https://api.cnblogs.com/api/blogposts/{id}/body
  Future<String> getBlogContentByWeb({required String url}) async {
    var result = await HttpClient.instance.get(
      url,
      baseUrl: "",
      responseType: ResponseType.plain,
      withApiAuth: true,
    );

    return result;
  }

  /// 获取知识库内容
  /// - https://api.cnblogs.com/api/kbarticles/{id}/body
  Future<String> getKnowledgeContent({required int id}) async {
    var result = await HttpClient.instance.get(
      '/api/kbarticles/$id/body',
      queryParameters: {},
      withApiAuth: true,
      responseType: ResponseType.plain,
    );
    var jsonContent = json.decode('{"content":$result}');
    return jsonContent["content"];
  }

  /// 获取个人博客随笔列表
  /// - https://api.cnblogs.com/api/blogs/{blogApp}/posts?pageIndex={pageIndex}
  Future<List<BlogListItemModel>> getUserBlogs(
      {required String blogApp,
      required int pageIndex,
      int pageSize = 20}) async {
    List<BlogListItemModel> ls = [];
    var result = await HttpClient.instance.get(
      '/api/blogs/$blogApp/posts',
      queryParameters: {
        'pageIndex': pageIndex,
        'pageSize': pageSize,
      },
      withApiAuth: true,
    );
    for (var item in result) {
      ls.add(BlogListItemModel.fromJson(item));
    }
    return ls;
  }

  /// 获取个人博客信息
  /// - https://api.cnblogs.com/api/blogs/{blogApp}
  Future<UserBlogInfoModel> getUserBlogsInfo(String blogApp) async {
    var result = await HttpClient.instance.get(
      '/api/blogs/$blogApp',
      withApiAuth: true,
    );
    return UserBlogInfoModel.fromJson(result);
  }

  /// 获取博文的评论列表
  /// -https://api.cnblogs.com/api/blogs/{blogApp}/posts/{postId}/comments?pageIndex={pageIndex}&pageSize={pageSize}
  Future<List<BlogCommentItemModel>> getBlogComment({
    required String blogApp,
    required int postId,
    required int pageIndex,
    int pageSize = 20,
  }) async {
    List<BlogCommentItemModel> ls = [];
    var result = await HttpClient.instance.get(
      '/api/blogs/$blogApp/posts/$postId/comments',
      queryParameters: {
        'pageIndex': pageIndex,
        'pageSize': pageSize,
      },
      withApiAuth: true,
    );
    for (var item in result) {
      ls.add(BlogCommentItemModel.fromJson(item));
    }
    return ls;
  }

  /// 添加博文评论
  /// -https://api.cnblogs.com/api/blogs/{blogApp}/posts/{postId}/comments
  Future<bool> postBlogComment({
    required String blogApp,
    required int postId,
    required String body,
  }) async {
    //TODO 403
    await HttpClient.instance.post(
      '/api/blogs/$blogApp/posts/$postId/comments',
      data: {"body": body},
      withUserAuth: true,
    );

    return true;
  }
}
