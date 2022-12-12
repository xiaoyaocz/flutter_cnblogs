import 'package:flutter_cnblogs/app/log.dart';
import 'package:flutter_cnblogs/models/blogs/knowledge_list_item_model.dart';
import 'package:flutter_cnblogs/models/news/news_list_item_model.dart';
import 'package:flutter_cnblogs/routes/route_path.dart';
import 'package:get/get.dart';

/// APP页面跳转封装
/// * 需要参数的页面都应使用此类
/// * 如不需要参数，可以使用Get.toNamed
class AppNavigator {
  /// 跳转至博客详情
  static Future toBlogContent({required String url}) async {
    return await Get.toNamed(
      RoutePath.kBlogContent,
      parameters: {
        "url": url,
      },
    );
  }

  /// 跳转至博文评论
  static Future toBlogComment({
    required String blogApp,
    required int postId,
  }) async {
    return await Get.toNamed(
      RoutePath.kBlogComment,
      parameters: {
        "blogApp": blogApp,
        "postId": postId.toString(),
      },
    );
  }

  /// 跳转至知识库详情
  static Future toKnowledgeContent(KnowledgeListItemModel item) async {
    return await Get.toNamed(
      RoutePath.kKnowledgeContent,
      arguments: item,
    );
  }

  /// 跳转至新闻详情
  static Future toNewsContent(NewsListItemModel item) async {
    return await Get.toNamed(
      RoutePath.kNewsContent,
      arguments: item,
    );
  }

  /// 跳转至用户博客
  static Future toUserBlog(String blogApp) async {
    return await Get.toNamed(
      RoutePath.kUserBlog,
      arguments: blogApp,
    );
  }

  /// 跳转至WebView
  static Future toWebView(String url) async {
    Log.i(url);
    final RegExp blogRegExp1 = RegExp(r'cnblogs.com/(.*?)/p/(.*?).html');
    final RegExp blogRegExp2 =
        RegExp(r'cnblogs.com/(.*?)/archive/\d+/\d+/\d+/(.*?).html');

    if (blogRegExp1.hasMatch(url)) {
      AppNavigator.toBlogContent(url: url);
      return;
    }

    var match2 = blogRegExp2.firstMatch(url);
    if (match2 != null) {
      String blogApp = match2.group(1)!;
      String blogPostId = match2.group(2)!;
      AppNavigator.toBlogContent(
          url: "http://www.cnblogs.com/$blogApp/p/$blogPostId.html");
      return;
    }

    final RegExp questionRegExp1 = RegExp(r'q.cnblogs.com/q/(\d+)/');
    var questionMatch = questionRegExp1.firstMatch(url);
    if (questionMatch != null) {
      String questionId = questionMatch.group(1)!;
      AppNavigator.toQuestionDetail(int.parse(questionId));
      return;
    }

    return await Get.toNamed(
      RoutePath.kWebView,
      arguments: url,
    );
  }

  /// 获取闪存详情
  static Future toStatusesDetail(int id) async {
    return await Get.toNamed(
      RoutePath.kStatusesDetail,
      arguments: id,
    );
  }

  /// 获取问题详情
  static Future toQuestionDetail(int id) async {
    return await Get.toNamed(
      RoutePath.kQuestionDetail,
      arguments: id,
    );
  }
}
