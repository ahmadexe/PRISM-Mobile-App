part of 'bloc.dart';

class AuthState extends Equatable {
  final AuthData? user;
  final AuthInitState init;
  final AuthRegisterState register;
  final AuthLoginState login;
  final AuthLogoutState logout;
  final AuthUpdateState update;

  const AuthState({
    this.user,
    required this.init,
    required this.register,
    required this.login,
    required this.logout,
    required this.update,
  });

  AuthState copyWith({
    AuthData? user,
    AuthInitState? init,
    AuthRegisterState? register,
    AuthLoginState? login,
    AuthLogoutState? logout,
    AuthUpdateState? update,
  }) {
    return AuthState(
      user: user ?? this.user,
      init: init ?? this.init,
      register: register ?? this.register,
      login: login ?? this.login,
      logout: logout ?? this.logout,
      update: update ?? this.update,
    );
  }

  @override
  List<Object?> get props => [
        user,
        init,
        register,
        login,
        logout,
        update,
      ];
}

final class AuthDefault extends AuthState {
  const AuthDefault()
      : super(
          init: const AuthInitDefault(),
          register: const AuthRegisterDefault(),
          login: const AuthLoginDefault(),
          logout: const AuthLogoutDefault(),
          update: const AuthUpdateDefault(),
        );
}
