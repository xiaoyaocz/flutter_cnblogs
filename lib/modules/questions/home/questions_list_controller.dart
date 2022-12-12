import 'package:flutter_cnblogs/app/controller/base_controller.dart';
import 'package:flutter_cnblogs/generated/locales.g.dart';
import 'package:flutter_cnblogs/models/questions/question_list_item_model.dart';
import 'package:flutter_cnblogs/requests/questions_request.dart';
import 'package:flutter_cnblogs/services/user_service.dart';

class QuestionsListController
    extends BasePageController<QuestionListItemModel> {
  final String title;
  QuestionsListController(this.title);
  final QuestionsRequest questionsRequest = QuestionsRequest();

  @override
  Future<List<QuestionListItemModel>> getData(int page, int pageSize) async {
    if (title == LocaleKeys.questions_home_unsolved) {
      return await questionsRequest.getQuestions(
        type: "unsolved",
        pageIndex: page,
      );
    } else if (title == LocaleKeys.questions_home_highscore) {
      return await questionsRequest.getQuestions(
        type: "highscore",
        pageIndex: page,
      );
    } else if (title == LocaleKeys.questions_home_solved) {
      return await questionsRequest.getQuestions(
        type: "solved",
        pageIndex: page,
      );
    } else if (title == LocaleKeys.questions_home_noanswer) {
      return await questionsRequest.getQuestions(
        type: "noanswer",
        pageIndex: page,
      );
    } else {
      return await questionsRequest.getQuestions(
        type: "myquestion",
        pageIndex: page,
        spaceUserId: UserService.instance.userId,
      );
    }
  }
}
