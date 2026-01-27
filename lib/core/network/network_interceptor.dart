import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class NetworkInterceptor extends Interceptor {
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    debugPrint('### REQUEST: ${options.method} ${options.uri}');
    debugPrint('Headers: ${options.headers}');
    debugPrint('Body: ${options.data}');

    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    debugPrint('### RESPONSE: ${response.requestOptions.uri}');
    debugPrint('Status: ${response.statusCode}');
    debugPrint('Data: ${response.data}');

    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    debugPrint('XXX ERROR: ${err.requestOptions.uri}');
    debugPrint('Type: ${err.type}');
    debugPrint('Message: ${err.message}');
    super.onError(err, handler);
  }
}
