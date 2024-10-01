part of 'bloc.dart';

class NotificationProvider {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static void _increaseUnreadCount(String uid) {
    try {
      final DocumentReference user =
          _firestore.collection('notificationCount').doc(uid);
      user.update({'unread': FieldValue.increment(1)});
    } catch (e) {
      debugPrint('Exception in Notification Provider(increaseUnreadCount): $e');
      debugPrint('--------------------------');
      rethrow;
    }
  }

  static void _clearUnreadCount(String uid) {
    try {
      final DocumentReference user =
          _firestore.collection('notificationCount').doc(uid);
      user.update({'unread': 0});
    } catch (e) {
      debugPrint('Exception in Notification Provider(clearUnreadCount): $e');
      debugPrint('--------------------------');
      rethrow;
    }
  }

  static Future<void> sendNotification(String title, String body, String uid,
      String deviceToken, String type) async {
    try {
      final service = NotificationBase();
      service.sendPushMessage(uid, deviceToken, title, body);

      final timeNow = DateTime.now().microsecondsSinceEpoch;

      final payload = {
        'title': title,
        'body': body,
        'time': timeNow,
        'uid': uid,
        'type': type,
      };

      await _firestore
          .collection('notifications')
          .doc(timeNow.toString())
          .set(payload);

      _increaseUnreadCount(uid);
    } catch (e) {
      debugPrint('Exception in Notification Provider(sendNotification): $e');
      debugPrint('--------------------------');
      rethrow;
    }
  }

  static Future<List<NotificationModel>> fetchNotifications(String uid) async {
    try {
      final snapshot = await _firestore
          .collection('notifications')
          .where('uid', isEqualTo: uid)
          .orderBy('time', descending: true)
          .get();

      final data = snapshot.docs.map((e) {
        final raw = e.data();
        return NotificationModel.fromMap(raw);
      }).toList();

      _clearUnreadCount(uid);

      return data;
    } catch (e) {
      debugPrint('Exception in Notification Provider(fetchNotifications): $e');
      debugPrint('--------------------------');
      rethrow;
    }
  }

  static Stream<DocumentSnapshot<Map<String, dynamic>>> getCountStream(
      String uid) {
    try {
      return _firestore
          .collection('notificationCount')
          .doc(uid)
          .snapshots()
          .asBroadcastStream();
    } catch (e) {
      debugPrint('Exception in Notification Provider(getCountStream): $e');
      debugPrint('--------------------------');
      rethrow;
    }
  }
}
