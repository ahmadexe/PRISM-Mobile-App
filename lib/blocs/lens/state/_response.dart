part of '../bloc.dart';

final class LensResponseState extends Equatable {
  final String? error;
  const LensResponseState({
    this.error,
  });

  @override
  List<Object?> get props => [error];
}

final class LensInitial extends LensResponseState {
  const LensInitial();
}

final class LensLoading extends LensResponseState {
  const LensLoading();
}

final class LensSuccess extends LensResponseState {
  const LensSuccess();
}

final class LensFailure extends LensResponseState {
  const LensFailure({
    required String error,
  }) : super(error: error);
}
