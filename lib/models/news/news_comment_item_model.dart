import 'dart:convert';

T? asT<T>(dynamic value) {
  if (value is T) {
    return value;
  }
  return null;
}

class NewsCommentItemModel {
  NewsCommentItemModel({
    required this.commentID,
    required this.contentID,
    required this.commentContent,
    required this.userGuid,
    required this.userId,
    required this.userName,
    required this.faceUrl,
    required this.floor,
    required this.dateAdded,
    required this.agreeCount,
    required this.antiCount,
    required this.parentCommentID,
    this.parentComment,
  });

  factory NewsCommentItemModel.fromJson(Map<String, dynamic> json) =>
      NewsCommentItemModel(
        commentID: asT<int>(json['CommentID']) ?? 0,
        contentID: asT<int>(json['ContentID']) ?? 0,
        commentContent: asT<String>(json['CommentContent']) ?? "",
        userGuid: asT<String>(json['UserGuid']) ?? "",
        userId: asT<int>(json['UserId']) ?? 0,
        userName: asT<String>(json['UserName']) ?? "",
        faceUrl: asT<String>(json['FaceUrl']) ?? "",
        floor: asT<int>(json['Floor']) ?? 0,
        dateAdded: asT<String>(json['DateAdded']) ?? "",
        agreeCount: asT<int>(json['AgreeCount']) ?? 0,
        antiCount: asT<int>(json['AntiCount']) ?? 0,
        parentCommentID: asT<int>(json['ParentCommentID']) ?? 0,
        parentComment: asT<Object?>(json['ParentComment']),
      );

  int commentID;
  int contentID;
  String commentContent;
  String userGuid;
  int userId;
  String userName;
  String faceUrl;
  int floor;
  String dateAdded;
  int agreeCount;
  int antiCount;
  int parentCommentID;
  Object? parentComment;
  DateTime? get postDateTime => DateTime.tryParse(dateAdded);

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'CommentID': commentID,
        'ContentID': contentID,
        'CommentContent': commentContent,
        'UserGuid': userGuid,
        'UserId': userId,
        'UserName': userName,
        'FaceUrl': faceUrl,
        'Floor': floor,
        'DateAdded': dateAdded,
        'AgreeCount': agreeCount,
        'AntiCount': antiCount,
        'ParentCommentID': parentCommentID,
        'ParentComment': parentComment,
      };
}
