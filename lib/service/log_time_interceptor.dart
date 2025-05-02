// interceptor to log time taken by each request

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class LogTimeInterceptor implements Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    debugPrint('Error: ${err.message}');
    handler.next(err);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.extra['start'] = DateTime.now().millisecondsSinceEpoch;
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    final start = response.requestOptions.extra['start'];
    String nameTR = '';

    final end = DateTime.now().millisecondsSinceEpoch;
    final time = end - start;
    debugPrint('${response.requestOptions.uri.toString()} $nameTR');
    debugPrint('Time taken: $time ms');
    handler.next(response);
  }
}
