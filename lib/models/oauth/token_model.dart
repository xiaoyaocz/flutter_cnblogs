import 'dart:convert';

T? asT<T>(dynamic value) {
  if (value is T) {
    return value;
  }
  return null;
}

class TokenModel {
  TokenModel({
    required this.accessToken,
    required this.expiresIn,
    required this.tokenType,
    required this.scope,
  });

  factory TokenModel.fromJson(Map<String, dynamic> json) => TokenModel(
        accessToken: asT<String>(json['access_token'])!,
        expiresIn: asT<int>(json['expires_in'])!,
        tokenType: asT<String>(json['token_type'])!,
        scope: asT<String>(json['scope'])!,
      );

  String accessToken;
  int expiresIn;
  String tokenType;
  String scope;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'access_token': accessToken,
        'expires_in': expiresIn,
        'token_type': tokenType,
        'scope': scope,
      };
}
