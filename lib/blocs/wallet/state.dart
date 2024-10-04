part of 'wallet_bloc.dart';

class WalletState extends Equatable {
  final Wallet? wallet;
  final WalletInfoState walletInfo;
  final WalletAmountState amount;

  const WalletState({
    this.wallet,
    required this.walletInfo,
    required this.amount,
  });

  WalletState copyWith({
    Wallet? wallet,
    WalletInfoState? walletInfo,
    WalletAmountState? amount,
  }) {
    return WalletState(
      wallet: wallet ?? this.wallet,
      walletInfo: walletInfo ?? this.walletInfo,
      amount: amount ?? this.amount,
    );
  }

  @override
  List<Object?> get props => [wallet, walletInfo, amount];
}

class WalletDefault extends WalletState {
  const WalletDefault()
      : super(
          walletInfo: const WalletInfoDefault(),
          amount: const WalletAmountDefault(),
        );
}
