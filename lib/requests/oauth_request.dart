import 'package:flutter_cnblogs/models/oauth/token_model.dart';
import 'package:flutter_cnblogs/models/oauth/user_token_model.dart';
import 'package:flutter_cnblogs/requests/base/api.dart';
import 'package:flutter_cnblogs/requests/base/http_client.dart';

class OAuthRequest {
  /// Client_Credentials授权
  Future<TokenModel> getToken() async {
    var result = await HttpClient.instance.post(
      '/token',
      data: {
        "client_id": Api.kClientID,
        "client_secret": Api.kClientSecret,
        "grant_type": "client_credentials",
      },
      formUrlEncoded: true,
      isRetry: true,
    );
    TokenModel tokenModel = TokenModel.fromJson(result);
    return tokenModel;
  }

  /// Authorization_Code授权
  Future<UserTokenModel> getUserToken(String code) async {
    var result = await HttpClient.instance.post(
      '/connect/token',
      baseUrl: Api.kOAuthBaseUrl,
      data: {
        "client_id": Api.kClientID,
        "client_secret": Api.kClientSecret,
        "grant_type": "authorization_code",
        "code": code,
        "redirect_uri": "https://oauth.cnblogs.com/auth/callback",
      },
      formUrlEncoded: true,
      isRetry: true,
    );
    UserTokenModel tokenModel = UserTokenModel.fromJson(result);
    return tokenModel;
  }

  /// 刷新Token
  Future<UserTokenModel> refreshUserToken(String refreshToken) async {
    var result = await HttpClient.instance.post(
      '/connect/token',
      baseUrl: Api.kOAuthBaseUrl,
      data: {
        "client_id": Api.kClientID,
        "client_secret": Api.kClientSecret,
        "grant_type": "refresh_token",
        "refresh_token": refreshToken,
        "redirect_uri": "https://oauth.cnblogs.com/auth/callback",
      },
      formUrlEncoded: true,
      isRetry: true,
    );
    UserTokenModel tokenModel = UserTokenModel.fromJson(result);
    return tokenModel;
  }
}
