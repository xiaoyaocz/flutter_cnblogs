import 'package:flutter_cnblogs/models/questions/answer_comment_list_item_model.dart';
import 'package:flutter_cnblogs/models/questions/answer_list_item_model.dart';
import 'package:flutter_cnblogs/models/questions/question_list_item_model.dart';
import 'package:flutter_cnblogs/requests/base/http_client.dart';
import 'package:flutter_cnblogs/services/user_service.dart';

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

  /// 获取单个回答的评论列表
  /// - https://api.cnblogs.com/api/questions/answers/{answerId}/comments
  Future<List<AnswerCommentListItemModel>> getAnswerComments({
    required int answerId,
  }) async {
    List<AnswerCommentListItemModel> ls = [];
    var result = await HttpClient.instance.get(
      '/api/questions/answers/$answerId/comments',
      queryParameters: {},
      withApiAuth: true,
    );
    for (var item in result) {
      ls.add(AnswerCommentListItemModel.fromJson(item));
    }
    return ls;
  }

  /// 添加回答评论
  /// - https://api.cnblogs.com/api/questions/{questionId}/answers/{answerId}/comments?loginName={XXX}
  Future<bool> postAnswerComment({
    required int questionId,
    required int answerId,
    required String body,
    int parentCommentId = 0,
  }) async {
    await HttpClient.instance.post(
      '/api/questions/$questionId/answers/$answerId/comments?loginName=${UserService.instance.userProfile.value?.displayName ?? ''}',
      data: {
        "Content": body,
        "ParentCommentId": parentCommentId,
        "PostUserID": UserService.instance.userId,
      },
      withUserAuth: true,
    );

    return true;
  }
}
