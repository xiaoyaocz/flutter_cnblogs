import 'dart:convert';

T? asT<T>(dynamic value) {
  if (value is T) {
    return value;
  }
  return null;
}

class NewsListItemModel {
  NewsListItemModel({
    required this.id,
    required this.title,
    required this.summary,
    required this.topicId,
    this.topicIcon,
    required this.viewCount,
    required this.commentCount,
    required this.diggCount,
    required this.dateAdded,
  });

  factory NewsListItemModel.fromJson(Map<String, dynamic> json) =>
      NewsListItemModel(
        id: asT<int>(json['Id'])!,
        title: asT<String>(json['Title'])!,
        summary: asT<String>(json['Summary'])!,
        topicId: asT<int>(json['TopicId'])!,
        topicIcon: asT<String?>(json['TopicIcon']),
        viewCount: asT<int>(json['ViewCount'])!,
        commentCount: asT<int>(json['CommentCount'])!,
        diggCount: asT<int>(json['DiggCount'])!,
        dateAdded: asT<String>(json['DateAdded'])!,
      );

  int id;
  String title;
  String summary;
  int topicId;
  String? topicIcon;
  int viewCount;
  int commentCount;
  int diggCount;
  String dateAdded;
  DateTime get postDateTime => DateTime.parse(dateAdded);

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'Id': id,
        'Title': title,
        'Summary': summary,
        'TopicId': topicId,
        'TopicIcon': topicIcon,
        'ViewCount': viewCount,
        'CommentCount': commentCount,
        'DiggCount': diggCount,
        'DateAdded': dateAdded,
      };
}
