part of '../../bloc.dart';

class _CreatePostsTool extends Tool {
  _CreatePostsTool(
      {required super.name,
      required super.description,
      required super.parameters});

  static final Dio _client = Api.getClient(ClientType.post);
  static final _auth = FirebaseAuth.instance;

  @override
  Future<ToolResponse> run(Map<String, dynamic> params) async {
    final token = await _auth.currentUser?.getIdToken();
    _client.options.headers['Authorization'] = 'Bearer $token';

    final payload = {
      'title': params['title'],
      'description': params['description'],
      'userId': params['userId'],
      'category': params['category'],
      'userName': params['userName'],
      'userProfilePic': params['userProfilePic'],
      'createdAt': DateTime.now().microsecondsSinceEpoch,
    };

    final response = await _client.post('/posts', data: json.encode(payload));

    if (response.statusCode != 201) {
      return ToolResponse(
          toolName: name,
          isRequestSuccessful: false,
          message:
              'I could not create the post, can I do something else for you?');
    }

    return ToolResponse(
      toolName: name,
      isRequestSuccessful: true,
      message: 'Post created successfully',
    );
  }
}
