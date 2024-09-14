part of 'bloc.dart';

class _JobsDataProvider {
  final _client = Api.getClient(ClientType.jobs);
  final _auth = FirebaseAuth.instance;

  Future<void> createJob(Map<String, dynamic> payload) async {
    try {
      final token = await _auth.currentUser?.getIdToken();
      _client.options.headers['Authorization'] = 'Bearer $token';

      final response = await _client.post('/jobs', data: json.encode(payload));
      if (response.statusCode != 201) {
        debugPrint('Failed to create job: ${response.data}');
        throw 'Failed to create job';
      }
    } catch (e) {
      debugPrint('Exception in Jobs Data Provider(createJob): $e');
      debugPrint('--------------------------');
      rethrow;
    }
  }
}
