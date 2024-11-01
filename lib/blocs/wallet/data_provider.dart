part of 'wallet_bloc.dart';

class _WallterProvider {
  static final _handler = Api.getClient(ClientType.wallet);

  static Future<Wallet> getWalletDetails() async {
    try {
      final response = await _handler.post(
        '/wallet',
      );
      
      Map<String, dynamic> data = response.data as Map<String, dynamic>;

      final amount = await getAmount(data['blockchainAddress']);

      data['amount'] = amount;

      final wallet = Wallet.fromMap(data);

      return wallet;
    } catch (e) {
      debugPrint('----- ERROR in Wallet Details Provider -----');
      debugPrint(e.toString());
      throw Exception('Failed to get wallet details');
    }
  }

  static Future<double> getAmount(String chainAddress) async {
    try {
       String endPoint = '/wallet/amount?blockchain_address=$chainAddress';

      

      final response = await _handler.get(endPoint);

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
