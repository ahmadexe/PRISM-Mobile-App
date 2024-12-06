part of 'transaction_bloc.dart';

@immutable
class TransactionState {
  final List<PublicTransaction>? transactions;
  final CreateTransactionState create;
  final GetTransactionsState getTransactions;

  const TransactionState({
    this.transactions,
    required this.create,
    required this.getTransactions,
  });

  TransactionState copyWith({
    List<PublicTransaction>? transactions,
    CreateTransactionState? create,
    GetTransactionsState? getTransactions,
  }) {
    return TransactionState(
      transactions: transactions ?? this.transactions,
      create: create ?? this.create,
      getTransactions: getTransactions ?? this.getTransactions,
    );
  }

  List<Object?> get props => [
        transactions,
        create,
        getTransactions,
      ];
}

class TransactionInitial extends TransactionState {
  const TransactionInitial()
      : super(
          create: const CreateTransactionDefault(),
          getTransactions: const GetTransactionsDefault(),
        );
}
