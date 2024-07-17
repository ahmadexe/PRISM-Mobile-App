part of '../bloc.dart';

class ToggleFollowState extends Equatable {
  static bool match(AuthState a, AuthState b) => a.follow != b.follow;

  final String? message;

  const ToggleFollowState({
    this.message,
  });

  @override
  List<Object?> get props => [message];
}

class ToggleFollowDefault extends ToggleFollowState {
  const ToggleFollowDefault();
}

class ToggleFollowLoading extends ToggleFollowState {
  const ToggleFollowLoading();
}

class ToggleFollowSuccess extends ToggleFollowState {
  const ToggleFollowSuccess();
}

class ToggleFollowFailure extends ToggleFollowState {
  const ToggleFollowFailure({
    required String message,
  }) : super(message: message);
}