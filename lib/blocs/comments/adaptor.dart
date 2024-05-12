part of 'bloc.dart';

class _CommentAdaptor {
  Future<Comment> createComment(
    String userId,
    String postId,
    String content,
    String userName,
    String? userProfilePic,
    DateTime createdAt,
  ) async {
    try {
      final payload = {
        'userId': userId,
        'postId': postId,
        'content': content,
        'userName': userName,
        'userProfilePic': userProfilePic,
        'createdAt': createdAt.microsecondsSinceEpoch,
      };

      final comment = await _CommentProvider.createComment(payload);
      return comment;
    } catch (e) {
      rethrow;
    }
  }
}
