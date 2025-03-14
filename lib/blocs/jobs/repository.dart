part of 'bloc.dart';

class _Adaptor {
  Future<void> createJob(
    final String title,
    final String description,
    final double budget,
    final String budgetMeta,
    final String country,
    final String postedBy,
    final String username,
    final String? avatar,
    final List<String> keywords,
  ) async {
    try {
      final payload = {
        'postedBy': postedBy,
        'title': title,
        'description': description,
        'postedAt': DateTime.now().microsecondsSinceEpoch,
        'country': country,
        'keywords': keywords,
        'budget': budget,
        'budgetMeta': budgetMeta,
        'username': username,
        'avatar': avatar,
      };
      await _JobsDataProvider().createJob(payload);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> likeUnlikeJob(final String jobId, final String userId) async {
    try {
      final payload = {
        'id': jobId,
        'userId': userId,
      };
      await _JobsDataProvider().likeUnlikeJob(payload);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> applyForJob(
    final String jobId,
    final String userId,
    final String username, [
    final String? avatar,
  ]) async {
    try {
      final payload = {
        'jobId': jobId,
        'userId': userId,
        'username': username,
        'avatar': avatar,
      };
      await _JobsDataProvider().applyForJob(payload);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> hireApplicant(String userId, String jobId) async {
    try {
      final payload = {
        'userId': userId,
        'id': jobId,
      };
      await _JobsDataProvider().hireApplicant(payload);
    } catch (e) {
      rethrow;
    }
  }
}
