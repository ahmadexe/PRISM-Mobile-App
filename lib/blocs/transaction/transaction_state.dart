part of 'transaction_bloc.dart';

@immutable
abstract class TransactionState {
  final String? message;

  const TransactionState({
    this.message,
  });
}

class TransactionInitial extends TransactionState {}

class TransactionLoading extends TransactionState {}

class TransactionLoaded extends TransactionState {}

class TransactionError extends TransactionState {
  const TransactionError({
    required String message,
  }) : super(message: message);
}
