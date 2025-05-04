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
            _options.copyWith(baseUrl: 'http://13.60.4.99:3000/v1');
        return Dio(authOptions);

      case ClientType.post:
        final postOptions =
            _options.copyWith(baseUrl: 'http://13.60.4.99:3001/v1');
        return Dio(postOptions);

      case ClientType.chat:
        final chatOptions =
            _options.copyWith(baseUrl: 'http://13.60.4.99:3002/v1');
        return Dio(chatOptions);
      case ClientType.jobs:
        final jobOptions =
            _options.copyWith(baseUrl: 'http://13.60.4.99:3003/v1');
        return Dio(jobOptions);
      case ClientType.relay:
        final relayOptions =
            _options.copyWith(baseUrl: 'http://13.60.4.99:10011/api/v1');
        return Dio(relayOptions);
    }
  }
}

enum ClientType {
  auth,
  post,
  chat,
  jobs,
  relay,
}
