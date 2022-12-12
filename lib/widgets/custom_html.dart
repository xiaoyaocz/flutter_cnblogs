import 'package:flutter/material.dart';
import 'package:flutter_cnblogs/app/app_style.dart';
import 'package:flutter_cnblogs/app/utils.dart';
import 'package:flutter_cnblogs/routes/app_navigation.dart';
import 'package:flutter_cnblogs/widgets/net_image.dart';
import 'package:flutter_html/flutter_html.dart';

class CustomHtml extends StatelessWidget {
  final String content;
  const CustomHtml({required this.content, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Html(
      data: content,
      style: {
        "body": Style(
          padding: EdgeInsets.zero,
          margin: Margins.zero,
        ),
        "p": Style(
          lineHeight: LineHeight.em(1.2),
        ),
      },
      customRenders: {
        tagMatcher("img"): CustomRender.widget(
          widget: (context, buildChildren) {
            return Padding(
              padding: AppStyle.edgeInsetsV8,
              child: GestureDetector(
                onTap: () {
                  Utils.showImageViewer(
                    0,
                    [
                      context.tree.attributes["src"].toString(),
                    ],
                  );
                },
                child: NetImage(
                  context.tree.attributes["src"].toString(),
                  borderRadius: 4,
                ),
              ),
            );
          },
        ),
        tagMatcher("pre"): CustomRender.widget(
          widget: (context, buildChildren) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(.1),
                borderRadius: AppStyle.radius4,
                border: Border.all(color: Colors.grey.withOpacity(.2)),
              ),
              width: double.infinity,
              padding: AppStyle.edgeInsetsA8,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Text(
                  context.tree.element!.text,
                  softWrap: false,
                  style: const TextStyle(fontSize: 12),
                ),
              ),
            );
          },
        ),
      },
      onLinkTap: (url, context, attributes, element) async {
        if (url != null) {
          await AppNavigator.toWebView(url);
        }
      },
    );
  }
}
