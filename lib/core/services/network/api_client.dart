import 'package:ash_cart/core/resources/app_constant.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class ApiClient {
  final Dio _dio;
  final Interceptor _prettyDioLogger;

  ApiClient(this._dio, this._prettyDioLogger) {
    final BaseOptions baseOptions = BaseOptions(
      baseUrl: AppConstant.baseURL,
      receiveDataWhenStatusError: true,
      connectTimeout: const Duration(minutes: 3),
      receiveTimeout: const Duration(minutes: 3),
      sendTimeout: const Duration(minutes: 3),
      headers: {
        AppConstant.contentType: AppConstant.applicationJson,
        AppConstant.accept: AppConstant.applicationJson,
      },
    );

    _dio.options = baseOptions;
    if (kDebugMode) _dio.interceptors.add(_prettyDioLogger);
  }

  Future<Response> get({required String url, Map<String, dynamic>? queryParameters}) async => await _dio.get(url, queryParameters: queryParameters);
  
  Future<Response> post({required String url, var requestBody, Map<String, dynamic>? queryParameters, ProgressCallback? onSendProgress}) async => await _dio.post(url, queryParameters: queryParameters, data: requestBody, onSendProgress: onSendProgress);
}
