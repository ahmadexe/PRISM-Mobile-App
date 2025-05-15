part of 'bloc.dart';

sealed class ChainEvent extends Equatable {
  const ChainEvent();

  @override
  List<Object> get props => [];
}

final class GetConnectionString extends ChainEvent {}

final class PostData extends ChainEvent {
  final List<String> data;
  final String blockchainAddress;

  const PostData({
    required this.data,
    required this.blockchainAddress,
  });

  @override
  List<Object> get props => [data, blockchainAddress];
}

final class GetData extends ChainEvent {
  final String nodeAddress;

  const GetData({
    required this.nodeAddress,
  });

  @override
  List<Object> get props => [nodeAddress];
}

final class BuyCoins extends ChainEvent {
  final String nodeAddress;
  final String userChainAddress;
  final double amount;

  const BuyCoins({
    required this.nodeAddress,
    required this.amount,
    required this.userChainAddress,
  });

  @override
  List<Object> get props => [nodeAddress, amount, userChainAddress];
}
