import 'dart:convert';

T? asT<T>(dynamic value) {
  if (value is T) {
    return value;
  }
  return null;
}

class AnswerCommentListItemModel {
  AnswerCommentListItemModel({
    required this.commentID,
    required this.content,
    required this.convertedContent,
    required this.formatType,
    required this.parentCommentId,
    required this.postUserID,
    required this.postUserName,
    this.postUserQTitle,
    required this.dateAdded,
    required this.contentType,
    required this.contentID,
    required this.postUserInfo,
    required this.diggCount,
    required this.buryCount,
  });

  factory AnswerCommentListItemModel.fromJson(Map<String, dynamic> json) =>
      AnswerCommentListItemModel(
        commentID: asT<int>(json['CommentID'])!,
        content: asT<String>(json['Content'])!,
        convertedContent: asT<String>(json['ConvertedContent'])!,
        formatType: asT<int>(json['FormatType'])!,
        parentCommentId: asT<int>(json['ParentCommentId'])!,
        postUserID: asT<int>(json['PostUserID'])!,
        postUserName: asT<String>(json['PostUserName'])!,
        postUserQTitle: asT<Object?>(json['PostUserQTitle']),
        dateAdded: asT<String>(json['DateAdded'])!,
        contentType: asT<int>(json['ContentType'])!,
        contentID: asT<int>(json['ContentID'])!,
        postUserInfo: AnswerCommentListItemUserInfoModel.fromJson(
            asT<Map<String, dynamic>>(json['PostUserInfo'])!),
        diggCount: asT<int>(json['DiggCount'])!,
        buryCount: asT<int>(json['BuryCount'])!,
      );

  int commentID;
  String content;
  String convertedContent;
  int formatType;
  int parentCommentId;
  int postUserID;
  String postUserName;
  Object? postUserQTitle;
  String dateAdded;
  int contentType;
  int contentID;
  AnswerCommentListItemUserInfoModel postUserInfo;
  int diggCount;
  int buryCount;
  DateTime get addDateTime => DateTime.parse(dateAdded);

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'CommentID': commentID,
        'Content': content,
        'ConvertedContent': convertedContent,
        'FormatType': formatType,
        'ParentCommentId': parentCommentId,
        'PostUserID': postUserID,
        'PostUserName': postUserName,
        'PostUserQTitle': postUserQTitle,
        'DateAdded': dateAdded,
        'ContentType': contentType,
        'ContentID': contentID,
        'PostUserInfo': postUserInfo,
        'DiggCount': diggCount,
        'BuryCount': buryCount,
      };
}

class AnswerCommentListItemUserInfoModel {
  AnswerCommentListItemUserInfoModel({
    required this.userID,
    required this.userName,
    required this.loginName,
    required this.userEmail,
    required this.iconName,
    required this.alias,
    required this.qScore,
    required this.dateAdded,
    required this.userWealth,
    required this.userReputation,
    required this.isActive,
    required this.ucUserID,
    required this.isPublishHomeActive,
  });

  factory AnswerCommentListItemUserInfoModel.fromJson(
          Map<String, dynamic> json) =>
      AnswerCommentListItemUserInfoModel(
        userID: asT<int>(json['UserID'])!,
        userName: asT<String>(json['UserName'])!,
        loginName: asT<String>(json['LoginName'])!,
        userEmail: asT<String>(json['UserEmail'])!,
        iconName: asT<String>(json['IconName'])!,
        alias: asT<String>(json['Alias'])!,
        qScore: asT<int>(json['QScore'])!,
        dateAdded: asT<String>(json['DateAdded'])!,
        userWealth: asT<int>(json['UserWealth'])!,
        userReputation: asT<int>(json['UserReputation'])!,
        isActive: asT<bool>(json['IsActive'])!,
        ucUserID: asT<String>(json['UCUserID'])!,
        isPublishHomeActive: asT<bool>(json['IsPublishHomeActive'])!,
      );

  int userID;
  String userName;
  String loginName;
  String userEmail;
  String iconName;
  String alias;
  int qScore;
  String dateAdded;
  int userWealth;
  int userReputation;
  bool isActive;
  String ucUserID;
  bool isPublishHomeActive;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'UserID': userID,
        'UserName': userName,
        'LoginName': loginName,
        'UserEmail': userEmail,
        'IconName': iconName,
        'Alias': alias,
        'QScore': qScore,
        'DateAdded': dateAdded,
        'UserWealth': userWealth,
        'UserReputation': userReputation,
        'IsActive': isActive,
        'UCUserID': ucUserID,
        'IsPublishHomeActive': isPublishHomeActive,
      };
}
