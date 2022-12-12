import 'package:flutter_cnblogs/generated/locales.g.dart';
import 'package:get/get.dart';

class AppError extends Error {
  /// 错误码
  final int code;

  /// 错误信息
  final String message;

  /// 是否是Http请求错误
  final bool isHttpError;

  final bool notLogin;

  AppError(
    this.message, {
    this.code = 0,
    this.isHttpError = false,
    this.notLogin = false,
  });
  @override
  String toString() {
    if (isHttpError && message.isEmpty) {
      return statusCodeToString(code);
    }

    return message;
  }

  String statusCodeToString(int statusCode) {
    switch (statusCode) {
      case 400:
        return LocaleKeys.network_status_400.tr;
      case 401:
        return LocaleKeys.network_status_401.tr;
      case 403:
        return LocaleKeys.network_status_403.tr;
      case 404:
        return LocaleKeys.network_status_404.tr;
      case 500:
        return LocaleKeys.network_status_500.tr;
      case 502:
        return LocaleKeys.network_status_502.tr;
      case 503:
        return LocaleKeys.network_status_503.tr;
      default:
        return "${LocaleKeys.network_status_request_error.tr}($statusCode)";
    }
  }
}
