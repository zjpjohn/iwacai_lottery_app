import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter/foundation.dart';
import 'package:get/get.dart' hide FormData, Response;
import 'package:iwacai_lottery_app/env/env_profile.dart';
import 'package:iwacai_lottery_app/env/log_profile.dart';
import 'package:iwacai_lottery_app/store/store.dart';

class HttpRequest {
  ///aes加密header key
  ///
  static const aesHeader = 'cloud-sid-ivr';

  ///auth授权登录header
  ///
  static const authHeader = 'authentication';

  ///dio实例
  late Dio _dio;

  ///初始化请求
  static final HttpRequest _instance = HttpRequest._internal();

  factory HttpRequest() => _instance;

  HttpRequest._internal() {
    BaseOptions options = BaseOptions(
      ///请求base url
      baseUrl: Profile.props.baseUri,

      ///连接超时时间
      connectTimeout: const Duration(seconds: 25),

      ///响应超时时间
      receiveTimeout: const Duration(seconds: 15),

      ///响应数据格式
      responseType: ResponseType.json,
    );
    _dio = Dio(options);
    _dio.interceptors.add(
      InterceptorsWrapper(onRequest: (options, handler) {
        ///
        /// 将授权token放入header中
        String token = UserStore().authToken;
        if (token.isNotEmpty) {
          options.headers[authHeader] = token;
        }

        ///请求request拦截处理
        return handler.next(options);
      }, onResponse: (response, handler) {
        ///
        Map<String, dynamic> data = response.data;

        ///业务异常处理
        if (data['code'] != 200) {
          return handler.reject(DioException(
            requestOptions: response.requestOptions,
            error: ResponseError(
              path: response.requestOptions.path,
              code: data['code'],
              message: data['error'] ?? '',
            ),
          ));
        }

        ///响应response结果拦截处理
        responseHandle(response);

        return handler.next(response);
      }, onError: (error, handler) {
        ///错误处理
        onError(error, handler);
      }),
    );
  }

  ///请求处理
  ///
  void requestHandle(RequestOptions options) {
    String token = UserStore().authToken;
    if (token.isNotEmpty) {
      Map<String, dynamic> headers = {};
      headers[authHeader] = token;
      options.headers = headers;
    }
  }

  ///响应处理
  ///
  void responseHandle(Response response) {
    String? encoder = response.headers.value(aesHeader);
    if (encoder != null) {
      Uint8List data = encrypt.Encrypted.fromBase64(encoder).bytes;
      Uint8List keyBytes = data.sublist(0, 24),
          ivrBytes = data.sublist(24, data.length);
      String content = String.fromCharCodes(encrypt
          .AES(
            encrypt.Key(keyBytes),
            mode: encrypt.AESMode.cbc,
          )
          .decrypt(
            encrypt.Encrypted.fromBase64(response.data['data']),
            iv: encrypt.IV(ivrBytes),
          ));
      response.data['data'] = json.decode(content);
    }
  }

  ResponseError createError(DioException error) {
    switch (error.type) {
      case DioExceptionType.cancel:

        ///
        ///请求取消
        return ResponseError(
          path: error.requestOptions.path,
          code: -1,
          message: '请求取消',
        );
      case DioExceptionType.connectionTimeout:

        ///
        ///连接超时
        return ResponseError(
          path: error.requestOptions.path,
          code: -1,
          message: '连接超时',
        );
      case DioExceptionType.receiveTimeout:

        ///
        ///响应超时
        return ResponseError(
          path: error.requestOptions.path,
          code: -1,
          message: '响应超时',
        );
      case DioExceptionType.sendTimeout:

        ///
        ///请求超时
        return ResponseError(
          path: error.requestOptions.path,
          code: -1,
          message: '请求超时',
        );
      case DioExceptionType.connectionError || DioExceptionType.badCertificate:

        ///
        /// 连接错误
        return ResponseError(
          path: 'error.requestOptions.path',
          code: -1,
          message: '连接错误',
        );
      case DioExceptionType.badResponse:

        ///
        ///响应错误消息
        return ResponseError.fromResp(
          response: error.response!,
          path: error.requestOptions.path,
        );
      case DioExceptionType.unknown:

        ///
        ///网络错误
        if (error.error is SocketException) {
          return ResponseError(
            path: error.requestOptions.path,
            code: -1,
            message: '请求不存在',
          );
        }

        ///
        /// 后端业务错误
        if (error.error is ResponseError) {
          return error.error as ResponseError;
        }

        ///
        ///默认处理
        return ResponseError(
          path: error.requestOptions.path,
          code: -1,
          message: '请求错误',
        );
    }
  }

