import 'package:flutter_cnblogs/app/controller/base_controller.dart';
import 'package:flutter_cnblogs/models/questions/answer_list_item_model.dart';
import 'package:flutter_cnblogs/models/questions/question_list_item_model.dart';
import 'package:flutter_cnblogs/requests/questions_request.dart';
import 'package:get/get.dart';

class QuestionDetailController extends BaseController {
  final int questionId;
  QuestionDetailController(this.questionId);
  final QuestionsRequest request = QuestionsRequest();
  Rx<QuestionListItemModel?> detail = Rx<QuestionListItemModel?>(null);
  RxList<AnswerListItemModel> answers = RxList<AnswerListItemModel>();
  @override
  void onInit() {
    loadData();
    super.onInit();
  }

  void loadData() async {
    detail.value = await request.getQuestionById(questionId: questionId);
    var answerList = await request.getQuestionAnswers(questionId: questionId);
    answerList.sort((b, a) => a.sort.compareTo(b.sort));
    answers.value = answerList;
  }
}
