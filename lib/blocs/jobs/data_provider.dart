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
      final token = await _auth.currentUser?.getIdToken();
      _client.options.headers['Authorization'] = 'Bearer $token';

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

  Future<List<Job>> fetchMyJobs(String id) async {
    try {
      final token = await _auth.currentUser?.getIdToken();
      _client.options.headers['Authorization'] = 'Bearer $token';

      final response = await _client.get('/jobs/user/$id');
      if (response.statusCode != 200) {
        throw 'Failed to fetch jobs';
      }

      final dataRaw = response.data;
      final data = dataRaw['data'] as List<dynamic>?;

      if (data == null) return [];

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

  Future<void> applyForJob(Map<String, dynamic> payload) async {
    try {
      final token = await _auth.currentUser?.getIdToken();
      _client.options.headers['Authorization'] = 'Bearer $token';

      final response =
          await _client.post('/jobs/apply', data: json.encode(payload));
      if (response.statusCode != 201) {
        throw 'Failed to apply for job';
      }
    } catch (e) {
      debugPrint('Exception in Jobs Data Provider(applyForJob): $e');
      debugPrint('--------------------------');
      rethrow;
    }
  }

  Future<List<JobApplication>> fetchApplications(String id,
      [bool isUser = false]) async {
    try {
      final token = await _auth.currentUser?.getIdToken();
      final client = Api.getClient(ClientType.jobs);

      client.options.headers['Authorization'] = 'Bearer $token';

      final Response<dynamic> response;

      if (isUser) {
        response = await client.get('/jobs/application/user/$id');
      } else {
        response = await client.get('/jobs/application/job/$id');
      }

      if (response.statusCode != 200) {
        throw ("Failed to fetch applications");
      }

      final dataRaw = response.data;

      final data = dataRaw['data'] as List<dynamic>?;

      if (data == null) return [];

      final res = data.map((e) => JobApplication.fromMap(e)).toList();

      return res;
    } catch (e) {
      debugPrint('Exception in Jobs Data Provider(fetchApplications): $e');
      debugPrint('--------------------------');
      rethrow;
    }
  }

  Future<void> hireApplicant(Map<String, dynamic> payload) async {
    try {
      final token = await _auth.currentUser?.getIdToken();
      _client.options.headers['Authorization'] = 'Bearer $token';

      final response =
          await _client.put('/jobs/hire', data: json.encode(payload));

      if (response.statusCode != 200) {
        throw 'Failed to hire applicant';
      }
    } catch (e) {
      debugPrint('Exception in Jobs Data Provider(hireApplicant): $e');
      debugPrint('--------------------------');
      rethrow;
    }
  }
}
