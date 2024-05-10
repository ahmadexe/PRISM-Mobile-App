part of 'bloc.dart';

class _PostsRepo {
  Future<void> createPost(Map<String, dynamic> payload,
      XFile? image) async {
    try {
      File? file;
      if (image != null) {
        file = File(image.path);
      }

      await _PostProvider.createPost(payload, file);
    } catch (e) {
      rethrow;
    }
  }
}
