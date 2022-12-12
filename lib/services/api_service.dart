import 'package:flutter_cnblogs/app/log.dart';
import 'package:flutter_cnblogs/models/oauth/token_model.dart';
import 'package:flutter_cnblogs/requests/oauth_request.dart';
import 'package:flutter_cnblogs/services/local_storage_service.dart';
import 'package:get/get.dart';

class ApiService extends GetxService {
  static ApiService get instance => Get.find<ApiService>();
  final LocalStorageService storage = Get.find<LocalStorageService>();
  final OAuthRequest oAuthRequest = OAuthRequest();
  String token = '';
  int expires = 0;

  void init() {
    token = storage.getValue(LocalStorageService.kAccessToken, "");
    expires = storage.getValue(LocalStorageService.kAccessTokenExpiresTime,
        DateTime.now().millisecondsSinceEpoch);
  }

  Future<bool> getToken() async {
    try {
      TokenModel tokenModel = await oAuthRequest.getToken();
      token = tokenModel.accessToken;
      expires = DateTime.now()
          .add(Duration(seconds: tokenModel.expiresIn))
          .millisecondsSinceEpoch;
      storage.setValue(LocalStorageService.kAccessToken, token);
      storage.setValue(LocalStorageService.kAccessTokenExpiresTime, expires);

      return true;
    } catch (e) {
      Log.logPrint(e);
      return false;
    }
  }
}
