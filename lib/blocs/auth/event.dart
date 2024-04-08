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

class AuthLogin extends AuthEvent {
  final String email; 
  final String password;

  const AuthLogin({
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [email, password];
}

class AuthInit extends AuthEvent {
  final User? user;

  const AuthInit({
    this.user,
  });
}

class AuthUpdate extends AuthEvent {
  final AuthData userData;
  final XFile? bannerImage;
  final XFile? profileImage;

  const AuthUpdate({
    required this.userData,
    this.bannerImage,
    this.profileImage,
  });
}

class AuthLogout extends AuthEvent {
  const AuthLogout();
}