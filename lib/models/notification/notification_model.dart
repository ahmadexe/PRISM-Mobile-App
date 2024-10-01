import 'dart:convert';

class NotificationModel {
  final String title;
  final String body;
  final String type;
  final DateTime time;
  final String uid;

  NotificationModel({
    required this.title,
    required this.body,
    required this.type,
    required this.time,
    required this.uid,
  });

  NotificationModel copyWith({
    String? title,
    String? body,
    String? type,
    DateTime? time,
    String? uid,
  }) {
    return NotificationModel(
      title: title ?? this.title,
      body: body ?? this.body,
      type: type ?? this.type,
      time: time ?? this.time,
      uid: uid ?? this.uid,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'body': body,
      'type': type,
      'time': time.millisecondsSinceEpoch,
      'uid': uid,
    };
  }

  factory NotificationModel.fromMap(Map<String, dynamic> map) {
    return NotificationModel(
      title: map['title'] as String,
      body: map['body'] as String,
      type: map['type'] as String,
      time: DateTime.fromMillisecondsSinceEpoch(map['time'] as int),
      uid: map['uid'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory NotificationModel.fromJson(String source) => NotificationModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'NotificationModel(title: $title, body: $body, type: $type, time: $time, uid: $uid)';
  }

  @override
  bool operator ==(covariant NotificationModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.title == title &&
      other.body == body &&
      other.type == type &&
      other.time == time &&
      other.uid == uid;
  }

  @override
  int get hashCode {
    return title.hashCode ^
      body.hashCode ^
      type.hashCode ^
      time.hashCode ^
      uid.hashCode;
  }
}
