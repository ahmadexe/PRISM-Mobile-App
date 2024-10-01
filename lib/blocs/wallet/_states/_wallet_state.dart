part of '../wallet_bloc.dart';

@immutable
abstract class WalletInfoState {
  final String? message;

  const WalletInfoState({
    this.message,
  });
}

class WalletInfoDefault extends WalletInfoState {
  const WalletInfoDefault() : super();
}

class WalletInfoLoading extends WalletInfoState {}

class WalletInfoLoaded extends WalletInfoState {
  const WalletInfoLoaded() : super();
}

class WalletInfoError extends WalletInfoState {
  const WalletInfoError({
    required String message,
  }) : super(message: message);
}
