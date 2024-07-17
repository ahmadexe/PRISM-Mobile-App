part of 'bloc.dart';

class _AuthDataProvider {
  static final _auth = FirebaseAuth.instance;
  static final Dio _client = Api.getClient(ClientType.auth);
  static final _storage = FirebaseStorage.instance;
  static final _ref = _storage.ref();

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

      final data = AuthData.fromMap(raw);
      return data;
    } on FirebaseAuthException catch (e) {
      debugPrint('Exception in Auth Data Provider(register): $e');
      debugPrint('--------------------------');
      throw e.message!;
    }
  }

  static Future<AuthData> login(Map<String, dynamic> payload) async {
    try {
      final user = await _auth.signInWithEmailAndPassword(
        email: payload['email'] as String,
        password: payload['password'] as String,
      );

      final data = await getUser(user.user);
      return data;
    } catch (e) {
      debugPrint('Exception in Auth Data Provider(login): $e');
      debugPrint('--------------------------');
      rethrow;
    }
  }

  static Future<AuthData> getUser(User? user) async {
    try {
      final token = await user?.getIdToken();

      _client.options.headers['Authorization'] = 'Bearer $token';

      final response = await _client.get('/users/${user?.uid}');

      if (response.statusCode != 200) {
        throw 'Failed to fetch user';
      }

      final raw = response.data as Map<String, dynamic>;

      final data = AuthData.fromMap(raw);
      return data;
    } catch (e) {
      debugPrint('Exception in Auth Data Provider(getUser): $e');
      debugPrint('--------------------------');
      rethrow;
    }
  }

  static Future<void> logout() async {
    try {
      await _auth.signOut();
    } catch (e) {
      debugPrint('Exception in Auth Data Provider(logout): $e');
      debugPrint('--------------------------');
      rethrow;
    }
  }

  static Future<AuthData> update(Map<String, dynamic> payload,
      [File? banner, File? profile]) async {
    try {
      if (banner != null) {
        final ref = _ref.child('banners/${payload['uid']}');
        await ref.putFile(banner);
        final url = await ref.getDownloadURL();
        payload['bannerImageUrl'] = url;
      }

      if (profile != null) {
        final ref = _ref.child('profiles/${payload['uid']}');
        await ref.putFile(profile);
        final url = await ref.getDownloadURL();
        payload['imageUrl'] = url;
      }

      final user = _auth.currentUser;

      final token = await user?.getIdToken();
      _client.options.headers['Authorization'] = 'Bearer $token';

      final response = await _client.put('/users', data: json.encode(payload));

      if (response.statusCode != 200) {
        throw 'Failed to update user';
      }

      final data = AuthData.fromMap(payload);
      return data;
    } catch (e) {
      debugPrint('Exception in Auth Data Provider(update): $e');
      debugPrint('--------------------------');
      rethrow;
    }
  }

  static Future<AuthData> getUserById(String id) async {
    try {
      final token = await _auth.currentUser?.getIdToken();

      _client.options.headers['Authorization'] = 'Bearer $token';

      final response = await _client.get('/users/primitive/$id');

      if (response.statusCode != 200) {
        throw 'Failed to fetch user';
      }

      final raw = response.data as Map<String, dynamic>;

      final data = AuthData.fromMap(raw);

      return data;
    } catch (e) {
      debugPrint('Exception in Auth Data Provider(getUserById): $e');
      debugPrint('--------------------------');
      rethrow;
    }
  }

  static Future<void> forgotPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      debugPrint('Exception in Auth Data Provider(forgotPassword): $e');
      debugPrint('--------------------------');
      rethrow;
    }
  }

  static Future<void> toggleFollow(String to, String from) async {
    try {
      final token = await _auth.currentUser?.getIdToken();

      _client.options.headers['Authorization'] = 'Bearer $token';

      final response = await _client.put('/users/follow', data: {
        'to': to,
        'from': from,
      });

      if (response.statusCode != 200) {
        throw 'Failed to toggle follow';
      }
    } catch (e) {
      debugPrint('Exception in Auth Data Provider(toggleFollow): $e');
      debugPrint('--------------------------');
      rethrow;
    }
  }
}
