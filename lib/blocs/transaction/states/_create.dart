part of '../transaction_bloc.dart';

class CreateTransactionState extends Equatable {
  static bool match(TransactionState a, TransactionState b) =>
      a.create != b.create;

  final String? message;

  const CreateTransactionState({
    this.message,
  });

  @override
  List<Object?> get props => [message];
}

class CreateTransactionDefault extends CreateTransactionState {
  const CreateTransactionDefault();
}

class CreateTransactionLoading extends CreateTransactionState {
  const CreateTransactionLoading();
}

class CreateTransactionSuccess extends CreateTransactionState {
  const CreateTransactionSuccess();
}

class CreateTransactionFailure extends CreateTransactionState {
  const CreateTransactionFailure({
    required String message,
  }) : super(message: message);
}
