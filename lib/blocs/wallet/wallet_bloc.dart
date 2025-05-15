import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prism/models/payment/wallet.dart';

part 'wallet_event.dart';
part '_states/_wallet_state.dart';
part '_states/_fetch_amount.dart';

part 'state.dart';
part 'data_provider.dart';

class WalletBloc extends Bloc<WalletEvent, WalletState> {
  static WalletBloc get(context, [listen = true]) =>
      BlocProvider.of(context, listen: listen);

  WalletBloc() : super(const WalletDefault()) {
    on<GetWalletDetails>(_getWalletDetails);
    on<GetWalletAmount>(_getAmount);
  }

  Future<void> _getWalletDetails(
      GetWalletDetails event, Emitter<WalletState> emit) async {
    emit(
      state.copyWith(
        walletInfo: WalletInfoLoading(),
      ),
    );

    try {
      final wallet = await _WallterProvider.getWalletDetails(
          event.nodeAddress, event.publicKey, event.privateKey, event.address);

      emit(
        state.copyWith(
          wallet: wallet,
          walletInfo: const WalletInfoLoaded(),
        ),
      );
    } catch (e) {
      debugPrint('----- ERROR in Wallet Details Provider -----');
      debugPrint(e.toString());
      emit(
        state.copyWith(
          walletInfo: WalletInfoError(
            message: e.toString(),
          ),
        ),
      );
    }
  }

  Future<void> _getAmount(
      GetWalletAmount event, Emitter<WalletState> emit) async {
    emit(
      state.copyWith(
        amount: const WalletAmountLoading(),
      ),
    );

    try {
      final wallet = state.wallet!;
      final chainAddress = wallet.blockchainAddress;
      final amount =
          await _WallterProvider.getAmount(chainAddress, event.nodeAddress);

      wallet.amount = amount;

      emit(
        state.copyWith(
          wallet: wallet,
          amount: const WalletAmountLoaded(),
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          amount: WalletAmountError(
            message: e.toString(),
          ),
        ),
      );
    }
  }
}
