import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';

int getCurrentGameDuration(SharedPreferences prefs) {
  int duration;
  if (prefs != null) {
    duration = prefs.getInt(K_SETTINGS_GAME_DURATION);
    return (K_DURATIONS_PLAY_GAME.indexOf(duration) >= 0) ? duration : K_DURATION_PLAY_GAME_DEFAULT;
  }
  return K_DURATION_PLAY_GAME_DEFAULT;
}