import 'package:flutter_cnblogs/app/controller/base_controller.dart';
import 'package:flutter_cnblogs/generated/locales.g.dart';
import 'package:flutter_cnblogs/models/news/news_list_item_model.dart';
import 'package:flutter_cnblogs/requests/news_request.dart';

class NewsListController extends BasePageController<NewsListItemModel> {
  final String title;
  NewsListController(this.title);
  final NewsRequest newsRequest = NewsRequest();

  @override
  Future<List<NewsListItemModel>> getData(int page, int pageSize) async {
    if (title == LocaleKeys.news_home_hot) {
      return await newsRequest.getHot(pageIndex: page);
    } else if (title == LocaleKeys.news_home_hot_week) {
      return await newsRequest.getHotWeek(pageIndex: page);
    } else if (title == LocaleKeys.news_home_recommended) {
      return await newsRequest.getRecommended(pageIndex: page);
    } else {
      return await newsRequest.getNew(pageIndex: page);
    }
  }
}
