import 'package:dio/dio.dart';

class Api {
  static final BaseOptions _options = BaseOptions(
    contentType: "application/json",
    connectTimeout: const Duration(milliseconds: 60000),
    receiveTimeout: const Duration(milliseconds: 60000),
  );

  static Dio getClient(ClientType type) {
    switch (type) {
      case ClientType.auth:
        final authOptions =
            _options.copyWith(baseUrl: 'http://3.111.196.231:3000/v1');
        return Dio(authOptions);
      case ClientType.post:
        final postOptions =
            _options.copyWith(baseUrl: 'http://3.111.196.231:3001/v1');
        return Dio(postOptions);
    }
  }
}

enum ClientType {
  auth,
  post,
}
