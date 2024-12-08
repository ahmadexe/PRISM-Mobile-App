part of 'wallet_bloc.dart';

@immutable
abstract class WalletEvent {
  const WalletEvent();
}

class GetWalletDetails extends WalletEvent {
  final String nodeAddress;
  final String? publicKey;
  final String? privateKey;
  const GetWalletDetails({
    required this.nodeAddress,
    this.privateKey,
    this.publicKey,
  }) : super();
}

class GetWalletAmount extends WalletEvent {
  final String nodeAddress;
  const GetWalletAmount({required this.nodeAddress}) : super();
}
