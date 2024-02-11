part of 'bloc.dart';

class _AuthRepository {
  Future<AuthData> register(
          String email, String password, Map<String, dynamic> payload) =>
      _AuthDataProvider.register(email, password, payload);

  Future<AuthData> login(String email, String password) {
    final Map<String, dynamic> payload = {
      'email': email,
      'password': password,
    };

    return _AuthDataProvider.login(payload);
  }

  Future<AuthData> getUser(User? user) => _AuthDataProvider.getUser(user);

  Future<void> logout() => _AuthDataProvider.logout();
}
