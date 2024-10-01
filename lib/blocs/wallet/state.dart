part of 'wallet_bloc.dart';

class WalletState extends Equatable {
  final Wallet? wallet;
  final WalletInfoState walletInfo;

  const WalletState({
    this.wallet,
    required this.walletInfo,
  });

  WalletState copyWith({
    Wallet? wallet,
    WalletInfoState? walletInfo,
  }) {
    return WalletState(
      wallet: wallet ?? this.wallet,
      walletInfo: walletInfo ?? this.walletInfo,
    );
  }

  @override
  List<Object?> get props => [wallet, walletInfo];
}

class WalletDefault extends WalletState {
  const WalletDefault()
      : super(
          walletInfo: const WalletInfoDefault(),
        );
}
