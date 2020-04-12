import 'package:flutter/material.dart';

const Color K_COLOR_PASS = Colors.lightGreen;
const Color K_COLOR_FAIL = Colors.pink;
const Color K_COLOR_BACKGROUND = Colors.white;

const Duration K_DURATION_START_GAME = Duration(seconds: 1);
const Duration K_DURATION_PASS_FAIL_ANIMATION = Duration(milliseconds: 500);

const List<int> K_GAME_DURATION_VALUES = [30, 60, 90, 2 * 60, 3 * 60, 5 * 60, 0];
const List<String> K_GAME_DURATION_DISPLAY = ["30 sec", "60 sec", "90 sec", "2 min", "3 min", "5 min", "Bez omezení"];
const int K_GAME_DURATION_DEFAULT = 90;

const String K_GAME_CONTROL_BUTTONS = "buttons";
const String K_GAME_CONTROL_SCREEN_TILT = "screen_tilt";
const String K_GAME_CONTROL_BOTH = "buttons_and_tilt";

const List<String> K_GAME_CONTROL_VALUES = [K_GAME_CONTROL_BUTTONS, K_GAME_CONTROL_SCREEN_TILT, K_GAME_CONTROL_BOTH];
const List<String> K_GAME_CONTROL_DISPLAY = ["Tlačítka", "Naklopení telefonu", "Tlačítka i naklopení"];
const String K_GAME_CONTROL_DEFAULT = "buttons";

const String K_SETTINGS_GAME_DURATION = "settings.game.duration";
const String K_SETTINGS_GAME_CONTROL = "settings.game.control";

const K_SENSORS_THROTTLE = Duration(milliseconds: 100);
const K_TILT_THROTTLE = Duration(seconds: 1);


enum DebugLevel { all, movement, none }
const DebugLevel K_DEBUG_TILT_SENSORS = DebugLevel.none;