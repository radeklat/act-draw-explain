import 'package:flutter/cupertino.dart';
import 'package:preferences/preference_service.dart';
import 'package:sprintf/sprintf.dart';

class TopicBestScore extends ChangeNotifier {
  final String keyPattern = "topic.%s.bestScore";

  String _getKey(int topicID) {
    return sprintf(keyPattern, [topicID]);
  }

  void record({required int topicID, required int newScore}) {
    String key = _getKey(topicID);
    int bestScore = PrefService.getInt(key) ?? 0;

    if (newScore > bestScore) {
      PrefService.setInt(key, newScore);
      notifyListeners();
    }
  }

  int get({required int topicID}) {
    return PrefService.getInt(_getKey(topicID));
  }
}