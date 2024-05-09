part of 'bloc.dart';

class _PostProvider {
  static final Dio _client = Api.getClient('http://3.111.196.231:3001/v1');
  static final _auth = FirebaseAuth.instance;

  static Future<List<Post>> getPosts() async {
    try {
      final token = await _auth.currentUser?.getIdToken();
      _client.options.headers['Authorization'] = 'Bearer $token';

      final response = await _client.get('/posts');

      if (response.statusCode != 200) {
        throw 'Failed to fetch posts';
      }

      final raw = response.data == null ? [] : response.data as List<dynamic>;

      final data = raw.map((e) => Post.fromMap(e)).toList();
      return data;
    } catch (e) {
      debugPrint('Exception in Post Data Provider(getPosts): $e');
      debugPrint('--------------------------');
      rethrow;
    }
  }
}