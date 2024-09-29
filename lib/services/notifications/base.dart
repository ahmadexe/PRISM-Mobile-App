import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'package:prism/widgets/core/snackbar/custom_snackbar.dart';
import 'package:googleapis_auth/auth_io.dart' as auth;

class NotificationBase {
  static Future init(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
            onDidReceiveLocalNotification: onDidReceiveLocalNotification);

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<String> getAccessToken() async {
    final jsonString = await rootBundle
        .loadString('assets/data/prism-dev-fc4c1-aca08155bb31.json');

    final serviceAccount = jsonDecode(jsonString);

    final scopes = [
      'https://www.googleapis.com/auth/firebase.messaging',
      'https://www.googleapis.com/auth/firebase.database',
      'https://www.googleapis.com/auth/userinfo.email',
    ];

    final clientCredentials =
        auth.ServiceAccountCredentials.fromJson(serviceAccount);

    final client =
        await auth.clientViaServiceAccount(clientCredentials, scopes);

    final credentials = await auth.obtainAccessCredentialsViaServiceAccount(
      clientCredentials,
      scopes,
      client,
    );

    client.close();

    return credentials.accessToken.data;
  }

  static Future showBigTextNotification({
    var id = 0,
    required String title,
    required String body,
    var payload,
    required FlutterLocalNotificationsPlugin fln,
  }) async {
    const androidPlatformSpecific = AndroidNotificationDetails(
      'prism',
      'channel_name',
      playSound: true,
      importance: Importance.max,
      priority: Priority.high,
    );

    const not = NotificationDetails(android: androidPlatformSpecific);

    await fln.show(id, title, body, not);
  }

  Future<void> sendPushMessage(
      String uid, String deviceToken, String body, String title) async {
    try {
      final serverKey = await getAccessToken();

      const endpoint =
          "https://fcm.googleapis.com/v1/projects/prism-dev-fc4c1/messages:send";

      final message = {
        "message": {
          "token": deviceToken,
          "notification": {
            "title": title,
            "body": body,
          },
        }
      };

      final response = await http.post(
        Uri.parse(endpoint),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $serverKey'
        },
        body: jsonEncode(message),
      );

      debugPrint('Response: ${response.statusCode}: ${response.body}');
    } catch (e) {
      debugPrint('------ $e ------');
    }
  }

  Future<void> listenNotifications(BuildContext context) async {
    FirebaseMessaging.onMessage.listen((event) {
      if (!context.mounted) return;
      _showFlutterNotification(context, event);
    });
  }

  void _showFlutterNotification(BuildContext context, RemoteMessage message) {
    // final notiService = Provider.of<NotiService>(context);
    RemoteNotification? notification = message.notification;
    // notiService.saveNoti(NotificationModel(
    //     title: notification?.title ?? '', body: notification?.body ?? ''));
    SnackBars.success(context, notification?.body ?? '');
  }

  static void onDidReceiveLocalNotification(
    int id,
    String? title,
    String? body,
    String? payload,
  ) async {
    debugPrint('onDidReceiveLocalNotification called');
  }
}
