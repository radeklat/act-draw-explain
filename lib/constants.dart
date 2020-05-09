import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

const Color K_COLOR_PASS = Colors.lightGreen;
const Color K_COLOR_FAIL = Colors.pink;
const Color K_COLOR_BACKGROUND = Colors.white;

final ThemeData AppTheme = ThemeData(
  primaryColor: K_COLOR_FAIL,
  accentColor: Colors.pinkAccent,
  backgroundColor: K_COLOR_BACKGROUND,
  buttonColor: Colors.pinkAccent,

  // http://spencermortensen.com/articles/typographic-scale/
  textTheme: TextTheme(
    display1: TextStyle(fontSize: 192, color: Colors.black87),
    display2: TextStyle(fontSize: 96, color: Colors.black87),
    display3: TextStyle(fontSize: 48, color: Colors.black87),
    display4: TextStyle(fontSize: 36, color: Colors.black87),
    title: TextStyle(fontSize: 30, color: Colors.pink.shade700),
    subtitle: TextStyle(fontSize: 21, color: Colors.pink.shade600),
    body1: TextStyle(fontSize: 16),
    button: TextStyle(fontSize: 24, color: Colors.white),
    overline: TextStyle(fontSize: 11, letterSpacing: 0),
  ),
);

const Duration K_DURATION_START_GAME = Duration(seconds: (kReleaseMode) ? 5 : 5);
const Duration K_DURATION_PASS_FAIL_ANIMATION = Duration(milliseconds: 500);

const List<int> K_GAME_DURATION_VALUES = [30, 60, 90, 2 * 60, 3 * 60, 5 * 60, 0];
const List<String> K_GAME_DURATION_DISPLAY = ["30 sec", "60 sec", "90 sec", "2 min", "3 min", "5 min", "Bez omezení"];
const int K_GAME_DURATION_DEFAULT = 90;

const String K_GAME_CONTROL_BUTTONS = "buttons";
const String K_GAME_CONTROL_SCREEN_TILT = "screen_tilt";
const String K_GAME_CONTROL_BOTH = "buttons_and_tilt";

const List<String> K_GAME_CONTROL_VALUES = [K_GAME_CONTROL_BUTTONS, K_GAME_CONTROL_SCREEN_TILT, K_GAME_CONTROL_BOTH];
const List<String> K_GAME_CONTROL_DISPLAY = ["Tlačítky", "Naklopením telefonu", "Tlačítky i naklopením"];
const String K_GAME_CONTROL_DEFAULT = "buttons";
const bool K_GAME_VIBRATE_DEFAULT = true;
const int K_GAME_CARDS_COUNT_DEFAULT = 20;

const String K_SETTINGS_GAME_DURATION = "settings.game.duration";
const String K_SETTINGS_GAME_CARDS_COUNT = "settings.game.cards.count";
const String K_SETTINGS_GAME_CONTROL = "settings.game.control";
const String K_SETTINGS_GAME_VIBRATE = "settings.game.vibrate";

const K_SENSORS_THROTTLE = Duration(milliseconds: 100);
const K_TILT_THROTTLE = Duration(seconds: 1);

enum DebugLevel { all, movement, none }

const DebugLevel K_DEBUG_TILT_SENSORS = DebugLevel.none;
