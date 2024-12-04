part of 'transaction_bloc.dart';

class _TransactionProvider {
  static Future<void> createTransaction(Map<String, dynamic> payload, String address) async {
    try {

      final client = Dio(BaseOptions(
        contentType: "application/json",
        connectTimeout: const Duration(milliseconds: 60000),
        receiveTimeout: const Duration(milliseconds: 60000),
      ));


      await client.post(
        'http://$address:11101/transaction',
        data: json.encode(payload),
      );
    } catch (e) {
      debugPrint('----- ERROR in Create Transaction Provider -----');
      debugPrint(e.toString());
      throw Exception('Failed to create transaction');
    }
  }
}
