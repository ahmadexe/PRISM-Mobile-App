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
        throw 'Failed to create job';
      }
    } catch (e) {
      debugPrint('Exception in Jobs Data Provider(createJob): $e');
      debugPrint('--------------------------');
      rethrow;
    }
  }

  Future<List<Job>> fetchJobs() async {
    try {
      final response = await _client.get('/jobs');
      if (response.statusCode != 200) {
        throw 'Failed to fetch jobs';
      }

      final List<dynamic> data = response.data;
      return data.map((e) => Job.fromJson(e)).toList();
    } catch (e) {
      debugPrint('Exception in Jobs Data Provider(fetchJobs): $e');
      debugPrint('--------------------------');
      rethrow;
    }
  }
}
