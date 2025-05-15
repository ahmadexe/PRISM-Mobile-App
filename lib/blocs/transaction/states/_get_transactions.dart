part of '../transaction_bloc.dart';

class GetTransactionsState extends Equatable {
  static bool match(TransactionState a, TransactionState b) =>
      a.getTransactions != b.getTransactions;

  final String? message;

  const GetTransactionsState({
    this.message,
  });

  @override
  List<Object?> get props => [message];
}

class GetTransactionsDefault extends GetTransactionsState {
  const GetTransactionsDefault();
}

class GetTransactionsLoading extends GetTransactionsState {
  const GetTransactionsLoading();
}

class GetTransactionsSuccess extends GetTransactionsState {
  const GetTransactionsSuccess();
}

class GetTransactionsFailure extends GetTransactionsState {
  const GetTransactionsFailure({
    required String message,
  }) : super(message: message);
}
