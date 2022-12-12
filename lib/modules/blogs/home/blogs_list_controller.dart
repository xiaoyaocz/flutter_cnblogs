import 'package:flutter_cnblogs/app/controller/base_controller.dart';
import 'package:flutter_cnblogs/generated/locales.g.dart';
import 'package:flutter_cnblogs/models/blogs/blog_list_item_model.dart';
import 'package:flutter_cnblogs/requests/blogs_request.dart';

class BlogsListController extends BasePageController<BlogListItemModel> {
  final String title;
  BlogsListController(this.title);
  final BlogsRequest blogsRequest = BlogsRequest();

  @override
  Future<List<BlogListItemModel>> getData(int page, int pageSize) async {
    if (title == LocaleKeys.blogs_home_new) {
      return await blogsRequest.getSitehome(pageIndex: page);
    } else if (title == LocaleKeys.blogs_home_mostliked) {
      return await blogsRequest.getMostliked(pageIndex: page);
    } else if (title == LocaleKeys.blogs_home_picked) {
      return await blogsRequest.getPicked(pageIndex: page);
    } else if (title == LocaleKeys.blogs_home_mostread) {
      return await blogsRequest.getMostRead(pageIndex: page);
    } else {
      return await blogsRequest.getSitehome(pageIndex: page);
    }
  }
}
