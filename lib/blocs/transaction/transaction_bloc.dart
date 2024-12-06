import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prism/models/payment/transaction.dart';
import 'package:prism/models/transactions/public_transaction.dart';

part 'transaction_event.dart';
part 'transaction_state.dart';

part 'data_provider.dart';
part 'repository.dart';

part 'states/_create.dart';
part 'states/_get_transactions.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  static TransactionBloc get(context, [listen = true]) =>
      BlocProvider.of(context, listen: listen);
  TransactionBloc() : super(const TransactionInitial()) {
    on<CreateTransaction>(_createTransaction);
    on<GetTransactions>(_getTransactions);
  }

  Future<void> _createTransaction(
      CreateTransaction event, Emitter<TransactionState> emit) async {
    emit(
      state.copyWith(
        create: const CreateTransactionLoading(),
      ),
    );

    try {
      await _TransactionRepo()
          .createTransaction(event.transaction, event.nodeAddress);
      emit(
        state.copyWith(
          create: const CreateTransactionSuccess(),
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          create: CreateTransactionFailure(message: e.toString()),
        ),
      );
    }
  }

  Future<void> _getTransactions(
      GetTransactions event, Emitter<TransactionState> emit) async {
    emit(
      state.copyWith(
        getTransactions: const GetTransactionsLoading(),
      ),
    );

    try {
      final transactions =
          await _TransactionProvider.getTransactions(event.nodeAddress);
      emit(
        state.copyWith(
          getTransactions: const GetTransactionsSuccess(),
          transactions: transactions,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          getTransactions: GetTransactionsFailure(message: e.toString()),
        ),
      );
    }
  }
}
