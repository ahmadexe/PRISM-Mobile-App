part of 'transaction_bloc.dart';

class _TransactionProvider {
  static Future<void> createTransaction(
      Map<String, dynamic> payload, String address) async {
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

  static Future<List<PublicTransaction>> getTransactions(String address) async {
    try {
      final client = Dio(BaseOptions(
        contentType: "application/json",
        connectTimeout: const Duration(milliseconds: 60000),
        receiveTimeout: const Duration(milliseconds: 60000),
      ));

      final response = await client.get(
        'http://0.0.0.0:10111/all_transactions',
      );

      final data = response.data as Map<String, dynamic>;

      final transactionsRaw = data['transactions'] as List<dynamic>;

      final transactions = transactionsRaw
          .map((e) => PublicTransaction.fromMap(e as Map<String, dynamic>))
          .toList();
      return transactions;
    } catch (e) {
      debugPrint('----- ERROR in Get Transactions Provider -----');
      debugPrint(e.toString());
      throw Exception('Failed to get transactions');
    }
  }
}
