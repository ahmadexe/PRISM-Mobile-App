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

      case ClientType.chat:
        final chatOptions =
            _options.copyWith(baseUrl: 'http://3.111.196.231:3002/v1');
        return Dio(chatOptions);
      case ClientType.jobs:
        final jobOptions =
            _options.copyWith(baseUrl: 'http://3.111.196.231:3003/v1');
        return Dio(jobOptions);

      case ClientType.wallet:
        final walletOptions =
            _options.copyWith(baseUrl: 'http://0.0.0.0:11101');
        return Dio(walletOptions);
    }
  }
}

enum ClientType {
  auth,
  post,
  chat,
  jobs,
  wallet,
}
