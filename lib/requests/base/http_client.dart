import 'package:dio/dio.dart';
import 'package:flutter_cnblogs/app/app_error.dart';
import 'package:flutter_cnblogs/generated/locales.g.dart';
import 'package:flutter_cnblogs/requests/base/api.dart';
import 'package:flutter_cnblogs/requests/base/app_log_interceptor.dart';
import 'package:flutter_cnblogs/requests/base/oauth_interceptor.dart';
import 'package:flutter_cnblogs/services/api_service.dart';
import 'package:flutter_cnblogs/services/user_service.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';

class HttpClient {
  static HttpClient? _httpUtil;

  static HttpClient get instance {
    _httpUtil ??= HttpClient();
    return _httpUtil!;
  }

  late Dio dio;
  HttpClient() {
    dio = Dio(
      BaseOptions(
        baseUrl: Api.kBaseUrl,
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
        sendTimeout: const Duration(seconds: 15),
      ),
    );
    dio.interceptors.addAll([
      AppLogInterceptor(),
      OAuthInterceptor(),
    ]);
  }

  /// Get请求，返回Map
  /// * [path] 请求链接
  /// * [cancel] 任务取消Token
  /// * [queryParameters] 请求参数
  /// * [header] 请求头
  /// * [withApiAuth] 是否需要API认证
  /// * [withUserAuth] 是否需要用户认证
  /// * [isRetry] 是否重试
  Future<dynamic> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? header,
    String? baseUrl,
    CancelToken? cancel,
    bool withApiAuth = false,
    bool withUserAuth = false,
    bool isRetry = false,
    ResponseType responseType = ResponseType.json,
  }) async {
    if (withUserAuth && !UserService.instance.logined.value) {
      throw AppError(LocaleKeys.state_not_login, notLogin: true);
    }
    baseUrl ??= Api.kBaseUrl;
    queryParameters ??= {};
    try {
      header ??= {};

      var result = await dio.get(
        baseUrl + path,
        queryParameters: queryParameters,
        options: Options(
          responseType: responseType,
          headers: header,
          extra: {
            "withApiAuth": withApiAuth,
            "withUserAuth": withUserAuth,
          },
        ),
        cancelToken: cancel,
      );
      return result.data;
    } catch (e) {
      var result = await handelError(e, withApiAuth, withUserAuth, isRetry);
      if (result) {
        return await get(
          path,
          queryParameters: queryParameters,
          header: header,
          baseUrl: baseUrl,
          cancel: cancel,
          withApiAuth: withApiAuth,
          withUserAuth: withUserAuth,
          isRetry: true,
          responseType: responseType,
        );
      }
      return {};
    }
  }

  /// Post请求，返回Map
  /// * [path] 请求链接
  /// * [cancel] 任务取消Token
  /// * [data] 内容
  /// * [header] 请求头
  /// * [withApiAuth] 是否需要API认证
  /// * [withUserAuth] 是否需要用户认证
  /// * [isRetry] 是否重试
  Future<dynamic> post(
    String path, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? header,
    String? baseUrl,
    CancelToken? cancel,
    bool withApiAuth = false,
    bool withUserAuth = false,
    bool isRetry = false,
    bool formUrlEncoded = false,
    ResponseType responseType = ResponseType.json,
  }) async {
    baseUrl ??= Api.kBaseUrl;
    data ??= {};
    try {
      if (withUserAuth && !UserService.instance.logined.value) {
        throw AppError(LocaleKeys.state_not_login, notLogin: true);
      }
      header ??= {};

      var result = await dio.post(
        baseUrl + path,
        data: data,
        options: Options(
          responseType: responseType,
          headers: header,
          extra: {
            "withApiAuth": withApiAuth,
            "withUserAuth": withUserAuth,
          },
          contentType:
              formUrlEncoded ? Headers.formUrlEncodedContentType : null,
        ),
        cancelToken: cancel,
      );
      return result.data;
    } catch (e) {
      var result = await handelError(e, withApiAuth, withUserAuth, isRetry);
      if (result) {
        return await post(
          path,
          data: data,
          formUrlEncoded: formUrlEncoded,
          header: header,
          baseUrl: baseUrl,
          cancel: cancel,
          withApiAuth: withApiAuth,
          withUserAuth: withUserAuth,
          isRetry: true,
          responseType: responseType,
        );
      }
      return {};
    }
  }

  /// DELETE请求，返回Map
  /// * [path] 请求链接
  /// * [cancel] 任务取消Token
  /// * [data] 内容
  /// * [header] 请求头
  /// * [withApiAuth] 是否需要API认证
  /// * [withUserAuth] 是否需要用户认证
  /// * [isRetry] 是否重试
  Future<dynamic> delete(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? data,
    Map<String, dynamic>? header,
    String? baseUrl,
    CancelToken? cancel,
    bool withApiAuth = false,
    bool withUserAuth = false,
    bool isRetry = false,
    bool formUrlEncoded = false,
    ResponseType responseType = ResponseType.json,
  }) async {
    baseUrl ??= Api.kBaseUrl;
    data ??= {};
    queryParameters ??= {};
    try {
      if (withUserAuth && !UserService.instance.logined.value) {
        throw AppError(LocaleKeys.state_not_login, notLogin: true);
      }
      header ??= {};

      var result = await dio.delete(
        baseUrl + path,
        data: data,
        queryParameters: queryParameters,
        options: Options(
          responseType: responseType,
          headers: header,
          extra: {
            "withApiAuth": withApiAuth,
            "withUserAuth": withUserAuth,
          },
          contentType:
              formUrlEncoded ? Headers.formUrlEncodedContentType : null,
        ),
        cancelToken: cancel,
      );
      return result.data;
    } catch (e) {
      var result = await handelError(e, withApiAuth, withUserAuth, isRetry);
      if (result) {
        return await delete(
          path,
          data: data,
          formUrlEncoded: formUrlEncoded,
          header: header,
          baseUrl: baseUrl,
          cancel: cancel,
          withApiAuth: withApiAuth,
          withUserAuth: withUserAuth,
          isRetry: true,
          responseType: responseType,
        );
      }
      return {};
    }
  }

  /// HEAD请求，返回bool
  /// * [path] 请求链接
  /// * [cancel] 任务取消Token
  /// * [queryParameters] 请求参数
  /// * [header] 请求头
  /// * [withApiAuth] 是否需要API认证
  /// * [withUserAuth] 是否需要用户认证
  Future<bool> head(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? header,
    String? baseUrl,
    CancelToken? cancel,
    bool withApiAuth = false,
    bool withUserAuth = false,
  }) async {
    if (withUserAuth && !UserService.instance.logined.value) {
      throw AppError(LocaleKeys.state_not_login, notLogin: true);
    }
    baseUrl ??= Api.kBaseUrl;
    queryParameters ??= {};
    try {
      header ??= {};
      var result = await dio.head(
        baseUrl + path,
        queryParameters: queryParameters,
        options: Options(
          responseType: ResponseType.plain,
          headers: header,
          extra: {
            "withApiAuth": withApiAuth,
            "withUserAuth": withUserAuth,
          },
        ),
        cancelToken: cancel,
      );
      return result.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  /// 错误处理
  /// 可以放到interceptor中
  Future<bool> handelError(
      Object e, bool withApiAuth, bool withUserAuth, bool isRetry) async {
    if (e is DioException) {
      if (e.type == DioExceptionType.badResponse) {
        var msg = '';
        if (e.response?.data is Map) {
          Map? data = e.response?.data;

          msg = data.toString();
        }

        var statusCode = e.response?.statusCode ?? 400;
        if (statusCode == 401 && withUserAuth) {
          //尝试重新登录
          if (await UserService.instance.refreshToken() && !isRetry) {
            return true;
          } else {
            SmartDialog.showToast(LocaleKeys.network_status_401.tr);
            UserService.instance.logout();
            return false;
          }
        }
        if (statusCode == 401 && withApiAuth && !isRetry) {
          //尝试重新获取Token
          if (await ApiService.instance.getToken()) {
            return true;
          }
          return false;
        }
        throw AppError(msg, code: statusCode, isHttpError: true);
      } else {
        throw AppError(LocaleKeys.network_status_no_network.tr);
      }
    } else if (e is AppError) {
      throw e;
    } else {
      throw AppError(LocaleKeys.network_status_connection_fail.tr);
    }
  }
}
