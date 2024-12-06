part of 'bloc.dart';

class ChainState extends Equatable {
  final String? address;
  final List<DataModel>? analyticalData;
  final NodeState node;
  final PostDataState data;
  final GetDataState getData;

  const ChainState({
    this.address,
    this.analyticalData,
    required this.node,
    required this.data,
    required this.getData,
  });

  @override
  List<Object?> get props => [
        address,
        analyticalData,
        node,
        data,
        getData,
      ];

  ChainState copyWith({
    String? address,
    List<DataModel>? analyticalData,
    NodeState? node,
    PostDataState? data,
    GetDataState? getData,
  }) {
    return ChainState(
      address: address ?? this.address,
      analyticalData: analyticalData ?? this.analyticalData,
      node: node ?? this.node,
      data: data ?? this.data,
      getData: getData ?? this.getData,
    );
  }
}

class ChainInitial extends ChainState {
  const ChainInitial()
      : super(
          node: const NodeDefault(),
          data: const PostDataDefault(),
          getData: const GetDataDefault(),
        );
}
