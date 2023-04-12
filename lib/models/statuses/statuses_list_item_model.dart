import 'dart:convert';
import 'dart:math';

T? asT<T>(dynamic value) {
  if (value is T) {
    return value;
  }
  return null;
}

class StatusesListItemModel {
  StatusesListItemModel({
    required this.id,
    required this.content,
    required this.isPrivate,
    required this.isLucky,
    required this.commentCount,
    required this.dateAdded,
    required this.userAlias,
    required this.userDisplayName,
    required this.userIconUrl,
    required this.userId,
    required this.userGuid,
    this.luckyIndex = 0,
  });

  factory StatusesListItemModel.fromJson(Map<String, dynamic> json) =>
      StatusesListItemModel(
        id: asT<int?>(json['Id']) ?? 0,
        content: asT<String?>(json['Content']) ?? "",
        isPrivate: asT<bool?>(json['IsPrivate']) ?? false,
        isLucky: asT<bool?>(json['IsLucky']) ?? false,
        commentCount: asT<int?>(json['CommentCount']) ?? 0,
        dateAdded: asT<String?>(json['DateAdded']) ?? "",
        userAlias: asT<String?>(json['UserAlias']) ?? "",
        userDisplayName: asT<String?>(json['UserDisplayName']) ?? "",
        userIconUrl: asT<String?>(json['UserIconUrl']) ?? "",
        userId: asT<int?>(json['UserId']) ?? 0,
        userGuid: asT<String?>(json['UserGuid']) ?? "",

        // API没有返回是啥星星，只能随机加一个了
        luckyIndex: Random().nextInt(10),
      );

  int id;
  String content;
  bool isPrivate;
  bool isLucky;
  int commentCount;
  String dateAdded;
  String userAlias;
  String userDisplayName;
  String userIconUrl;
  int userId;
  String userGuid;
  DateTime get postDateTime => DateTime.parse(dateAdded);
  int luckyIndex = 0;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'Id': id,
        'Content': content,
        'IsPrivate': isPrivate,
        'IsLucky': isLucky,
        'CommentCount': commentCount,
        'DateAdded': dateAdded,
        'UserAlias': userAlias,
        'UserDisplayName': userDisplayName,
        'UserIconUrl': userIconUrl,
        'UserId': userId,
        'UserGuid': userGuid,
      };
}
