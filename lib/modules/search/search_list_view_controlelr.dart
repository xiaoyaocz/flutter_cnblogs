import 'package:flutter_cnblogs/app/controller/base_controller.dart';
import 'package:flutter_cnblogs/generated/locales.g.dart';
import 'package:flutter_cnblogs/models/search/search_item_model.dart';
import 'package:flutter_cnblogs/requests/search_request.dart';

class SearchListController extends BasePageController<SearchItemModel> {
  final String tag;
  SearchListController(this.tag);
  final SearchRequest newsRequest = SearchRequest();

  String keyword = "";
  String startDate = "";
  String endDate = "";
  int view = 0;

  @override
  void onInit() {
    pageEmpty.value = true;
    super.onInit();
  }

  @override
  Future<List<SearchItemModel>> getData(int page, int pageSize) async {
    if (keyword.isEmpty) {
      return [];
    }
    var category = "";
    switch (tag) {
      case LocaleKeys.search_type_blog:
        category = "blog";
        break;
      case LocaleKeys.search_type_news:
        category = "news";
        break;
      case LocaleKeys.search_type_question:
        category = "question";
        break;
      case LocaleKeys.search_type_kb:
        category = "kb";
        break;
      default:
    }
    return await newsRequest.search(
      category: category,
      keyword: keyword,
      startDate: startDate,
      endDate: endDate,
      viewTimesAtLeast: view,
      pageIndex: page,
    );
  }
}
