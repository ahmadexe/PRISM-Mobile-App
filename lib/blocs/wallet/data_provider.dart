part of 'wallet_bloc.dart';

class _WallterProvider {
  static Future<Wallet> getWalletDetails(String address,
      [String? publicKey, String? privateKey]) async {
    try {
      final client = Dio(BaseOptions(
        contentType: "application/json",
        connectTimeout: const Duration(milliseconds: 60000),
        receiveTimeout: const Duration(milliseconds: 60000),
      ));

      final Response<dynamic> response;
      print('publicKey: $publicKey');
      print('privateKey: $privateKey');
      if (publicKey != null && privateKey != null) {
        final url = 'http://$address:11101/generate/wallet';
        response = await client.get(
          url,
          data: json.encode({
            'publicKey': publicKey,
            'privateKey': privateKey,
          }),
        );
      } else {
        final url = 'http://$address:11101/wallet';
        response = await client.post(
          url,
        );
      }

      Map<String, dynamic> data = response.data as Map<String, dynamic>;

      final myAddress = data['blockchainAddress'] as String;
      if (publicKey == null && privateKey == null) {
        await client.post(
          "http://$address:10111/join/?address=$myAddress",
        );
      }

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

  static Future<double> getAmount(
      String chainAddress, String nodeAddress) async {
    try {
      String endPoint =
          'http://$nodeAddress:11101//wallet/amount?blockchain_address=$chainAddress';

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
