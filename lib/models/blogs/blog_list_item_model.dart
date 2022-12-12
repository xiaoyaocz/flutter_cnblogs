import 'dart:convert';

T? asT<T>(dynamic value) {
  if (value is T) {
    return value;
  }
  return null;
}

class BlogListItemModel {
  BlogListItemModel({
    required this.id,
    required this.title,
    required this.url,
    required this.description,
    required this.author,
    required this.blogapp,
    required this.avatar,
    required this.postdate,
    required this.viewcount,
    required this.commentcount,
    required this.diggcount,
  });

  factory BlogListItemModel.fromJson(Map<String, dynamic> json) =>
      BlogListItemModel(
        id: asT<int>(json['Id'])!,
        title: asT<String>(json['Title'])!,
        url: asT<String>(json['Url'])!,
        description: asT<String>(json['Description'])!,
        author: asT<String>(json['Author'])!,
        blogapp: asT<String>(json['BlogApp'])!,
        avatar: asT<String>(json['Avatar'])!,
        postdate: asT<String>(json['PostDate'])!,
        viewcount: asT<int>(json['ViewCount'])!,
        commentcount: asT<int>(json['CommentCount'])!,
        diggcount: asT<int>(json['DiggCount'])!,
      );

  int id;
  String title;
  String url;
  String description;
  String author;
  String blogapp;
  String avatar;
  String postdate;
  DateTime get postDateTime => DateTime.parse(postdate);
  int viewcount;
  int commentcount;
  int diggcount;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'Id': id,
        'Title': title,
        'Url': url,
        'Description': description,
        'Author': author,
        'BlogApp': blogapp,
        'Avatar': avatar,
        'PostDate': postdate,
        'ViewCount': viewcount,
        'CommentCount': commentcount,
        'DiggCount': diggcount,
      };
}
