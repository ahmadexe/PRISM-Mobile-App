part of 'bloc.dart';

class _PostProvider {
  static final Dio _client = Api.getClient(ClientType.post);
  static final _auth = FirebaseAuth.instance;
  static final _storage = FirebaseStorage.instance;
  static final _ref = _storage.ref();

  static Future<List<PostData>> getPosts() async {
    try {
      final token = await _auth.currentUser?.getIdToken();
      _client.options.headers['Authorization'] = 'Bearer $token';

      final response = await _client.get('/posts');

      if (response.statusCode != 200) {
        throw 'Failed to fetch posts';
      }

      final raw = response.data == null ? [] : response.data as List<dynamic>;

      final data = raw.map((e) => PostData.fromMap(e)).toList();
      return data;
    } catch (e) {
      debugPrint('Exception in Post Data Provider(getPosts): $e');
      debugPrint('--------------------------');
      rethrow;
    }
  }

  static Future<void> createPost(
      Map<String, dynamic> payload, File? file) async {
    try {
      final token = await _auth.currentUser?.getIdToken();
      _client.options.headers['Authorization'] = 'Bearer $token';

      if (file != null) {
        final time = payload['createdAt'] as int;
        final userId = payload['userId'] as String;

        final ref = _ref.child('posts/$userId/$time');
        final res = await ref.putFile(file);
        final url = await res.ref.getDownloadURL();

        payload['imageUrl'] = url;
      }

      final response = await _client.post('/posts', data: json.encode(payload));

      if (response.statusCode != 201) {
        throw 'Failed to create post';
      }
    } catch (e) {
      debugPrint('Exception in Post Data Provider(createPost): $e');
      debugPrint('--------------------------');
      rethrow;
    }
  }

  // ignore: unused_element
  static Future<void> updatePost(
      Map<String, dynamic> payload, File? file) async {
    try {
      final token = await _auth.currentUser?.getIdToken();
      _client.options.headers['Authorization'] = 'Bearer $token';

      if (file != null) {
        final time = payload['createdAt'] as int;
        final userId = payload['userId'] as String;

        final ref = _ref.child('posts/$userId/$time');
        final res = await ref.putFile(file);
        final url = await res.ref.getDownloadURL();

        payload['imageUrl'] = url;
      }

      final response = await _client.put('/posts', data: json.encode(payload));

      if (response.statusCode != 200) {
        throw 'Failed to update post';
      }
    } catch (e) {
      debugPrint('Exception in Post Data Provider(updatePost): $e');
      debugPrint('--------------------------');
      rethrow;
    }
  }

  static Future<PostData> vote(
      String postId, String userId, bool isUpVote) async {
    try {
      final token = await _auth.currentUser?.getIdToken();
      _client.options.headers['Authorization'] = 'Bearer $token';

      final Response response;

      if (isUpVote) {
        response = await _client.put('/posts/upvote/$postId/$userId');
      } else {
        response = await _client.put('/posts/downvote/$postId/$userId');
      }

      if (response.statusCode != 200) {
        throw 'Failed to upvote post';
      }

      final raw = response.data! as Map<String, dynamic>;

      final data = PostData.fromMap(raw['data']);
      return data;
    } catch (e) {
      debugPrint('Exception in Post Data Provider(vote): $e');
      debugPrint('--------------------------');
      rethrow;
    }
  }
}
