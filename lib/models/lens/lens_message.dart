import 'dart:convert';

class LensMessage {
  final String message;
  final bool isFromLens;
  final DateTime time;

  LensMessage({
    required this.message,
    required this.isFromLens,
    required this.time,
  });

  LensMessage copyWith({
    String? message,
    bool? isFromLens,
    DateTime? time,
  }) {
    return LensMessage(
      message: message ?? this.message,
      isFromLens: isFromLens ?? this.isFromLens,
      time: time ?? this.time,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'message': message,
      'isFromLens': isFromLens,
      'time': time.millisecondsSinceEpoch,
    };
  }

  factory LensMessage.fromMap(Map<String, dynamic> map) {
    return LensMessage(
      message: map['message'] as String,
      isFromLens: map['isFromLens'] as bool,
      time: DateTime.fromMillisecondsSinceEpoch(map['time'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory LensMessage.fromJson(String source) =>
      LensMessage.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'LensMessage(message: $message, isFromLens: $isFromLens, time: $time)';

  @override
  bool operator ==(covariant LensMessage other) {
    if (identical(this, other)) return true;

    return other.message == message &&
        other.isFromLens == isFromLens &&
        other.time == time;
  }

  @override
  int get hashCode => message.hashCode ^ isFromLens.hashCode ^ time.hashCode;
}
