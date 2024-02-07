part of 'bloc.dart';

class _AuthRepository {
  Future<AuthData> register(
          String email, String password, Map<String, dynamic> payload) =>
      _AuthDataProvider.register(email, password, payload);

  Future<AuthData> login(String email, String password) {
    final payload = {
      'email': email,
      'password': password,
    };

    return _AuthDataProvider.login(payload);
  }
}
