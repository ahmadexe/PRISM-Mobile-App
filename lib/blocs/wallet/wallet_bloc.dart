import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prism/models/payment/wallet.dart';

part 'wallet_event.dart';
part '_states/_wallet_state.dart';

part 'state.dart';
part 'data_provider.dart';

class WalletBloc extends Bloc<WalletEvent, WalletState> {
  static WalletBloc get(context, [listen = true]) =>
      BlocProvider.of(context, listen: listen);

  WalletBloc() : super(const WalletDefault()) {
    on<GetWalletDetails>(_getWalletDetails);
  }

  Future<void> _getWalletDetails(
      GetWalletDetails event, Emitter<WalletState> emit) async {
    emit(
      state.copyWith(
        walletInfo: WalletInfoLoading(),
      ),
    );

    try {
      final wallet = await _WallterProvider.getWalletDetails();

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
}
