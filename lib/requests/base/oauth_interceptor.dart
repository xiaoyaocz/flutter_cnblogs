import 'package:dio/dio.dart';
import 'package:flutter_cnblogs/services/api_service.dart';
import 'package:flutter_cnblogs/services/user_service.dart';

class OAuthInterceptor extends Interceptor {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    if (options.extra["withApiAuth"]) {
      var token = "";
      if (UserService.instance.logined.value) {
        token = await getUserToken();
      } else {
        token = await getApiToken();
      }
      options.headers.addAll({"Authorization": "Bearer $token"});
    } else if (options.extra["withUserAuth"]) {
      var token = await getUserToken();
      options.headers.addAll({"Authorization": "Bearer $token"});
    }
    super.onRequest(options, handler);
  }

  Future<String> getApiToken() async {
    //读取Token,判断Token是否过期
    //Token过期则出现读取
    if (ApiService.instance.token.isEmpty ||
        ApiService.instance.expires <= DateTime.now().millisecondsSinceEpoch) {
      //重新请求
      await ApiService.instance.getToken();
    }
    return ApiService.instance.token;
  }

  Future<String> getUserToken() async {
    //读取Token,判断Token是否过期
    //Token过期则出现读取
    if (UserService.instance.token.isEmpty ||
        UserService.instance.expires <= DateTime.now().millisecondsSinceEpoch) {
      //重新请求
      await UserService.instance.refreshToken();
    }
    return UserService.instance.token;
  }
}
