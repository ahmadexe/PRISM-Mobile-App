part of 'transaction_bloc.dart';

class _TransactionProvider {
  static final _handler = Api.getClient(ClientType.wallet);
  static Future<void> createTransaction(Map<String, dynamic> payload) async {
    try {
      await _handler.post(
        '/transaction',
        data: json.encode(payload),
      );
    } catch (e) {
      debugPrint('----- ERROR in Create Transaction Provider -----');
      debugPrint(e.toString());
      throw Exception('Failed to create transaction');
    }
  }
}
