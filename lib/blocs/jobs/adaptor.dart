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
    final String avatar,
  ) async {
    try {
      final payload = {
        'title': title,
        'description': description,
        'budget': budget,
        'budgetMeta': budgetMeta,
        'country': country,
        'postedBy': postedBy,
        'username': username,
        'avatar': avatar,
        'postedAt': DateTime.now().microsecondsSinceEpoch,
      };
      await _JobsDataProvider().createJob(payload);
    } catch (e) {
      rethrow;
    }
  }
}
