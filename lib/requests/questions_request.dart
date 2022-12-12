import 'package:flutter_cnblogs/models/questions/answer_list_item_model.dart';
import 'package:flutter_cnblogs/models/questions/question_list_item_model.dart';
import 'package:flutter_cnblogs/requests/base/http_client.dart';

class QuestionsRequest {
  /// 根据类型获取问题列表
  /// - https://api.cnblogs.com/api/questions/@{type}?pageIndex={pageIndex}&pageSize={pageSize}
  Future<List<QuestionListItemModel>> getQuestions({
    required String type,
    required int pageIndex,
    int pageSize = 20,
    int spaceUserId = 0,
  }) async {
    List<QuestionListItemModel> ls = [];
    var result = await HttpClient.instance.get(
      '/api/questions/@$type',
      queryParameters: {
        'pageIndex': pageIndex,
        'pageSize': pageSize,
        'spaceUserId': spaceUserId,
      },
      withApiAuth: true,
    );
    for (var item in result) {
      ls.add(QuestionListItemModel.fromJson(item));
    }
    return ls;
  }

  /// 获取单个问题的详情
  /// - https://api.cnblogs.com/api/questions/{questionId}
  Future<QuestionListItemModel> getQuestionById({
    required int questionId,
  }) async {
    var result = await HttpClient.instance.get(
      '/api/questions/$questionId',
      queryParameters: {},
      withApiAuth: true,
    );

    return QuestionListItemModel.fromJson(result);
  }

  /// 获取单个问题对应的回答列表
  /// - https://api.cnblogs.com/api/questions/{questionId}/answers
  Future<List<AnswerListItemModel>> getQuestionAnswers({
    required int questionId,
  }) async {
    List<AnswerListItemModel> ls = [];
    var result = await HttpClient.instance.get(
      '/api/questions/$questionId/answers',
      queryParameters: {},
      withApiAuth: true,
    );
    for (var item in result) {
      ls.add(AnswerListItemModel.fromJson(item));
    }
    return ls;
  }
}
