import 'dart:convert';

T? asT<T>(dynamic value) {
  if (value is T) {
    return value;
  }
  return null;
}

class BlogContentModel {
  BlogContentModel({
    required this.id,
    required this.title,
    required this.url,
    required this.description,
    required this.viewCount,
    required this.diggCount,
    required this.commentCount,
    required this.author,
    required this.avatar,
    required this.blogId,
    required this.blogApp,
    required this.dateAdded,
    required this.dateUpdated,
    required this.body,
    this.tags,
    this.categories,
  });

  factory BlogContentModel.fromJson(Map<String, dynamic> json) {
    final List<String>? tags = json['tags'] is List ? <String>[] : null;
    if (tags != null) {
      for (final dynamic item in json['tags']!) {
        if (item != null) {
          tags.add(asT<String>(item)!);
        }
      }
    }

    final List<String>? categories =
        json['categories'] is List ? <String>[] : null;
    if (categories != null) {
      for (final dynamic item in json['categories']!) {
        if (item != null) {
          categories.add(asT<String>(item)!);
        }
      }
    }
    return BlogContentModel(
      id: asT<int>(json['id'])!,
      title: asT<String?>(json['title']) ?? "",
      url: asT<String?>(json['url']) ?? "",
      description: asT<String?>(json['description']) ?? "",
      viewCount: asT<int>(json['viewCount'])!,
      diggCount: asT<int>(json['diggCount'])!,
      commentCount: asT<int>(json['commentCount'])!,
      author: asT<String?>(json['author']) ?? "",
      avatar: asT<String?>(json['avatar']) ?? "",
      blogId: asT<int>(json['blogId'])!,
      blogApp: asT<String?>(json['blogApp']) ?? "",
      dateAdded: asT<String?>(json['dateAdded']) ?? "",
      dateUpdated: asT<String?>(json['dateUpdated']) ?? "",
      body: asT<String?>(json['body']) ?? "",
      tags: tags,
      categories: categories,
    );
  }

  int id;
  String title;
  String url;
  String description;
  int viewCount;
  int diggCount;
  int commentCount;
  String author;
  String avatar;
  int blogId;
  String blogApp;
  String dateAdded;
  String dateUpdated;
  String body;
  List<String>? tags;
  List<String>? categories;
  DateTime get postDateTime => DateTime.parse(dateUpdated);

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'title': title,
        'url': url,
        'description': description,
        'viewCount': viewCount,
        'diggCount': diggCount,
        'commentCount': commentCount,
        'author': author,
        'avatar': avatar,
        'blogId': blogId,
        'blogApp': blogApp,
        'dateAdded': dateAdded,
        'dateUpdated': dateUpdated,
        'body': body,
        'tags': tags,
        'categories': categories,
      };
}
