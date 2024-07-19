part of 'bloc.dart';

class _AuthAdaptor {
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

  Future<AuthData> update(AuthData userData,
      [XFile? bannerImage, XFile? profileImage]) async {
    Map<String, dynamic> payload = userData.toMap();
    File? bannerFile;
    File? profileFile;

    if (bannerImage != null) {
      bannerFile = File(bannerImage.path);
    }

    if (profileImage != null) {
      profileFile = File(profileImage.path);
    }

    final res = _AuthDataProvider.update(payload, bannerFile, profileFile);
    return res;
  }

  void sendSearchQuery(WebSocketChannel channel ,String query, String id) {
    final payload = {
      'query': query,
      'id': id,
    };

    _AuthDataProvider.sendMessage(channel, payload);
  }

  Future<AuthData> getUser(User? user) => _AuthDataProvider.getUser(user);

  Future<void> logout() => _AuthDataProvider.logout();
}
