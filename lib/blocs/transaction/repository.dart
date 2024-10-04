part of 'transaction_bloc.dart';

class _TransactionRepo {
  Future<void> createTransaction(Transaction transaction) async {
    try {
      _TransactionProvider.createTransaction(transaction.toMap());
    } catch (e) {
      rethrow;
    }
  }
}