  /// 错误异常处理
  ///
  void onError(DioException error, ErrorInterceptorHandler handle) {
    ///
    ///错误拦截处理
    ResponseError responseError = createError(error);
    logger.e('response error', error: responseError);

    ///
    ///接口鉴权失败
    if (responseError.code == 401) {
      ///
      ///退出登录
      UserStore().removeLocalAuth();
    }

    ///
    /// 抛出异常
    handle.next(
      DioException(
        requestOptions: error.requestOptions,
        error: responseError,
      ),
    );
  }

  ///
  ///GET 请求
  Future<ResponseEntity> get(
    String path, {
    Map<String, dynamic>? params,
    Options? options,
  }) {
    return _dio
        .get(path, queryParameters: params, options: options ?? Options())
        .then((value) => ResponseEntity.from(value.data));
  }

  ///
  ///POST FORM 请求
  Future<ResponseEntity> post(
    String path, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? params,
    Options? options,
  }) {
    return _dio
        .post(path,
            data: data,
            queryParameters: params,
            options: (options ?? Options())
              ..contentType = Headers.formUrlEncodedContentType)
        .then((value) => ResponseEntity.from(value.data));
  }

  ///
  ///POST JSON 请求
  Future<ResponseEntity> postJson(
    String path, {
    dynamic data,
    Map<String, dynamic>? params,
    Options? options,
  }) {
    return _dio
        .post(path,
            data: data,
            queryParameters: params,
            options: (options ?? Options())
              ..contentType = Headers.jsonContentType)
        .then((value) => ResponseEntity.from(value.data));
  }

  ///
  ///PUT 请求
  Future<ResponseEntity> put(
    String path, {
    Map<String, dynamic>? params,
    dynamic data,
    Options? options,
  }) {
    return _dio
        .put(path,
            data: data,
            queryParameters: params,
            options: (options ?? Options())
              ..contentType = Headers.formUrlEncodedContentType)
        .then((value) => ResponseEntity.from(value.data));
  }

  ///
  ///DELETE 请求
  Future<ResponseEntity> delete(
    String path, {
    Map<String, dynamic>? params,
    Options? options,
  }) {
    return _dio
        .delete(path,
            queryParameters: params,
            options: (options ?? Options())
              ..contentType = Headers.formUrlEncodedContentType)
        .then((value) => ResponseEntity.from(value.data));
  }
}

///
/// 统一响应结果
class ResponseEntity {
  ///
  /// 错误提醒内容
  String? error;

  ///
  /// 成功消息
  String? message;

  ///
  /// 响应码
  late int code;

  ///
  /// 响应数据
  dynamic data;

  ///
  /// 响应时间
  late String timestamp;

  ResponseEntity(
    this.error,
    this.message,
    this.code,
    this.data,
    this.timestamp,
  );

  ResponseEntity.from(Map<String, dynamic> json) {
    error = json['error'];
    message = json['message'];
    code = json['code'];
    data = json['data'];
    timestamp = json['timestamp'];
  }
}

class ResponseError implements Exception {
  ///
  /// 请求uri
  String path;

  ///
  /// 异常码
  int code = -1;

  ///
  /// 异常内容
  String message = '系统响应错误';

  ResponseError.fromResp({required Response response, required this.path}) {
    if (response.statusCode == 404 ||
        response.statusCode == 503 ||
        response.statusCode == 502) {
      code = -1;
      message = '服务暂时不可用';
      return;
    }
    if (response.statusCode == 401) {
      message = "登录后可访问";
    }
    if (response.statusCode == 403) {
      message = "暂无权限访问";
    }

    Headers headers = response.headers;
    if (Headers.jsonContentType.isCaseInsensitiveContains(
        headers.value(Headers.contentTypeHeader) ?? '')) {
      code = response.statusCode ?? -1;
      message = response.data['error'] ?? '系统响应错误';
      return;
    }
  }

  ResponseError({
    required this.path,
    required this.code,
    required this.message,
  });

  @override
  String toString() {
    if (message == '') {
      return 'request:[$path],response error: code [$code]';
    }
    return 'request:[$path],response error: code [$code], message [$message]';
  }
}
