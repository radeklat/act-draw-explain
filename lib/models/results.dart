import 'package:shared_preferences/shared_preferences.dart';
import 'package:sprintf/sprintf.dart';

class Results {
  static final String keyPattern = "topic.%s.bestScore";

  static void recordBestScore({int topicID, int newScore}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String key = sprintf(Results.keyPattern, [topicID]);
    int bestScore = prefs.getInt(key) ?? 0;

    if (newScore > bestScore) {
      prefs.setInt(key, newScore);
    }
  }

  static Future<int> getBestScore({int topicID}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String key = sprintf(Results.keyPattern, [topicID]);
    return prefs.getInt(key) ?? 0;
  }
}