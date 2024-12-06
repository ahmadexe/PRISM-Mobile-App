part of 'bloc.dart';

class _ChainProvider {
  // static final _handler = Api.getClient(ClientType.relay);

  static Future<String> getConnectionString() async {
    try {
      // final response = await _handler.get('/rand/node');
      // return response.data;

      return "0.0.0.0";
    } catch (e) {
      debugPrint('----- ERROR in Get Connection String Provider -----');
      debugPrint(e.toString());
      throw Exception('Failed to get connection string');
    }
  }

  static Future<void> postData(
      Map<String, dynamic> payload, String nodeAddress) async {
    try {
      final client = Dio(BaseOptions(
        contentType: "application/json",
        connectTimeout: const Duration(milliseconds: 60000),
        receiveTimeout: const Duration(milliseconds: 60000),
      ));

      final response = await client.post(
        'http://$nodeAddress:10111/data',
        data: json.encode(payload),
      );

      if (response.statusCode != 201) {
        throw Exception('Failed to post data');
      }

    } catch (e) {
      debugPrint('----- ERROR in Post Data Provider -----');
      debugPrint(e.toString());
      throw Exception('Failed to post data');
    }
  }
}
