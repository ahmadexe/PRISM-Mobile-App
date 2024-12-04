part of 'transaction_bloc.dart';

class _TransactionRepo {
  Future<void> createTransaction(Transaction transaction, String nodeAddress) async {
    try {
      _TransactionProvider.createTransaction(transaction.toMap(), nodeAddress);
    } catch (e) {
      rethrow;
    }
  }
}