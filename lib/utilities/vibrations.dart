import 'package:flutter/services.dart';
import 'package:preferences/preference_service.dart';
import 'package:vibration/vibration.dart';

import '../constants.dart';

class GameVibrations {
  static const MethodChannel _channel = MethodChannel('vibration');
  static bool hasVibrator = false;

  static Future<void> _vibrate({
    int duration = 500,
    List<int> pattern = const [],
    int repeat = -1,
    List<int> intensities = const [],
    int amplitude = -1,
  }) {
    if (GameVibrations.hasVibrator && (PrefService.getBool(K_SETTINGS_GAME_VIBRATE) ?? K_GAME_VIBRATE_DEFAULT)) {
      return _channel.invokeMethod(
        "vibrate",
        {
          "duration": duration,
          "pattern": pattern,
          "repeat": repeat,
          "amplitude": amplitude,
          "intensities": intensities,
        },
      );
    }
    return null;
  }

  static init() async {
    GameVibrations.hasVibrator = await _channel.invokeMethod("hasVibrator");
  }

  static answer() {
    GameVibrations._vibrate(duration: 150);
  }

  static timerTick() {
    GameVibrations._vibrate(duration: 250);
  }

  static gameStart() {
    GameVibrations._vibrate(duration: 1000);
  }

  static gameEnd() {
    GameVibrations._vibrate(duration: 1000);
  }

  static Future<void> cancel() => _channel.invokeMethod("cancel");
}
