part of 'configs.dart';

extension SuperDate on DateTime {
  DateTime get today => DateTime(year, month, day);

  String getDifference(DateTime date) {
    int days = difference(date).inDays;
    if (days > 0) return '${days.toInt()} days';
    int hours = difference(date).inHours;
    if (hours > 0) return '${hours.toInt()} hours';
    int minutes = difference(date).inMinutes;
    if (minutes > 0) return '${minutes.toInt()} minutes';
    return '${difference(date).inSeconds.toInt()} seconds';
  }
}
