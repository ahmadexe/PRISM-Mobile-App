part of 'wallet_bloc.dart';

@immutable
abstract class WalletEvent {
  const WalletEvent();
}

class GetWalletDetails extends WalletEvent {
  final String nodeAddress;
  const GetWalletDetails({required this.nodeAddress}) : super();
}

class GetWalletAmount extends WalletEvent {
  final String nodeAddress;
  const GetWalletAmount({required this.nodeAddress}) : super();
}
