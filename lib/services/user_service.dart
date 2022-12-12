import 'package:flutter_cnblogs/app/event_bus.dart';
import 'package:flutter_cnblogs/app/log.dart';
import 'package:flutter_cnblogs/models/user/user_info_model.dart';
import 'package:flutter_cnblogs/models/oauth/user_token_model.dart';
import 'package:flutter_cnblogs/requests/oauth_request.dart';
import 'package:flutter_cnblogs/requests/user_request.dart';
import 'package:flutter_cnblogs/routes/route_path.dart';
import 'package:flutter_cnblogs/services/local_storage_service.dart';
import 'package:get/get.dart';

class UserService extends GetxService {
  static UserService get instance => Get.find<UserService>();
  final LocalStorageService storage = Get.find<LocalStorageService>();
  final OAuthRequest authRequest = OAuthRequest();
  final UserRequest userRequest = UserRequest();
  Rx<UserInfoModel?> userProfile = Rx<UserInfoModel?>(null);
  int userId = 0;
  String token = "";
  int expires = 0;
  var logined = false.obs;

  void init() {
    userId = storage.getValue(LocalStorageService.kUserID, 0);
    token = storage.getValue(LocalStorageService.kUserAccessToken, '');
    if (token.isEmpty) {
      return;
    }

    expires = storage.getValue(LocalStorageService.kUserAccessTokenExpiresTime,
        DateTime.now().millisecondsSinceEpoch);
    logined.value = true;
  }

  void setAuthInfo(UserTokenModel info) {
    token = info.accessToken;
    expires = DateTime.now()
        .add(Duration(seconds: info.expiresIn))
        .millisecondsSinceEpoch;
    storage.setValue(LocalStorageService.kUserAccessToken, token);
    storage.setValue(LocalStorageService.kUserAccessTokenExpiresTime, expires);
    storage.setValue(LocalStorageService.kUserRefreshToken, info.refreshToken);
    logined.value = true;
    EventBus.instance.emit(EventBus.kLogined, 0);
    refreshProfile();
  }

  Future<bool> login() async {
    return (await Get.toNamed(RoutePath.kUserLogin)) ?? false;
  }

  Future<bool> refreshToken() async {
    try {
      if (!logined.value) {
        return await login();
      }

      UserTokenModel tokenModel = await authRequest.refreshUserToken(
        storage.getValue(LocalStorageService.kUserRefreshToken, ''),
      );
      setAuthInfo(tokenModel);

      return true;
    } catch (e) {
      Log.logPrint(e);
      return false;
    }
  }

  void logout() {
    userProfile.value = null;
    storage.removeValue(LocalStorageService.kUserID);
    storage.removeValue(LocalStorageService.kUserAccessToken);
    storage.removeValue(LocalStorageService.kUserAccessTokenExpiresTime);
    storage.removeValue(LocalStorageService.kUserRefreshToken);
    logined.value = false;
    EventBus.instance.emit(EventBus.kLogouted, 0);
  }

  /// 刷新个人资料
  Future refreshProfile() async {
    try {
      if (!logined.value) {
        return;
      }
      userProfile.value = await userRequest.getUserInfo();
      userId = userProfile.value?.spaceUserId ?? 0;
      storage.setValue(LocalStorageService.kUserID, userId);
    } catch (e) {
      Log.logPrint(e);
    }
  }
}
