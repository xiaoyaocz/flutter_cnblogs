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
    // ??????
    GetPage(
      name: RoutePath.kIndex,
      page: () => const IndexedPage(),
      bindings: [
        BindingsBuilder.put(() => IndexedController()),
        BindingsBuilder.put(() => BlogsHomeController()),
        BindingsBuilder.put(() => UserHomeController()),
      ],
    ),
    // ??????
    GetPage(
      name: RoutePath.kSearch,
      page: () => const SearchPage(),
      binding: BindingsBuilder.put(
        () => SearchController(Get.arguments),
      ),
    ),
  ]
    //????????????
    ..addAll([
      //??????
      GetPage(
        name: RoutePath.kUserLogin,
        page: () => const LoginPage(),
        binding: BindingsBuilder.put(() => LoginController()),
      ),
      //??????
      GetPage(
        name: RoutePath.kUserBookmark,
        page: () => const BookmarkPage(),
        binding: BindingsBuilder.put(() => BookmarkController()),
      ),
      //????????????
      GetPage(
        name: RoutePath.kUserBlog,
        preventDuplicates: false,
        page: () => UserBlogsPage(
          Get.arguments.toString(),
        ),
      ),
    ])
    //??????
    ..addAll([
      // ????????????
      GetPage(
        name: RoutePath.kBlogContent,
        preventDuplicates: false,
        page: () => BlogContentPage(
          url: Get.parameters["url"].toString(),
        ),
      ),
      // ?????????
      GetPage(
        name: RoutePath.kKnowledgeContent,
        page: () => const KnowledgeContentPage(),
        binding: BindingsBuilder.put(
          () => KnowledgeContentController(Get.arguments),
        ),
      ),
      // ????????????
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
    //??????
    ..addAll([
      // ??????
      GetPage(
        name: RoutePath.kNewsContent,
        page: () => const NewsContentPage(),
        binding: BindingsBuilder.put(
          () => NewsContentController(Get.arguments),
        ),
      ),
    ])
    //??????
    ..addAll([
      // ??????
      GetPage(
        name: RoutePath.kStatusesDetail,
        page: () => const StatusesDetailPage(),
        binding: BindingsBuilder.put(
          () => StatusesDetailController(Get.arguments),
        ),
      ),
    ])
    //??????
    ..addAll([
      // ??????
      GetPage(
        name: RoutePath.kQuestionDetail,
        preventDuplicates: false,
        page: () => QuestionDetailPage(questionId: Get.arguments),
      ),
      // ????????????
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
    //???????????????
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
