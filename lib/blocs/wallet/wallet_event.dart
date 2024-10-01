part of 'wallet_bloc.dart';

@immutable
abstract class WalletEvent {
  const WalletEvent();
}

class GetWalletDetails extends WalletEvent {
  const GetWalletDetails() : super();
}
