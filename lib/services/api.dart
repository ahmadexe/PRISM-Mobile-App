import 'package:dio/dio.dart';

class Api {
  static final BaseOptions _options = BaseOptions(
    contentType: "application/json",
    connectTimeout: const Duration(milliseconds: 60000),
    receiveTimeout: const Duration(milliseconds: 60000),
  );

  static Dio getClient(String baseUrl) {
    return Dio(_options..baseUrl = baseUrl);
  }
}
