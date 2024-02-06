import 'package:dio/dio.dart';

class Api {
  static final BaseOptions _options = BaseOptions(
    contentType: "application/json",
    connectTimeout: const Duration(milliseconds: 60000),
    receiveTimeout: const Duration(milliseconds: 60000),
  );

  static final Dio _dio = Dio(_options);
  static get client => _dio;
}
