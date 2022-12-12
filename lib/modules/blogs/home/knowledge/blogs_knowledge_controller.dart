import 'package:flutter_cnblogs/app/controller/base_controller.dart';
import 'package:flutter_cnblogs/models/blogs/knowledge_list_item_model.dart';
import 'package:flutter_cnblogs/requests/blogs_request.dart';

class BlogsKnowledgeController
    extends BasePageController<KnowledgeListItemModel> {
  final BlogsRequest blogsRequest = BlogsRequest();

  @override
  Future<List<KnowledgeListItemModel>> getData(int page, int pageSize) async {
    return await blogsRequest.getKbArticles(pageIndex: page);
  }
}
