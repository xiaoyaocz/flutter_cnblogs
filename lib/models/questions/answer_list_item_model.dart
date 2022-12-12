import 'dart:convert';

T? asT<T>(dynamic value) {
  if (value is T) {
    return value;
  }
  return null;
}

class AnswerListItemModel {
  AnswerListItemModel({
    required this.qid,
    required this.answerId,
    required this.answer,
    required this.convertedContent,
    required this.formatType,
    required this.userName,
    required this.isBest,
    required this.answerUserInfo,
    this.answerCcomments,
    required this.dateAdded,
    required this.userId,
    required this.diggCount,
    required this.score,
    required this.buryCount,
    required this.commentCounts,
  });

  factory AnswerListItemModel.fromJson(Map<String, dynamic> json) =>
      AnswerListItemModel(
        qid: asT<int>(json['Qid'])!,
        answerId: asT<int>(json['AnswerID'])!,
        answer: asT<String>(json['Answer'])!,
        convertedContent: asT<String?>(json['ConvertedContent']),
        formatType: asT<int>(json['FormatType'])!,
        userName: asT<String>(json['UserName'])!,
        isBest: asT<bool>(json['IsBest'])!,
        answerUserInfo: AnswerUserInfoModel.fromJson(
            asT<Map<String, dynamic>>(json['AnswerUserInfo'])!),
        answerCcomments: asT<Object?>(json['AnswerComments']),
        dateAdded: asT<String>(json['DateAdded'])!,
        userId: asT<int>(json['UserID'])!,
        diggCount: asT<int>(json['DiggCount'])!,
        score: asT<int>(json['Score'])!,
        buryCount: asT<int>(json['BuryCount'])!,
        commentCounts: asT<int>(json['CommentCounts'])!,
      );

  int qid;
  int answerId;
  String answer;
  String? convertedContent;
  int formatType;
  String userName;
  bool isBest;
  int get sort => isBest ? 1 : 0;
  AnswerUserInfoModel answerUserInfo;
  Object? answerCcomments;
  String dateAdded;
  int userId;
  int diggCount;
  int score;
  int buryCount;
  int commentCounts;
  DateTime get addDateTime => DateTime.parse(dateAdded);
  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'Qid': qid,
        'AnswerID': answerId,
        'Answer': answer,
        'ConvertedContent': convertedContent,
        'FormatType': formatType,
        'UserName': userName,
        'IsBest': isBest,
        'AnswerUserInfo': answerUserInfo,
        'AnswerComments': answerCcomments,
        'DateAdded': dateAdded,
        'UserID': userId,
        'DiggCount': diggCount,
        'Score': score,
        'BuryCount': buryCount,
        'CommentCounts': commentCounts,
      };
}

class AnswerUserInfoModel {
  AnswerUserInfoModel({
    required this.userId,
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
    required this.ucUserId,
    required this.isPublishHomeActive,
  });

  factory AnswerUserInfoModel.fromJson(Map<String, dynamic> json) =>
      AnswerUserInfoModel(
        userId: asT<int>(json['UserID'])!,
        userName: asT<String>(json['UserName'])!,
        loginName: asT<String>(json['LoginName'])!,
        userEmail: asT<String>(json['UserEmail'])!,
        iconName: asT<String>(json['IconName'])!,
        alias: asT<String>(json['Alias'])!,
        qScore: asT<int>(json['QScore'])!,
        dateAdded: asT<String>(json['DateAdded'])!,
        userWealth: asT<int>(json['UserWealth'])!,
        userReputation: asT<int?>(json['UserReputation']) ?? 0,
        isActive: asT<bool>(json['IsActive'])!,
        ucUserId: asT<String>(json['UCUserID'])!,
        isPublishHomeActive: asT<bool>(json['IsPublishHomeActive'])!,
      );

  int userId;
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
  String ucUserId;
  bool isPublishHomeActive;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'UserID': userId,
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
        'UCUserID': ucUserId,
        'IsPublishHomeActive': isPublishHomeActive,
      };
}
