part of 'bloc.dart';

class _AuthDataProvider {
  static final _auth = FirebaseAuth.instance;
  static final Dio _client = Api.getClient('http://localhost:3000/auth');

  static Future<AuthData> register(
      String email, String password, Map<String, dynamic> payload) async {
    try {
      final user = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      final token = await user.user!.getIdToken();
      _client.options.headers['Authorization'] = 'Bearer $token';

      final uid = user.user!.uid;
      payload['uid'] = uid;
      payload['email'] = email;

      final response = await _client.post('/users', data: json.encode(payload));

      if (response.statusCode != 201) {
        throw 'Failed to create user';
      }

      final raw = response.data as Map<String, dynamic>;
      final id = raw['id'] as String;
      final createdAt = raw['createdAt'] as int;
      payload['id'] = id;
      payload['createdAt'] = createdAt;

      final data = AuthData.fromMap(payload);
      return data;
    } on FirebaseAuthException catch (e) {
      debugPrint('Exception in Auth Data Provider(register): $e');
      debugPrint('--------------------------');
      throw e.message!;
    }
  }
}
