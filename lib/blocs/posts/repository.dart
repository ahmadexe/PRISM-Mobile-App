part of 'bloc.dart';

class _PostAdaptor {
  Future<void> createPost(Map<String, dynamic> payload, XFile? image) async {
    try {
      File? file;
      if (image != null) {
        file = File(image.path);
      }

      final createdAt = DateTime.now().microsecondsSinceEpoch;
      payload['createdAt'] = createdAt;

      await _PostProvider.createPost(payload, file);
    } catch (e) {
      rethrow;
    }
  }
}
