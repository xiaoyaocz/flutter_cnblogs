import 'dart:convert';

T? asT<T>(dynamic value) {
  if (value is T) {
    return value;
  }
  return null;
}

class BlogListItemV2Model {
  BlogListItemV2Model({
    required this.id,
    required this.title,
    required this.url,
    required this.description,
    required this.viewCount,
    required this.diggCount,
    required this.commentCount,
    required this.author,
    required this.blogId,
    required this.blogUrl,
    required this.avatar,
    required this.postType,
    required this.postConfig,
    required this.dateAdded,
    required this.dateUpdated,
    this.entryName,
  });

  factory BlogListItemV2Model.fromJson(Map<String, dynamic> json) =>
      BlogListItemV2Model(
        id: asT<int>(json['id'])!,
        title: asT<String>(json['title'])!,
        url: asT<String>(json['url'])!,
        description: asT<String>(json['description'])!,
        viewCount: asT<int>(json['viewCount'])!,
        diggCount: asT<int>(json['diggCount'])!,
        commentCount: asT<int>(json['commentCount'])!,
        author: asT<String>(json['author'])!,
        blogId: asT<int>(json['blogId'])!,
        blogUrl: asT<String>(json['blogUrl'])!,
        avatar: asT<String?>(json['avatar']) ?? "",
        postType: asT<int>(json['postType'])!,
        postConfig: asT<int>(json['postConfig'])!,
        dateAdded: asT<String>(json['dateAdded'])!,
        dateUpdated: asT<String>(json['dateUpdated'])!,
        entryName: asT<String?>(json['entryName']),
      );

  int id;
  String title;
  String url;
  String description;
  int viewCount;
  int diggCount;
  int commentCount;
  String author;
  int blogId;
  String blogUrl;
  String avatar;
  int postType;
  int postConfig;
  String dateAdded;
  String dateUpdated;
  String? entryName;

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
        'blogId': blogId,
        'blogUrl': blogUrl,
        'avatar': avatar,
        'postType': postType,
        'postConfig': postConfig,
        'dateAdded': dateAdded,
        'dateUpdated': dateUpdated,
        'entryName': entryName,
      };
}
