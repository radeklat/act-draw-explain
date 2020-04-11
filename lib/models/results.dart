import 'package:flutter/cupertino.dart';
import 'package:preferences/preference_service.dart';
import 'package:sprintf/sprintf.dart';

class Results {
  static final String keyPattern = "topic.%s.bestScore";

  static String _getKey(int topicID) {
    return sprintf(Results.keyPattern, [topicID]);
  }

  static void recordBestScore({@required int topicID, @required int newScore}) {
    String key = _getKey(topicID);
    int bestScore = PrefService.getInt(key) ?? 0;

    if (newScore > bestScore) {
      PrefService.setInt(key, newScore);
    }
  }

  static int getBestScore({@required int topicID}) {
    return PrefService.getInt(_getKey(topicID));
  }
}