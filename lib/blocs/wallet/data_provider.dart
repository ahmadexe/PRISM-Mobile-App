part of 'wallet_bloc.dart';

class _WallterProvider {
  static final _handler = Dio();

  static Future<Wallet> getWalletDetails() async {
    try {
      final response = await _handler.post(
        'http://0.0.0.0:5050/wallet',
      );

      final wallet = Wallet.fromMap(response.data as Map<String, dynamic>);

      return wallet;
    } catch (e) {
      debugPrint('----- ERROR in Wallet Details Provider -----');
      debugPrint(e.toString());
      throw Exception('Failed to get wallet details');
    }
  }

  static Future<double> getAmount(String chainAddress) async {
    try {
      const String endPoint = 'http://0.0.0.0:5050/wallet/amount';

      final response = await _handler.get(endPoint, queryParameters: {
        'blockchain_address': chainAddress,
      });

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
