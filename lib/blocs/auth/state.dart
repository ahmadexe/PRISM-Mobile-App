part of 'bloc.dart';

class AuthState extends Equatable {
  final AuthData? user;
  final AuthRegisterState register;
  final AuthLoginState login;

  const AuthState({
    this.user,
    required this.register,
    required this.login,
  });

  AuthState copyWith({
    AuthData? user,
    AuthRegisterState? register,
    AuthLoginState? login,
  }) {
    return AuthState(
      user: user ?? this.user,
      register: register ?? this.register,
      login: login ?? this.login,
    );
  }

  @override
  List<Object?> get props => [
        user,
        register,
        login,
      ];
}

final class AuthDefault extends AuthState {
  const AuthDefault()
      : super(
          register: const AuthRegisterDefault(),
          login: const AuthLoginDefault(),
        );
}
