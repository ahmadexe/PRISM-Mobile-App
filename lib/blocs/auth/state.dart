part of 'bloc.dart';

class AuthState extends Equatable {
  final AuthData? user;
  final AuthRegisterState register;
  
  const AuthState({
    this.user,
    required this.register,
  });
  
  AuthState copyWith({
    AuthData? user,
    AuthRegisterState? register,
  }) {
    return AuthState(
      user: user ?? this.user,
      register: register ?? this.register,
    );
  }

  @override
  List<Object?> get props => [user, register];
}

final class AuthDefault extends AuthState {
  const AuthDefault() : super(register: const AuthRegisterDefault());
}
