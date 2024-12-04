part of 'wallet_bloc.dart';

class _WallterProvider {
  static Future<Wallet> getWalletDetails(String address) async {
    try {
      final client = Dio(BaseOptions(
        contentType: "application/json",
        connectTimeout: const Duration(milliseconds: 60000),
        receiveTimeout: const Duration(milliseconds: 60000),
      ));

      final response = await client.post(
        'http://$address:11101/wallet',
      );

      Map<String, dynamic> data = response.data as Map<String, dynamic>;

      final myAddress = data['blockchainAddress'] as String;

      final res = await client.post(
        "http://$address:10111/join/?address=$myAddress",
      );

      print(res.data);

      final amount = await getAmount(myAddress, address);

      data['amount'] = amount;

      final wallet = Wallet.fromMap(data);

      return wallet;
    } catch (e) {
      debugPrint('----- ERROR in Wallet Details Provider -----');
      debugPrint(e.toString());
      throw Exception('Failed to get wallet details');
    }
  }

  static Future<double> getAmount(String chainAddress, String nodeAddress) async {
    try {
      String endPoint = 'http://$nodeAddress:11101//wallet/amount?blockchain_address=$chainAddress';

      final client = Dio(BaseOptions(
        contentType: "application/json",
        connectTimeout: const Duration(milliseconds: 60000),
        receiveTimeout: const Duration(milliseconds: 60000),
      ));

      final response = await client.get(endPoint);

      final raw = response.data as Map<String, dynamic>;
      final amount = raw['amount'].toDouble();
      return amount;
    } catch (e) {
      debugPrint('----- ERROR in Wallet Amount Provider -----');
      debugPrint(e.toString());
      throw Exception('Failed to get wallet amount');
    }
  }
}
