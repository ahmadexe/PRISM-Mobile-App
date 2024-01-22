part of 'configs.dart';

extension SuperInt on int {
  Duration get seconds => Duration(seconds: this);
}

extension SuperDuration on Duration {
  Future<void> get delay async => await Future.delayed(this);
}
