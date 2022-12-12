import 'dart:convert';

T? asT<T>(dynamic value) {
  if (value is T) {
    return value;
  }
  return null;
}

class StatusesCommentItemModel {
  StatusesCommentItemModel({
    required this.id,
    required this.content,
    required this.dateAdded,
    required this.statusId,
    required this.userAlias,
    required this.userDisplayName,
    required this.userIconUrl,
    required this.userId,
    required this.userGuid,
  });

  factory StatusesCommentItemModel.fromJson(Map<String, dynamic> json) =>
      StatusesCommentItemModel(
        id: asT<int>(json['Id'])!,
        content: asT<String>(json['Content'])!,
        dateAdded: asT<String>(json['DateAdded'])!,
        statusId: asT<int>(json['StatusId'])!,
        userAlias: asT<String>(json['UserAlias'])!,
        userDisplayName: asT<String>(json['UserDisplayName'])!,
        userIconUrl: asT<String>(json['UserIconUrl'])!,
        userId: asT<int>(json['UserId'])!,
        userGuid: asT<String>(json['UserGuid'])!,
      );

  int id;
  String content;
  String dateAdded;
  int statusId;
  String userAlias;
  String userDisplayName;
  String userIconUrl;
  int userId;
  String userGuid;
  DateTime get postDateTime => DateTime.parse(dateAdded);

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'Id': id,
        'Content': content,
        'DateAdded': dateAdded,
        'StatusId': statusId,
        'UserAlias': userAlias,
        'UserDisplayName': userDisplayName,
        'UserIconUrl': userIconUrl,
        'UserId': userId,
        'UserGuid': userGuid,
      };
}
