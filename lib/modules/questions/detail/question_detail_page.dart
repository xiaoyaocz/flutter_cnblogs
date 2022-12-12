import 'package:flutter/material.dart';
import 'package:flutter_cnblogs/app/app_style.dart';

import 'package:flutter_cnblogs/app/utils.dart';

import 'package:flutter_cnblogs/models/questions/answer_list_item_model.dart';
import 'package:flutter_cnblogs/modules/questions/detail/question_detail_controller.dart';
import 'package:flutter_cnblogs/widgets/custom_html.dart';
import 'package:flutter_cnblogs/widgets/net_image.dart';
import 'package:get/get.dart';
import 'package:remixicon/remixicon.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';

class QuestionDetailPage extends StatelessWidget {
  final int questionId;
  const QuestionDetailPage({required this.questionId, Key? key})
      : super(key: key);

  QuestionDetailController get controller => Get.put(
        QuestionDetailController(
          questionId,
        ),
        tag: questionId.toString(),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("问题详情"),
      ),
      body: Obx(
        () => Stack(
          children: [
            AppStyle.vGap8,
            ListView(
              padding: AppStyle.edgeInsetsA12,
              children: [
                Text.rich(
                  TextSpan(
                    text: "",
                    children: [
                      WidgetSpan(
                        alignment: PlaceholderAlignment.middle,
                        child: Visibility(
                          visible: controller.detail.value?.dealFlag == 1,
                          child: Container(
                            padding: AppStyle.edgeInsetsH4
                                .copyWith(top: 2, bottom: 2),
                            decoration: BoxDecoration(
                              borderRadius: AppStyle.radius4,
                              border: Border.all(
                                color: Colors.green,
                              ),
                            ),
                            margin: AppStyle.edgeInsetsR8,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: const [
                                Icon(
                                  Remix.check_line,
                                  size: 14,
                                  color: Colors.green,
                                ),
                                AppStyle.hGap4,
                                Text(
                                  "已解决",
                                  style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      WidgetSpan(
                        alignment: PlaceholderAlignment.middle,
                        child: Visibility(
                          visible: (controller.detail.value?.award ?? 0) > 0,
                          child: Container(
                            padding: AppStyle.edgeInsetsH4
                                .copyWith(top: 2, bottom: 2),
                            decoration: BoxDecoration(
                              borderRadius: AppStyle.radius4,
                              border: Border.all(
                                color: Colors.orange,
                              ),
                            ),
                            margin: AppStyle.edgeInsetsR8,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Remix.copper_coin_line,
                                  size: 14,
                                  color: Colors.orange,
                                ),
                                AppStyle.hGap4,
                                Text(
                                  controller.detail.value?.award.toString() ??
                                      "",
                                  style: const TextStyle(
                                    color: Colors.orange,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      TextSpan(
                        text: controller.detail.value?.title,
                      ),
                    ],
                  ),
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                AppStyle.vGap8,
                Row(
                  children: [
                    NetImage(
                      controller.detail.value?.questionUserInfo.face ?? '',
                      width: 40,
                      height: 40,
                      borderRadius: 20,
                    ),
                    AppStyle.hGap12,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          controller.detail.value?.questionUserInfo.userName ??
                              '',
                          style: const TextStyle(fontSize: 14),
                        ),
                        Text(
                          "${Utils.parseQuestionLevel(controller.detail.value?.questionUserInfo.qScore ?? 0)} | ${controller.detail.value?.questionUserInfo.qScore.toString() ?? ""}园豆",
                          style:
                              const TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ],
                    ),
                  ],
                ),
                AppStyle.vGap8,
                CustomHtml(
                  content: controller.detail.value?.convertedContent ??
                      (controller.detail.value?.content ?? ''),
                ),
                AppStyle.vGap8,
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: (controller.detail.value?.tags.isEmpty ?? true)
                      ? []
                      : (controller.detail.value?.tags.split(',') ?? [])
                          .map(
                            (e) => Container(
                              decoration: BoxDecoration(
                                borderRadius: AppStyle.radius4,
                                color: Colors.grey.withOpacity(.1),
                              ),
                              padding: AppStyle.edgeInsetsH8
                                  .copyWith(top: 4, bottom: 4),
                              child: Text(
                                e,
                                style: const TextStyle(
                                  height: 1.2,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                ),
                AppStyle.vGap8,
                Row(
                  children: [
                    Text(
                      "提问于${Utils.parseTime(controller.detail.value?.addDateTime)}",
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    AppStyle.hGap12,
                    const Expanded(child: SizedBox()),
                    const Icon(
                      Remix.thumb_up_line,
                      size: 16,
                      color: Colors.grey,
                    ),
                    AppStyle.hGap4,
                    Text(
                      controller.detail.value?.diggcount.toString() ?? "0",
                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ],
                ),
                AppStyle.vGap24,
                StickyHeader(
                  header: Container(
                    padding: AppStyle.edgeInsetsV8.copyWith(left: 4),
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      border: Border.symmetric(
                        horizontal: BorderSide(
                          color: Colors.grey.withOpacity(.2),
                        ),
                      ),
                    ),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "${controller.detail.value?.answercount ?? 0}个回答",
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  content: Stack(
                    children: [
                      ListView.separated(
                        itemCount: controller.answers.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: AppStyle.edgeInsetsT12,
                        itemBuilder: (_, i) {
                          var item = controller.answers[i];
                          return _buildAnswerItem(context, item);
                        },
                        separatorBuilder: (_, i) {
                          return Divider(
                            color: Colors.grey.withOpacity(.2),
                            height: 1,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnswerItem(BuildContext context, AnswerListItemModel item) {
    return Padding(
      padding: AppStyle.edgeInsetsV12,
      child: Column(
        children: [
          Row(
            children: [
              NetImage(
                item.answerUserInfo.iconName,
                width: 40,
                height: 40,
                borderRadius: 20,
              ),
              AppStyle.hGap12,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.answerUserInfo.userName,
                      style: const TextStyle(fontSize: 14),
                    ),
                    Text(
                      "${Utils.parseQuestionLevel(item.answerUserInfo.qScore)} | ${item.answerUserInfo.qScore}园豆",
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: item.isBest,
                child: Container(
                  padding: AppStyle.edgeInsetsH4.copyWith(top: 2, bottom: 2),
                  decoration: BoxDecoration(
                    borderRadius: AppStyle.radius4,
                    border: Border.all(
                      color: Colors.green,
                    ),
                  ),
                  margin: AppStyle.edgeInsetsR8,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Remix.award_fill,
                        size: 14,
                        color: Colors.green,
                      ),
                      AppStyle.hGap4,
                      Text(
                        item.score > 0 ? "园豆+${item.score}" : "最佳答案",
                        style: const TextStyle(
                          color: Colors.green,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          AppStyle.vGap12,
          CustomHtml(
            content: item.convertedContent ?? (item.answer),
          ),
          AppStyle.vGap12,
          Row(
            children: [
              Text(
                Utils.parseTime(item.addDateTime),
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
              AppStyle.hGap12,
              // Visibility(
              //   visible: item.score > 0,
              //   child: Text(
              //     "奖励园豆:${item.score}",
              //     style: const TextStyle(fontSize: 12, color: Colors.orange),
              //   ),
              // ),
              const Expanded(child: SizedBox()),
              buildStat(item),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildStat(AnswerListItemModel item) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppStyle.hGap16,
        const Icon(
          Remix.thumb_up_line,
          size: 16,
          color: Colors.grey,
        ),
        AppStyle.hGap4,
        Text(
          item.diggCount.toString(),
          style: const TextStyle(fontSize: 14, color: Colors.grey),
        ),
        AppStyle.hGap24,
        const Icon(
          Remix.message_2_line,
          size: 16,
          color: Colors.grey,
        ),
        AppStyle.hGap4,
        Text(
          item.commentCounts.toString(),
          style: const TextStyle(fontSize: 14, color: Colors.grey),
        ),
      ],
    );
  }
}
