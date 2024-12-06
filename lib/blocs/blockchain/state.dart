part of 'bloc.dart';

class ChainState extends Equatable {
  final String? address;
  final NodeState node;
  final PostDataState data;

  const ChainState({
    this.address,
    required this.node,
    required this.data,
  });

  @override
  List<Object?> get props => [
        address,
        node,
        data,
      ];

  ChainState copyWith({
    String? address,
    NodeState? node,
    PostDataState? data,
  }) {
    return ChainState(
      address: address ?? this.address,
      node: node ?? this.node,
      data: data ?? this.data,
    );
  }
}

class ChainInitial extends ChainState {
  const ChainInitial()
      : super(
          node: const NodeDefault(),
          data: const PostDataDefault(),
        );
}
