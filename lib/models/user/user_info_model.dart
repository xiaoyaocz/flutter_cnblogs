import 'dart:convert';

T? asT<T>(dynamic value) {
  if (value is T) {
    return value;
  }
  return null;
}

class UserInfoModel {
  UserInfoModel({
    required this.userId,
    required this.spaceUserId,
    this.blogId,
    required this.displayName,
    required this.face,
    required this.avatar,
    required this.seniority,
    this.blogApp,
    required this.followerCount,
    required this.followingCount,
  });

  factory UserInfoModel.fromJson(Map<String, dynamic> json) => UserInfoModel(
        userId: asT<String>(json['UserId'])!,
        spaceUserId: asT<int>(json['SpaceUserID'])!,
        blogId: asT<int?>(json['BlogId']),
        displayName: asT<String>(json['DisplayName'])!,
        face: asT<String>(json['Face'])!,
        avatar: asT<String>(json['Avatar'])!,
        seniority: asT<String>(json['Seniority'])!,
        blogApp: asT<String?>(json['BlogApp']),
        followingCount: asT<int?>(json['FollowingCount']) ?? 0,
        followerCount: asT<int?>(json['FollowerCount']) ?? 0,
      );

  String userId;
  int spaceUserId;
  int? blogId;
  String displayName;
  String face;
  String avatar;
  String seniority;
  String? blogApp;
  int followingCount;
  int followerCount;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'UserId': userId,
        'SpaceUserId': spaceUserId,
        'BlogId': blogId,
        'DisplayName': displayName,
        'Face': face,
        'Avatar': avatar,
        'Seniority': seniority,
        'BlogApp': blogApp,
      };
}
