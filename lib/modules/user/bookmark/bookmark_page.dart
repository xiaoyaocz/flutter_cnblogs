import 'package:flutter/material.dart';
import 'package:flutter_cnblogs/app/app_style.dart';
import 'package:flutter_cnblogs/app/utils.dart';
import 'package:flutter_cnblogs/generated/locales.g.dart';
import 'package:flutter_cnblogs/modules/user/bookmark/bookmark_controller.dart';
import 'package:flutter_cnblogs/widgets/page_list_view.dart';
import 'package:get/get.dart';

class BookmarkPage extends GetView<BookmarkController> {
  const BookmarkPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          LocaleKeys.bookmark_title.tr,
        ),
      ),
      body: PageListView(
        firstRefresh: true,
        pageController: controller,
        padding: AppStyle.edgeInsetsA12,
        separatorBuilder: (context, index) => AppStyle.vGap12,
        itemBuilder: (_, i) {
          var item = controller.list[i];
          return Dismissible(
            key: Key('key${item.wzLinkId}'),
            background: Container(
              color: Colors.red,
              child: const ListTile(
                trailing: Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
              ),
            ),
            direction: DismissDirection.endToStart,
            confirmDismiss: (direction) async {
              var result = await Utils.showAlertDialog(
                LocaleKeys.bookmark_del_msg.tr,
                title: LocaleKeys.bookmark_del.tr,
              );
              return result;
            },
            onDismissed: ((direction) {
              controller.delete(item);
            }),
            child: InkWell(
              onTap: () => controller.openUrl(item),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: AppStyle.radius8,
                  color: Theme.of(context).cardColor,
                ),
                padding: AppStyle.edgeInsetsA12,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      item.title,
                      style: const TextStyle(fontSize: 16),
                    ),
                    AppStyle.vGap8,
                    Text(
                      LocaleKeys.bookmark_addtime.trParams(
                        {
                          "time": Utils.parseTime(item.addDateTime),
                        },
                      ),
                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
