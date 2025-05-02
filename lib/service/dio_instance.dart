import 'package:dio/dio.dart';
import 'package:flutter_hung_chatbot/flavors.dart';

class DioInstance {
  static final DioInstance _instance = DioInstance._internal();
  late Dio _dio;

  DioInstance._internal() {
    _dio = Dio(
      BaseOptions(
        baseUrl: '${F.getGoogleApi}/v1beta/models/',
        headers: {'Content-Type': 'application/json'},
        connectTimeout: const Duration(minutes: 1),
        receiveTimeout: const Duration(minutes: 1),
      ),
    );
  }

  factory DioInstance() => _instance;

  Dio get dio => _dio;
}
