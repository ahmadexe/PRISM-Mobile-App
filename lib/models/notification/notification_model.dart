import 'dart:convert';

class NotificationModel {
  final String title;
  final String body;
  final String type;
  final DateTime createdAt;

  NotificationModel({
    required this.title,
    required this.body,
    required this.type,
    required this.createdAt,
  });

  NotificationModel copyWith({
    String? title,
    String? body,
    String? type,
    DateTime? createdAt,
  }) {
    return NotificationModel(
      title: title ?? this.title,
      body: body ?? this.body,
      type: type ?? this.type,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'body': body,
      'type': type,
      'createdAt': createdAt.microsecondsSinceEpoch,
    };
  }

  factory NotificationModel.fromMap(Map<String, dynamic> map) {
    return NotificationModel(
      title: map['title'] as String,
      body: map['body'] as String,
      type: map['type'] as String,
      createdAt: DateTime.fromMicrosecondsSinceEpoch(map['createdAt'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory NotificationModel.fromJson(String source) =>
      NotificationModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'NotificationModel(title: $title, body: $body, type: $type, createdAt: $createdAt)';
  }

  @override
  bool operator ==(covariant NotificationModel other) {
    if (identical(this, other)) return true;

    return other.title == title &&
        other.body == body &&
        other.type == type &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return title.hashCode ^ body.hashCode ^ type.hashCode ^ createdAt.hashCode;
  }
}
