part of 'bloc.dart';

class _NodeProvider {
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
}
