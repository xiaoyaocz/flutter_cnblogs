import 'dart:convert';

T? asT<T>(dynamic value) {
  if (value is T) {
    return value;
  }
  return null;
}

class UserTokenModel {
  UserTokenModel({
    required this.idToken,
    required this.accessToken,
    required this.expiresIn,
    required this.tokenType,
    required this.refreshToken,
  });

  factory UserTokenModel.fromJson(Map<String, dynamic> json) => UserTokenModel(
        idToken: asT<String>(json['id_token'])!,
        accessToken: asT<String>(json['access_token'])!,
        expiresIn: asT<int>(json['expires_in'])!,
        tokenType: asT<String>(json['token_type'])!,
        refreshToken: asT<String>(json['refresh_token'])!,
      );

  String idToken;
  String accessToken;
  int expiresIn;
  String tokenType;
  String refreshToken;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id_token': idToken,
        'access_token': accessToken,
        'expires_in': expiresIn,
        'token_type': tokenType,
        'refresh_token': refreshToken,
      };
}
