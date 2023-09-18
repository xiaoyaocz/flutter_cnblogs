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
      shrinkWrap: true,
      style: {
        "body": Style(
          padding: HtmlPaddings.zero,
          margin: Margins.zero,
        ),
        "p": Style(
          lineHeight: LineHeight.em(1.2),
        ),
      },
      extensions: [
        TagExtension(
          tagsToExtend: {"img"},
          builder: (extensionContext) {
            return Padding(
              padding: AppStyle.edgeInsetsV8,
              child: GestureDetector(
                onTap: () {
                  Utils.showImageViewer(
                    0,
                    [
                      extensionContext.attributes["src"].toString(),
                    ],
                  );
                },
                child: NetImage(
                  extensionContext.attributes["src"].toString(),
                  borderRadius: 4,
                ),
              ),
            );
          },
        ),
        TagExtension(
          tagsToExtend: {"pre"},
          builder: (extensionContext) {
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
                  extensionContext.element!.text,
                  softWrap: false,
                  style: const TextStyle(fontSize: 12),
                ),
              ),
            );
          },
        ),
      ],
      onLinkTap: (url, attributes, element) async {
        if (url != null) {
          await AppNavigator.toWebView(url);
        }
      },
    );
  }
}
