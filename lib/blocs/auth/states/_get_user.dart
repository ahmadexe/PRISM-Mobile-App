part of '../bloc.dart';

class GetUserState extends Equatable {
  static bool match(AuthState a, AuthState b) => a.get != b.get;

  final AuthData? user;
  final String? message;

  const GetUserState({this.message, this.user});

  @override
  List<Object?> get props => [message];
}

class GetUserDefault extends GetUserState {
  const GetUserDefault();
}

class GetUserLoading extends GetUserState {
  const GetUserLoading();
}

class GetUserSuccess extends GetUserState {
  const GetUserSuccess({
    required AuthData user,
  }) : super(user: user);
}

class GetUserFailure extends GetUserState {
  const GetUserFailure({
    required String message,
  }) : super(message: message);
}
