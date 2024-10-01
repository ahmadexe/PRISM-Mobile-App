part of 'transaction_bloc.dart';

class _TransactionProvider {
  static final _handler = Dio(
    BaseOptions(
      headers: {
        'Content-Type': 'application/json',
      },
      responseType: ResponseType.plain,
    ),
  );
  static Future<void> createTransaction(Map<String, dynamic> payload) async {
    try {
      await _handler.post(
        'http://0.0.0.0:5050/transaction',
        data: json.encode(payload),
      );
    } catch (e) {
      debugPrint('----- ERROR in Create Transaction Provider -----');
      debugPrint(e.toString());
      throw Exception('Failed to create transaction');
    }
  }
}
