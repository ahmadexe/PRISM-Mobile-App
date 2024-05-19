part of 'bloc.dart';

class _ChatsProvider {
  static final Dio _client = Api.getClient(ClientType.chat);
  static final _auth = FirebaseAuth.instance;

  static WebSocketChannel initChatChannel(String senderId, String receiverId) {
    final channel = WebSocketChannel.connect(
      Uri.parse(
          'ws://3.111.196.231:3002/v1/chats/ws?id1=$senderId&&id2=$receiverId'),
    );

    return channel;
  }

  static void sendMessage(
      WebSocketChannel channel, Map<String, dynamic> payload) {
    channel.sink.add(json.encode(payload));
  }

  static Future<Map<String, dynamic>> initConvo(
      Map<String, dynamic> payload) async {
    try {
      final token = await _auth.currentUser?.getIdToken();
      _client.options.headers['Authorization'] = 'Bearer $token';

      final response = await _client.post('/chats/convo', data: payload);

      if (response.statusCode == 200) {
        final Conversation convo;
        final List<Message> messages = [];
        if (response.data['messages'] != null) {
          for (final message in response.data['messages']) {
            messages.insert(
                0, Message.fromMap(message as Map<String, dynamic>));
          }
        }

        convo = Conversation.fromMap(
            response.data['conversation'] as Map<String, dynamic>);

        return {
          'convo': convo,
          'messages': messages,
        };
      } else {
        throw Exception('Failed to load convo');
      }
    } catch (e) {
      debugPrint('Error fetching convo in chats bloc');
      debugPrint(e.toString());
      throw Exception('Failed to load convo');
    }
  }

  static Future<List<Conversation>> fetchAllConvo(String id) async {
    try {
      final token = await _auth.currentUser?.getIdToken();
      _client.options.headers['Authorization'] = 'Bearer $token';

      final response = await _client.get('/chats/convo/$id');

      if (response.statusCode == 200) {
        final List<Conversation> convos = [];
        if (response.data['conversations'] != null) {
          for (final convo in response.data['conversations']) {
            convos.add(Conversation.fromMap(convo as Map<String, dynamic>));
          }
        }

        return convos;
      } else {
        throw Exception('Failed to load convo');
      }
    } catch (e) {
      debugPrint('Error fetching convo in chats bloc');
      debugPrint(e.toString());
      throw Exception('Failed to load convo');
    }
  }
}
