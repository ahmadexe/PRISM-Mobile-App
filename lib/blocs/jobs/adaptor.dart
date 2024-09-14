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
}
