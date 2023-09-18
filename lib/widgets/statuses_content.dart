import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cnblogs/app/app_style.dart';
import 'package:flutter_cnblogs/routes/app_navigation.dart';
import 'package:flutter_cnblogs/widgets/net_image.dart';

class StatusesContent extends StatelessWidget {
  final String content;
  final int luckyIndex;
  final bool isLucky;
  const StatusesContent({
    required this.content,
    this.luckyIndex = 0,
    this.isLucky = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return buildContent(context);
  }

  Widget buildContent(BuildContext context) {
    List<InlineSpan> children = [];
    var text = content;
    //替换@At
    var atMatches = RegExp(
      r'<a.href="https://home.cnblogs.com/u/(.*?)/".*?>(.*?)</a>',
      multiLine: true,
    ).allMatches(text);
    //去除重复的链接

    for (var item in atMatches) {
      text = text.replaceAll(
          item.group(0)!, "\$|[a:${item.group(2)}a:${item.group(1)!}\$|");
    }

    //替换链接
    RegExp regex = RegExp(
        r"(http(s)?:\/\/)[a-zA-Z0-9][-a-zA-Z0-9]{0,62}(\.[a-zA-Z0-9][-a-zA-Z0-9]{0,62})+(:[0-9]{1,5})?[-a-zA-Z0-9()@:%_\\\+\.~#?&//=]*",
        multiLine: true);
    var matches = regex.allMatches(text);
    //去除重复的链接
    var ls = matches.map((e) => e.group(0)).toSet();
    for (var item in ls) {
      text = text.replaceAll(item!, "\$|[l:$item\$|");
    }

    var tagMatches = RegExp(
      r'\[(.*?)\]',
      multiLine: true,
    ).allMatches(text);
    //去除重复的标签
    var tagLs = tagMatches.map((e) => e.group(1)).toSet();
    //替换标签
    for (var item in tagLs) {
      var name = "[$item]";
      text = text.replaceAll(name, "\$|[t:#$item#\$|");
    }

    //分割文本
    var sp = text.split("\$|");
    for (var item in sp) {
      if (item.contains("[a:")) {
        var items = item.split("a:");
        children.add(_buildAt(items[1], items[2]));
      } else if (item.contains("[t:")) {
        var name = item.replaceAll("[t:", "");
        children.add(_buildTag(name, ""));
      } else if (item.contains("[l:")) {
        var link = item.replaceAll("[l:", "");
        children.add(_buildLink(context, link));
      } else if (item.isNotEmpty) {
        children.add(_buildText(item));
      }
    }
    if (isLucky) {
      children.add(_buildLuckyStar());
    }
    return SelectableText.rich(
      TextSpan(
        style: TextStyle(
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.white
              : Colors.black,
          height: 1.8,
        ),
        children: children,
      ),
      scrollPhysics: const NeverScrollableScrollPhysics(),
    );
  }

  InlineSpan _buildText(String text) {
    return TextSpan(
      text: text,
      style: const TextStyle(height: 1.8),
    );
  }

  InlineSpan _buildAt(String userName, String userId) {
    return WidgetSpan(
      alignment: PlaceholderAlignment.middle,
      child: InkWell(
        onTap: () {
          // 没有提供用户相关信息的API，直接打开网页
          AppNavigator.toWebView('https://home.cnblogs.com/u/$userId/');
        },
        child: Text(
          userName,
          style: const TextStyle(color: Colors.blue),
        ),
      ),
    );
  }

  InlineSpan _buildTag(String topicName, String topicId) {
    return WidgetSpan(
      alignment: PlaceholderAlignment.middle,
      child: Padding(
        padding: AppStyle.edgeInsetsR4,
        child: InkWell(
          onTap: () {
            debugPrint("打开标签:$topicName");
          },
          child: Text(
            topicName,
            style: const TextStyle(color: Colors.blue),
          ),
        ),
      ),
    );
  }

  InlineSpan _buildLink(BuildContext context, String url) {
    return WidgetSpan(
      alignment: PlaceholderAlignment.middle,
      child: InkWell(
        onTap: () {
          AppNavigator.toWebView(url);
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              CupertinoIcons.link,
              color: Colors.blue,
              size: 16,
            ),
            Text(
              url.contains("cnblogs.com") ? " 站内链接" : " 站外链接",
              style: const TextStyle(color: Colors.blue),
            ),
          ],
        ),
      ),
    );
  }

  static const List<String> starImages = [
    'https://common.cnblogs.com/images/ing/lucky-star-3-0.png',
    'https://common.cnblogs.com/images/ing/lucky-star-3-1.png',
    'https://common.cnblogs.com/images/ing/lucky-star-3-2.png',
    'https://common.cnblogs.com/images/ing/lucky-star-3-3.png',
    'https://common.cnblogs.com/images/ing/lucky-star-3-4.png',
    'https://common.cnblogs.com/images/ing/lucky-star-3-5.png',
    'https://common.cnblogs.com/images/ing/lucky-star-3-6.png',
    'https://common.cnblogs.com/images/ing/lucky-star-3-7.png',
    'https://common.cnblogs.com/images/ing/lucky-star-8-dancing.png',
    'https://common.cnblogs.com/images/ing/lucky-star-9-glasses.png',
  ];
  InlineSpan _buildLuckyStar() {
    return WidgetSpan(
      alignment: PlaceholderAlignment.bottom,
      child: Padding(
        padding: AppStyle.edgeInsetsL8,
        child: NetImage(
          starImages[luckyIndex],
          width: 32,
          height: 32,
        ),
      ),
    );
  }
}
