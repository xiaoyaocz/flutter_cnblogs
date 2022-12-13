import 'dart:convert';

T? asT<T>(dynamic value) {
  if (value is T) {
    return value;
  }
  return null;
}

class SearchItemModel {
  SearchItemModel({
    this.title,
    this.content,
    this.userName,
    this.userAlias,
    required this.publishTime,
    required this.voteTimes,
    required this.viewTimes,
    required this.commentTimes,
    this.uri,
    this.id,
    this.avatar,
  });

  factory SearchItemModel.fromJson(Map<String, dynamic> json) =>
      SearchItemModel(
        title: asT<String?>(json['Title']) ?? "",
        content: asT<String?>(json['Content']) ?? "",
        userName: asT<String?>(json['UserName']) ?? "",
        userAlias: asT<String?>(json['UserAlias']) ?? "",
        publishTime: asT<String?>(json['PublishTime'])!,
        voteTimes: asT<int>(json['VoteTimes'])!,
        viewTimes: asT<int>(json['ViewTimes'])!,
        commentTimes: asT<int>(json['CommentTimes'])!,
        uri: asT<String?>(json['Uri']) ?? "",
        id: asT<String?>(json['Id']) ?? "",
        avatar: asT<String?>(json['Avatar']) ?? "",
      );

  String? title;
  String? content;
  String? userName;
  String? userAlias;
  String publishTime;
  int voteTimes;
  int viewTimes;
  int commentTimes;
  String? uri;
  String? id;
  String? avatar;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'Title': title,
        'Content': content,
        'UserName': userName,
        'UserAlias': userAlias,
        'PublishTime': publishTime,
        'VoteTimes': voteTimes,
        'ViewTimes': viewTimes,
        'CommentTimes': commentTimes,
        'Uri': uri,
        'Id': id,
        'Avatar': avatar,
      };
}
