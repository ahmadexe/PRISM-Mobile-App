part of '../bloc.dart';

final class LikeToggleState extends Equatable {
  static bool match(JobsState a, JobsState b) => a.like != b.like;

  final String? error;
  const LikeToggleState({
    this.error,
  });

  @override
  List<Object?> get props => [error];
}

final class LikeToggleInitial extends LikeToggleState {
  const LikeToggleInitial();
}

final class LikeToggleLoading extends LikeToggleState {
  const LikeToggleLoading();
}

final class LikeToggleSuccess extends LikeToggleState {
  const LikeToggleSuccess();
}

final class LikeToggleFailure extends LikeToggleState {
  const LikeToggleFailure({
    required String error,
  }) : super(error: error);
}
