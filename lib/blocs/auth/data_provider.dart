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

      payload['createdAt'] = DateTime.now().millisecondsSinceEpoch;

      final response = await _client.post('/users', data: json.encode(payload));

      if (response.statusCode != 201) {
        throw 'Failed to create user';
      }

      final raw = response.data as Map<String, dynamic>;
      final uid = user.user!.uid;
      final id = raw['insertedId'] as String;

      payload['uid'] = uid;
      payload['id'] = id;

      final data = AuthData.fromMap(payload);
      return data;
    } on FirebaseAuthException catch (e) {
      debugPrint('Exception in Auth Data Provider(register): $e');
      debugPrint('--------------------------');
      throw e.message!;
    }
  }
}
