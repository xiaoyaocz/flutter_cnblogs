import 'dart:convert';

T? asT<T>(dynamic value) {
  if (value is T) {
    return value;
  }
  return null;
}

class QuestionListItemModel {
  QuestionListItemModel({
    required this.qid,
    required this.dealFlag,
    required this.viewCount,
    required this.title,
    required this.content,
    required this.summary,
    required this.questionUserInfo,
    required this.dateadded,
    this.supply,
    this.addition,
    this.convertedContent,
    required this.formattype,
    required this.tags,
    required this.answercount,
    required this.userid,
    required this.award,
    required this.diggcount,
    required this.burycount,
    required this.isbest,
    this.answeruserid,
    required this.flags,
    this.dateended,
    required this.qurl,
  });

  factory QuestionListItemModel.fromJson(Map<String, dynamic> json) =>
      QuestionListItemModel(
        qid: asT<int>(json['Qid'])!,
        dealFlag: asT<int>(json['DealFlag'])!,
        viewCount: asT<int>(json['ViewCount'])!,
        title: asT<String>(json['Title'])!,
        content: asT<String>(json['Content'])!,
        summary: asT<String?>(json['Summary']) ?? "",
        questionUserInfo: QuestionUserInfoModel.fromJson(
            asT<Map<String, dynamic>>(json['QuestionUserInfo'])!),
        dateadded: asT<String>(json['DateAdded'])!,
        supply: asT<Object?>(json['Supply']),
        addition: asT<Object?>(json['Addition']),
        convertedContent: asT<String?>(json['ConvertedContent']),
        formattype: asT<int>(json['FormatType'])!,
        tags: asT<String?>(json['Tags']) ?? "",
        answercount: asT<int>(json['AnswerCount'])!,
        userid: asT<int>(json['UserId'])!,
        award: asT<int>(json['Award'])!,
        diggcount: asT<int>(json['DiggCount'])!,
        burycount: asT<int>(json['BuryCount'])!,
        isbest: asT<bool>(json['IsBest'])!,
        answeruserid: asT<int?>(json['AnswerUserId']),
        flags: asT<int>(json['Flags'])!,
        dateended: asT<String?>(json['DateEnded']),
        qurl: asT<String>(json['QUrl'])!,
      );

  int qid;
  int dealFlag;
  int viewCount;
  String title;
  String content;
  String summary;
  QuestionUserInfoModel questionUserInfo;
  String dateadded;
  Object? supply;
  Object? addition;
  String? convertedContent;
  int formattype;
  String tags;
  int answercount;
  int userid;
  int award;
  int diggcount;
  int burycount;
  bool isbest;
  int? answeruserid;
  int flags;
  String? dateended;
  String qurl;
  DateTime get addDateTime => DateTime.parse(dateadded);

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'Qid': qid,
        'DealFlag': dealFlag,
        'ViewCount': viewCount,
        'Title': title,
        'Content': content,
        'Summary': summary,
        'QuestionUserInfo': questionUserInfo,
        'DateAdded': dateadded,
        'Supply': supply,
        'Addition': addition,
        'ConvertedContent': convertedContent,
        'FormatType': formattype,
        'Tags': tags,
        'AnswerCount': answercount,
        'UserId': userid,
        'Award': award,
        'DiggCount': diggcount,
        'BuryCount': burycount,
        'IsBest': isbest,
        'AnswerUserId': answeruserid,
        'Flags': flags,
        'DateEnded': dateended,
        'QUrl': qurl,
      };
}

class QuestionUserInfoModel {
  QuestionUserInfoModel({
    required this.userId,
    required this.userName,
    required this.loginName,
    required this.iconName,
    required this.alias,
    required this.qScore,
    required this.dateAdded,
    required this.userWealth,
    required this.userreputation,
    required this.isActive,
    required this.ucUserId,
    required this.isPublishHomeActive,
    required this.face,
  });

  factory QuestionUserInfoModel.fromJson(Map<String, dynamic> json) =>
      QuestionUserInfoModel(
        userId: asT<int>(json['UserID'])!,
        userName: asT<String>(json['UserName'])!,
        loginName: asT<String>(json['LoginName'])!,
        iconName: asT<String?>(json['IconName']) ?? "",
        alias: asT<String?>(json['Alias']) ?? "",
        qScore: asT<int>(json['QScore'])!,
        dateAdded: asT<String>(json['DateAdded'])!,
        userWealth: asT<int?>(json['UserWealth']) ?? 0,
        userreputation: asT<int?>(json['UserReputation']) ?? 0,
        isActive: asT<bool>(json['IsActive'])!,
        ucUserId: asT<String>(json['UCUserID'])!,
        isPublishHomeActive: asT<bool>(json['IsPublishHomeActive'])!,
        face: asT<String>(json['Face'])!,
      );

  int userId;
  String userName;
  String loginName;
  String iconName;
  String alias;
  int qScore;
  String dateAdded;
  int userWealth;
  int userreputation;
  bool isActive;
  String ucUserId;
  bool isPublishHomeActive;
  String face;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'UserID': userId,
        'UserName': userName,
        'LoginName': loginName,
        'IconName': iconName,
        'Alias': alias,
        'QScore': qScore,
        'DateAdded': dateAdded,
        'UserWealth': userWealth,
        'UserReputation': userreputation,
        'IsActive': isActive,
        'UCUserID': ucUserId,
        'IsPublishHomeActive': isPublishHomeActive,
        'Face': face,
      };
}
