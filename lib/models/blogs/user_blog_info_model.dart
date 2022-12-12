import 'dart:convert';

T? asT<T>(dynamic value) {
  if (value is T) {
    return value;
  }
  return null;
}

class UserBlogInfoModel {
  UserBlogInfoModel({
    required this.blogId,
    required this.title,
    required this.subtitle,
    required this.postCount,
    required this.pageSize,
    required this.enableScript,
  });

  factory UserBlogInfoModel.fromJson(Map<String, dynamic> json) =>
      UserBlogInfoModel(
        blogId: asT<int>(json['blogId'])!,
        title: asT<String>(json['title'])!,
        subtitle: asT<String>(json['subtitle'])!,
        postCount: asT<int>(json['postCount'])!,
        pageSize: asT<int>(json['pageSize'])!,
        enableScript: asT<bool>(json['enableScript'])!,
      );

  int blogId;
  String title;
  String subtitle;
  int postCount;
  int pageSize;
  bool enableScript;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'blogId': blogId,
        'title': title,
        'subtitle': subtitle,
        'postCount': postCount,
        'pageSize': pageSize,
        'enableScript': enableScript,
      };
}
