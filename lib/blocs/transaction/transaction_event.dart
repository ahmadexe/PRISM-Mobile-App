part of 'transaction_bloc.dart';

@immutable
abstract class TransactionEvent {
  const TransactionEvent();
}

class CreateTransaction extends TransactionEvent {
  final Transaction transaction;
  final String nodeAddress;

  const CreateTransaction({
    required this.transaction,
    required this.nodeAddress,
  });
}
