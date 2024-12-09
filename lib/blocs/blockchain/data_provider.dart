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

  static Future<List<DataModel>> getData(String address) async {
    try {
      final client = Dio(BaseOptions(
        contentType: "application/json",
        connectTimeout: const Duration(milliseconds: 60000),
        receiveTimeout: const Duration(milliseconds: 60000),
      ));

      final response = await client.get(
        'http://$address:10111/data',
      );

      final dataRaw = response.data as Map<String, dynamic>;

      final dataSeg = dataRaw['data'] as List<dynamic>?;
      if (dataSeg == null) {
        return [];
      }
      final data = dataSeg
          .map((e) => DataModel.fromMap(e as Map<String, dynamic>))
          .toList();

      return data;
    } catch (e) {
      debugPrint('----- ERROR in Get Data Provider -----');
      debugPrint(e.toString());
      throw Exception('Failed to get data');
    }
  }

  static Future<void> buyCoins(String nodeAddress, String userAddress, double amount) async {
    try {
      final client = Dio(BaseOptions(
        contentType: "application/json",
        connectTimeout: const Duration(milliseconds: 60000),
        receiveTimeout: const Duration(milliseconds: 60000),
      ));

      final response = await client.post(
        'http://$nodeAddress:10111/buy',
        data: json.encode({
          'requestAddress': userAddress,
          'amount': amount,
        }),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to buy coins');
      }
    } catch (e) {
      debugPrint('----- ERROR in Buy Coins Provider -----');
      debugPrint(e.toString());
      throw Exception('Failed to buy coins');
    }
  }
}
