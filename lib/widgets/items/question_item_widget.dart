import 'package:flutter/material.dart';
import 'package:flutter_cnblogs/app/app_style.dart';
import 'package:flutter_cnblogs/app/utils.dart';
import 'package:flutter_cnblogs/generated/locales.g.dart';
import 'package:flutter_cnblogs/models/questions/question_list_item_model.dart';
import 'package:flutter_cnblogs/routes/app_navigation.dart';
import 'package:flutter_cnblogs/widgets/net_image.dart';
import 'package:get/get.dart';
import 'package:remixicon/remixicon.dart';

class QuestionItemWidget extends StatelessWidget {
  final QuestionListItemModel item;

  const QuestionItemWidget(this.item, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: AppStyle.edgeInsetsB8,
      child: InkWell(
        onTap: () {
          AppNavigator.toQuestionDetail(item.qid);
        },
        borderRadius: AppStyle.radius4,
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: AppStyle.radius4,
          ),
          padding: AppStyle.edgeInsetsA8,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: AppStyle.radius4,
                  border: Border.all(
                    color: Colors.grey.withOpacity(.2),
                  ),
                ),
                width: 40,
                padding: AppStyle.edgeInsetsA8,
                child: Column(
                  children: [
                    Text(
                      item.answercount.toString(),
                      style: item.answercount > 0
                          ? const TextStyle(
                              fontSize: 14,
                              color: Colors.orange,
                              fontWeight: FontWeight.bold,
                            )
                          : const TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    AppStyle.vGap4,
                    const Text(
                      "回答",
                      style: TextStyle(fontSize: 10, color: Colors.grey),
                    ),
                  ],
                ),
              ),
              AppStyle.hGap8,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text.rich(
                      TextSpan(
                        text: "",
                        children: [
                          WidgetSpan(
                            alignment: PlaceholderAlignment.middle,
                            child: Visibility(
                              visible: item.dealFlag == 1,
                              child: Container(
                                padding: AppStyle.edgeInsetsH4,
                                decoration: BoxDecoration(
                                  borderRadius: AppStyle.radius4,
                                  border: Border.all(
                                    color: Colors.green,
                                  ),
                                ),
                                margin: AppStyle.edgeInsetsR4,
                                child: const Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
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
                              visible: item.award > 0,
                              child: Container(
                                padding: AppStyle.edgeInsetsH4,
                                decoration: BoxDecoration(
                                  borderRadius: AppStyle.radius4,
                                  border: Border.all(
                                    color: Colors.orange,
                                  ),
                                ),
                                margin: AppStyle.edgeInsetsR4,
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
                                      item.award.toString(),
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
                            text: item.title,
                          ),
                        ],
                      ),
                      style: const TextStyle(fontSize: 16),
                    ),
                    AppStyle.vGap8,
                    Text(
                      item.summary,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    AppStyle.vGap8,
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: item.tags.isEmpty
                          ? []
                          : item.tags
                              .split(',')
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
                        buildAuthor(),
                        const Expanded(child: SizedBox()),
                        Text(
                          LocaleKeys.blogs_home_posttime.trParams({
                            "time": Utils.parseTime(item.addDateTime),
                          }),
                          style:
                              const TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildAuthor() {
    return InkWell(
      onTap: () {},
      borderRadius: AppStyle.radius4,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          NetImage(
            item.questionUserInfo.face,
            borderRadius: 24,
            width: 24,
            height: 24,
          ),
          AppStyle.hGap8,
          Text(
            item.questionUserInfo.userName,
            style: const TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget buildStat() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(
          Remix.eye_line,
          size: 16,
          color: Colors.grey,
        ),
        AppStyle.hGap4,
        Text(
          item.award.toString(),
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        ),
        AppStyle.hGap16,
        const Icon(
          Remix.thumb_up_line,
          size: 16,
          color: Colors.grey,
        ),
        AppStyle.hGap4,
        Text(
          item.diggcount.toString(),
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        ),
      ],
    );
  }
}
