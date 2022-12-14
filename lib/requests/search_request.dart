import 'package:flutter_cnblogs/models/search/search_item_model.dart';
import 'package:flutter_cnblogs/requests/base/http_client.dart';

class SearchRequest {
  /// 搜索
  /// - https://api.cnblogs.com/api/ZzkDocuments/{category}?keyWords={keyWords}&pageIndex={pageIndex}&startDate={startDate}&endDate={endDate}&viewTimesAtLeast={viewTimesAtLeast}
  Future<List<SearchItemModel>> search({
    required String category,
    required String keyword,
    required int pageIndex,
    String startDate = '',
    String endDate = '',
    int viewTimesAtLeast = 0,
    int pageSize = 20,
  }) async {
    List<SearchItemModel> ls = [];
    var result = await HttpClient.instance.get(
      '/api/ZzkDocuments/$category',
      queryParameters: {
        'keyWords': keyword,
        'startDate': startDate,
        'endDate': endDate,
        'viewTimesAtLeast': viewTimesAtLeast,
        'pageIndex': pageIndex,
        'pageSize': pageSize,
      },
      withApiAuth: true,
    );
    for (var item in result) {
      ls.add(SearchItemModel.fromJson(item));
    }
    return ls;
  }
}
