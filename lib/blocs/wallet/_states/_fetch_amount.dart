part of '../wallet_bloc.dart';

@immutable
abstract class WalletAmountState {
  final String? message;

  const WalletAmountState({
    this.message,
  });
}

class WalletAmountDefault extends WalletAmountState {
  const WalletAmountDefault() : super();
}

class WalletAmountLoading extends WalletAmountState {
  const WalletAmountLoading() : super();
}

class WalletAmountLoaded extends WalletAmountState {
  const WalletAmountLoaded() : super();
}

class WalletAmountError extends WalletAmountState {
  const WalletAmountError({
    required String message,
  }) : super(message: message);
}