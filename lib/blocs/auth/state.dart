part of 'bloc.dart';

class AuthState extends Equatable {
  final AuthData? user;
  final AuthInitState init;
  final AuthRegisterState register;
  final AuthLoginState login;

  const AuthState({
    this.user,
    required this.init,
    required this.register,
    required this.login,
  });

  AuthState copyWith({
    AuthData? user,
    AuthInitState? init,
    AuthRegisterState? register,
    AuthLoginState? login,
  }) {
    return AuthState(
      user: user ?? this.user,
      init: init ?? this.init,
      register: register ?? this.register,
      login: login ?? this.login,
    );
  }

  @override
  List<Object?> get props => [
        user,
        init,
        register,
        login,
      ];
}

final class AuthDefault extends AuthState {
  const AuthDefault()
      : super(
          init: const AuthInitDefault(),
          register: const AuthRegisterDefault(),
          login: const AuthLoginDefault(),
        );
}
