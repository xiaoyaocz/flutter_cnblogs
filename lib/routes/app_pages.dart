// ignore_for_file: prefer_inlined_adds

import 'package:flutter_cnblogs/modules/blogs/comment/blog_comment_controller.dart';
import 'package:flutter_cnblogs/modules/blogs/comment/blog_comment_page.dart';
import 'package:flutter_cnblogs/modules/blogs/content/blog_content_page.dart';
import 'package:flutter_cnblogs/modules/blogs/home/blogs_home_controller.dart';
import 'package:flutter_cnblogs/modules/blogs/knowledge_content/knowledge_content_controller.dart';
import 'package:flutter_cnblogs/modules/blogs/knowledge_content/knowledge_content_page.dart';
import 'package:flutter_cnblogs/modules/indexed/indexed_controller.dart';
import 'package:flutter_cnblogs/modules/indexed/indexed_page.dart';
import 'package:flutter_cnblogs/modules/news/content/news_content_controller.dart';
import 'package:flutter_cnblogs/modules/news/content/news_content_page.dart';
import 'package:flutter_cnblogs/modules/other/web_view/web_view_controller.dart';
import 'package:flutter_cnblogs/modules/other/web_view/web_view_page.dart';
import 'package:flutter_cnblogs/modules/questions/comment/answer_comment_controller.dart';
import 'package:flutter_cnblogs/modules/questions/comment/answer_comment_page.dart';
import 'package:flutter_cnblogs/modules/questions/detail/question_detail_page.dart';
import 'package:flutter_cnblogs/modules/search/search_controller.dart';
import 'package:flutter_cnblogs/modules/search/search_page.dart';
import 'package:flutter_cnblogs/modules/statuses/detail/statuses_detail_controller.dart';
import 'package:flutter_cnblogs/modules/statuses/detail/statuses_detail_page.dart';
import 'package:flutter_cnblogs/modules/user/blogs/user_blogs_page.dart';
import 'package:flutter_cnblogs/modules/user/bookmark/bookmark_controller.dart';
import 'package:flutter_cnblogs/modules/user/bookmark/bookmark_page.dart';
import 'package:flutter_cnblogs/modules/user/home/user_home_controller.dart';
import 'package:flutter_cnblogs/modules/user/login/login_controller.dart';
import 'package:flutter_cnblogs/modules/user/login/login_page.dart';
import 'package:get/get.dart';

import 'route_path.dart';

class AppPages {
  AppPages._();
  static final routes = [
    // 首页
    GetPage(
      name: RoutePath.kIndex,
      page: () => const IndexedPage(),
      bindings: [
        BindingsBuilder.put(() => IndexedController()),
        BindingsBuilder.put(() => BlogsHomeController()),
        BindingsBuilder.put(() => UserHomeController()),
      ],
    ),
    // 搜索
    GetPage(
      name: RoutePath.kSearch,
      page: () => const SearchPage(),
      binding: BindingsBuilder.put(
        () => SearchController(Get.arguments),
      ),
    ),
  ]
    //用户相关
    ..addAll([
      //登录
      GetPage(
        name: RoutePath.kUserLogin,
        page: () => const LoginPage(),
        binding: BindingsBuilder.put(() => LoginController()),
      ),
      //收藏
      GetPage(
        name: RoutePath.kUserBookmark,
        page: () => const BookmarkPage(),
        binding: BindingsBuilder.put(() => BookmarkController()),
      ),
      //用户博客
      GetPage(
        name: RoutePath.kUserBlog,
        preventDuplicates: false,
        page: () => UserBlogsPage(
          Get.arguments.toString(),
        ),
      ),
    ])
    //博客
    ..addAll([
      // 博客内容
      GetPage(
        name: RoutePath.kBlogContent,
        preventDuplicates: false,
        page: () => BlogContentPage(
          url: Get.parameters["url"].toString(),
        ),
      ),
      // 知识库
      GetPage(
        name: RoutePath.kKnowledgeContent,
        page: () => const KnowledgeContentPage(),
        binding: BindingsBuilder.put(
          () => KnowledgeContentController(Get.arguments),
        ),
      ),
      // 博文评论
      GetPage(
        name: RoutePath.kBlogComment,
        page: () => const BlogCommentPage(),
        binding: BindingsBuilder.put(
          () => BlogCommentController(
            blogApp: Get.parameters["blogApp"].toString(),
            postId: int.parse(Get.parameters["postId"].toString()),
          ),
        ),
      ),
    ])
    //新闻
    ..addAll([
      // 内容
      GetPage(
        name: RoutePath.kNewsContent,
        page: () => const NewsContentPage(),
        binding: BindingsBuilder.put(
          () => NewsContentController(Get.arguments),
        ),
      ),
    ])
    //闪存
    ..addAll([
      // 详情
      GetPage(
        name: RoutePath.kStatusesDetail,
        page: () => const StatusesDetailPage(),
        binding: BindingsBuilder.put(
          () => StatusesDetailController(Get.arguments),
        ),
      ),
    ])
    //博问
    ..addAll([
      // 详情
      GetPage(
        name: RoutePath.kQuestionDetail,
        preventDuplicates: false,
        page: () => QuestionDetailPage(questionId: Get.arguments),
      ),
      // 回答评论
      GetPage(
        name: RoutePath.kAnswerComment,
        page: () => const AnswerCommentPage(),
        binding: BindingsBuilder.put(
          () => AnswerCommentController(
            answerId: int.parse(Get.parameters["answerId"].toString()),
            questionId: int.parse(Get.parameters["questionId"].toString()),
          ),
        ),
      ),
    ])
    //设置及其他
    ..addAll([
      // WebView
      GetPage(
        name: RoutePath.kWebView,
        page: () => const WebViewPage(),
        binding: BindingsBuilder.put(
          () => AppWebViewController(Get.arguments),
        ),
      ),
    ]);
}
