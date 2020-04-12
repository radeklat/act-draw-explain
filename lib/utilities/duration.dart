import 'package:sprintf/sprintf.dart';

String addZeroIfFirst(int value, bool isFirst) {
  return sprintf((isFirst) ? "%d": "%02d", [value]);
}

extension DurationFormatting on Duration {
  String format() {
    var seconds = this.inSeconds;
    final days = seconds ~/ Duration.secondsPerDay;
    seconds -= days * Duration.secondsPerDay;
    final hours = seconds ~/ Duration.secondsPerHour;
    seconds -= hours * Duration.secondsPerHour;
    final minutes = seconds ~/ Duration.secondsPerMinute;
    seconds -= minutes * Duration.secondsPerMinute;

    final List<String> tokens = [];

    if (days != 0) tokens.add(days.toString());
    if (tokens.isNotEmpty || hours != 0) tokens.add(addZeroIfFirst(hours, tokens.isEmpty));
    if (tokens.isNotEmpty || minutes != 0) tokens.add(addZeroIfFirst(minutes, tokens.isEmpty));
    tokens.add(addZeroIfFirst(seconds, tokens.isEmpty));

    return tokens.join(':');
  }
}