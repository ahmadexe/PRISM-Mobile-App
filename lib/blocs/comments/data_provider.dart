part of 'bloc.dart';

class _CommentProvider {
  static final Dio _client = Api.getClient(ClientType.post);
  static final _auth = FirebaseAuth.instance;

  static Future<Comment> createComment(Map<String, dynamic> payload) async {
    try {
      final token = await _auth.currentUser?.getIdToken();
      _client.options.headers['Authorization'] = 'Bearer $token';

      final response =
          await _client.post('/comments', data: json.encode(payload));

      if (response.statusCode != 201) {
        throw 'Failed to create comment';
      }

      final data = response.data as Map<String, dynamic>;
      return Comment.fromMap(data);
    } catch (e) {
      debugPrint('--------------------------');
      debugPrint('Exception in Comment Data Provider(createComment): $e');
      debugPrint('--------------------------');
      rethrow;
    }
  }

  static Future<List<Comment>> getComments(String postId) async {
    try {
      final token = await _auth.currentUser?.getIdToken();
      _client.options.headers['Authorization'] = 'Bearer $token';

      final response = await _client.get('/comments/$postId');

      if (response.statusCode != 200) {
        throw 'Failed to fetch comments';
      }

      final raw = response.data == null ? [] : response.data as List<dynamic>;
      final data = raw.map((e) => Comment.fromMap(e)).toList();
      return data;
    } catch (e) {
      debugPrint('Exception in Comment Data Provider(getComments): $e');
      debugPrint('--------------------------');
      rethrow;
    }
  }
}
