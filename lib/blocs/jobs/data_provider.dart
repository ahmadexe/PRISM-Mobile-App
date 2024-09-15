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

      final dataRaw = response.data;
      final data = dataRaw['data'] as List<dynamic>;

      final res = data.map((e) => Job.fromMap(e)).toList();
      return res;
    } catch (e) {
      debugPrint('Exception in Jobs Data Provider(fetchJobs): $e');
      debugPrint('--------------------------');
      rethrow;
    }
  }

  Future<void> likeUnlikeJob(Map<String, dynamic> payload) async {
    try {
      final token = await _auth.currentUser?.getIdToken();
      _client.options.headers['Authorization'] = 'Bearer $token';

      final response =
          await _client.put('/jobs/like', data: json.encode(payload));
      if (response.statusCode != 200) {
        throw 'Failed to like/unlike job';
      }
    } catch (e) {
      debugPrint('Exception in Jobs Data Provider(likeJob): $e');
      debugPrint('--------------------------');
      rethrow;
    }
  }
}
