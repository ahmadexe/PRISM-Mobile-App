part of 'transaction_bloc.dart';

@immutable
abstract class TransactionEvent {
  const TransactionEvent();
}

class CreateTransaction extends TransactionEvent {
  final Transaction transaction;

  const CreateTransaction({
    required this.transaction,
  });
}
