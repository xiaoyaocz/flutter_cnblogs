import 'package:flutter/services.dart';

import 'package:flutter_cnblogs/app/app_error.dart';
import 'package:flutter_cnblogs/app/controller/base_webview_controller.dart';
import 'package:flutter_cnblogs/app/utils.dart';
import 'package:flutter_cnblogs/generated/locales.g.dart';
import 'package:flutter_cnblogs/models/blogs/blog_content_model.dart';
import 'package:flutter_cnblogs/requests/blogs_request.dart';
import 'package:flutter_cnblogs/requests/user_request.dart';
import 'package:flutter_cnblogs/routes/app_navigation.dart';
import 'package:flutter_cnblogs/routes/route_path.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:xpath_selector_html_parser/xpath_selector_html_parser.dart';

class BlogContentController extends BaseWebViewController {
  final BlogsRequest request = BlogsRequest();
  final UserRequest userRequest = UserRequest();
  final String url;

  BlogContentController({
    required this.url,
  });

  var title = "".obs;
  var commentCount = 0.obs;
  var bookmarked = false.obs;
  BlogContentModel? detail;

  @override
  void onWebViewCreated(InAppWebViewController controller) {
    super.onWebViewCreated(controller);
    loadData();
  }

  Future loadData() async {
    try {
      pageError.value = false;
      pageLoadding.value = true;

      var result = await request.getBlogContent(url: url);

      if (result == null || result.id == 0) {
        // API读取旧文章会失败，从Web中读取内容
        var webResult = await getContentByWeb();
        //无法加载,使用WebView打开
        if (webResult == null) {
          SmartDialog.showToast(LocaleKeys.blog_content_load_failure.tr);
          Get.offAndToNamed(RoutePath.kWebView, arguments: url);
          return;
        }
        result = webResult;
      }
      detail = result;
      title.value = result.title;
      commentCount.value = result.commentCount;
      //替换内容

      var highlightScript = await getHighlightScript();
      var commonScript = await getCommonScript();

      var style = await loadStyle();
      var htmlTemplate = await loadTemplate();
      htmlTemplate = htmlTemplate.replaceAll("@highlightJs", highlightScript);
      htmlTemplate = htmlTemplate.replaceAll("@commonJs", commonScript);
      htmlTemplate = htmlTemplate.replaceAll("@style", style);

      htmlTemplate = htmlTemplate.replaceAll("@title", result.title);
      htmlTemplate = htmlTemplate.replaceAll("@avatar", result.avatar);
      htmlTemplate = htmlTemplate.replaceAll("@username", result.author);
      htmlTemplate = htmlTemplate.replaceAll(
          "@puttime", Utils.dateFormatWithYear.format(result.postDateTime));
      htmlTemplate = htmlTemplate.replaceAll(
          "@stat", "${result.viewCount}浏览&nbsp; &nbsp; ${result.diggCount}推荐");

      htmlTemplate = htmlTemplate.replaceAll("@content", result.body);
      webViewController?.loadData(
        data: htmlTemplate,
      );
      checkBookmark();
    } catch (e) {
      pageError.value = true;
      errorMsg.value = e.toString();
    } finally {
      pageLoadding.value = false;
    }
  }

  /// 从Web中读取内容加载到APP
  Future<BlogContentModel?> getContentByWeb() async {
    try {
      var result = await request.getBlogContentByWeb(url: url);
      var id = int.tryParse(
          RegExp(r"currentBlogId.=.(\d+);").firstMatch(result)?.group(1) ?? "");
      var blogApp =
          RegExp(r"currentBlogApp.=.'(.*?)';").firstMatch(result)?.group(1);
      var content = RegExp(
              r'id="cnblogs_post_body".*?>([\s\S]*?)<div.id="blog_post_info_block"',
              multiLine: true)
          .firstMatch(result)
          ?.group(1);
      var html = HtmlXPath.html(result);
      var title = html.query('//h1[@class^="postTitle"]').node?.text;
      var viewCount = int.tryParse(
          html.query('//span[@id^="post_view_count"]').node?.text ?? "");
      var commentCount = int.tryParse(
          html.query('//span[@id^="post_comment_count"]').node?.text ?? "");
      var postDate = html.query('//span[@id^="post-date"]').node?.text;

      var author = html.query('//div[@class^="postDesc"]/a[1]').node?.text;
      return BlogContentModel(
        id: id ?? 0,
        title: title ?? "",
        url: url,
        description: "",
        viewCount: viewCount ?? 0,
        diggCount: 0,
        commentCount: commentCount ?? 0,
        author: author ?? "",
        avatar: "https://pic.cnblogs.com/face/sample_face.gif",
        blogId: id ?? 0,
        blogApp: blogApp ?? "",
        dateAdded: postDate ?? "2000-01-01 11:11:11",
        dateUpdated: postDate ?? "2000-01-01 11:11:11",
        body: content ?? "",
      );
    } catch (e) {
      return null;
    }
  }

  Future<String> loadTemplate() async {
    return await rootBundle.loadString('assets/templates/blog/blog.html');
  }

  Future<String> loadStyle() async {
    return await rootBundle.loadString(Get.isDarkMode
        ? 'assets/templates/blog/dark.css'
        : 'assets/templates/blog/light.css');
  }

  void share() {
    if (detail == null) return;
    Share.share('《${detail!.title}》\r\n${detail!.url}');
  }

  void openBrowser() {
    launchUrlString(
      url,
      mode: LaunchMode.externalApplication,
    );
  }

  void openComment() {
    AppNavigator.toBlogComment(
      blogApp: detail!.blogApp,
      postId: detail!.id,
    );
  }

  void checkBookmark() async {
    //TODO 接口返回500
    //bookmarked.value = await userRequest.checkBookmark(detail!.url);
  }

  void addOrDelBookmark() async {
    try {
      SmartDialog.showLoading(msg: '');
      if (bookmarked.value) {
        await userRequest.deleteBookmarkByUrl(detail!.url);
      } else {
        await userRequest.addBookmark(
            "${detail!.title} - ${detail!.author}", detail!.url);
      }
      bookmarked.value = !bookmarked.value;
    } catch (e) {
      if (e is AppError) {
        if (e.code == 409 && e.isHttpError) {
          SmartDialog.showToast(LocaleKeys.blog_content_bookmarked.tr);
          bookmarked.value = true;
          return;
        }
      }
      SmartDialog.showToast(e.toString());
    } finally {
      SmartDialog.dismiss(status: SmartStatus.loading);
    }
  }

  @override
  void openUserBlogs() {
    AppNavigator.toUserBlog(detail!.blogApp);
  }
}
