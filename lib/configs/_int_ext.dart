part of 'configs.dart';

extension SuperInt on int {
  Duration get milliseconds => Duration(milliseconds: this);
  Duration get seconds => Duration(seconds: this);
  Duration get minutes => Duration(minutes: this);
  Duration get hours => Duration(hours: this);
  Duration get days => Duration(days: this);
}

extension SuperDuration on Duration {
  Future<void> get delay async => await Future.delayed(this);
}