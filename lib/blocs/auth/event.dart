part of 'bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthRegister extends AuthEvent {
  final String email;
  final String password;
  final Map<String, dynamic> payload;

  const AuthRegister({
    required this.email,
    required this.password,
    required this.payload,
  });

  @override
  List<Object> get props => [email, password, payload];
}