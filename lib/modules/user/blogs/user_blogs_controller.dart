import 'package:flutter_cnblogs/app/controller/base_controller.dart';
import 'package:flutter_cnblogs/app/log.dart';
import 'package:flutter_cnblogs/models/blogs/blog_list_item_model.dart';
import 'package:flutter_cnblogs/requests/blogs_request.dart';
import 'package:get/get.dart';

class UserBlogsController extends BasePageController<BlogListItemModel> {
  final String blogApp;
  UserBlogsController(this.blogApp);
  final BlogsRequest blogsRequest = BlogsRequest();

  var name = "".obs;
  var subtitle = "".obs;
  @override
  void onInit() {
    loadBlogInfo();
    super.onInit();
  }

  void loadBlogInfo() async {
    try {
      var result = await blogsRequest.getUserBlogsInfo(blogApp);
      name.value = result.title;
      subtitle.value = result.subtitle;
    } catch (e) {
      Log.logPrint(e);
    }
  }

  @override
  Future<List<BlogListItemModel>> getData(int page, int pageSize) async {
    return await blogsRequest.getUserBlogs(blogApp: blogApp, pageIndex: page);
  }
}
