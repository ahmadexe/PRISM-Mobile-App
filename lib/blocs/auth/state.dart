part of 'bloc.dart';

class AuthState extends Equatable {
  final AuthRegisterState register;
  
  const AuthState({
    required this.register,
  });
  
  AuthState copyWith({
    AuthRegisterState? register,
  }) {
    return AuthState(
      register: register ?? this.register,
    );
  }

  @override
  List<Object> get props => [register];
}

final class AuthDefault extends AuthState {
  const AuthDefault() : super(register: const AuthRegisterDefault());
}
