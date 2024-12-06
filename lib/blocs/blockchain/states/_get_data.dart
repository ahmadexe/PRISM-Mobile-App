part of '../bloc.dart';

class GetDataState extends Equatable {
  static bool match(ChainState a, ChainState b) => a.getData != b.getData;
  final String? message;

  const GetDataState({
    this.message,
  });

  @override
  List<Object?> get props => [message];
}

class GetDataDefault extends GetDataState {
  const GetDataDefault();
}

class GetDataLoading extends GetDataState {
  const GetDataLoading();
}

class GetDataSuccess extends GetDataState {
  const GetDataSuccess();
}

class GetDataFailure extends GetDataState {
  const GetDataFailure({
    required String message,
  }) : super(message: message);
}
