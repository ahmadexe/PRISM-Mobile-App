part of 'wallet_bloc.dart';

@immutable
abstract class WalletEvent {
  const WalletEvent();
}

class GetWalletDetails extends WalletEvent {
  const GetWalletDetails() : super();
}

class GetWalletAmount extends WalletEvent {
  const GetWalletAmount() : super();
}