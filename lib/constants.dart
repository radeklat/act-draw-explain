import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

const Color K_COLOR_PASS = Colors.lightGreen;
const Color K_COLOR_FAIL = Colors.pink;
const Color K_COLOR_BACKGROUND = Colors.white;

final ThemeData appTheme = ThemeData(
  primaryColor: K_COLOR_FAIL,
  accentColor: Colors.pinkAccent,
  backgroundColor: K_COLOR_BACKGROUND,
  buttonColor: Colors.pinkAccent,

  // http://spencermortensen.com/articles/typographic-scale/
  textTheme: TextTheme(
    headline1: TextStyle(fontSize: 192, color: Colors.black87),
    headline2: TextStyle(fontSize: 96, color: Colors.black87),
    headline3: TextStyle(fontSize: 60, color: Colors.black87),
    headline4: TextStyle(fontSize: 48, color: Colors.black87),
    headline5: TextStyle(fontSize: 34, color: Colors.black87),
    headline6: TextStyle(fontSize: 24, color: Colors.black87),
    subtitle1: TextStyle(fontSize: 16),
    subtitle2: TextStyle(fontSize: 14),
    bodyText1: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
    bodyText2: TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
    caption: TextStyle(fontSize: 12),
    button: TextStyle(fontSize: 24, color: Colors.white),
    overline: TextStyle(fontSize: 11, letterSpacing: 0),
  ),
);

const Duration K_DURATION_START_GAME = Duration(seconds: (kReleaseMode) ? 5 : 5);
const Duration K_DURATION_PASS_FAIL_ANIMATION = Duration(milliseconds: 500);

const List<int> K_GAME_DURATION_VALUES = [30, 60, 90, 2 * 60, 3 * 60, 5 * 60, 0];
const int K_GAME_DURATION_DEFAULT = 90;

const String K_GAME_CONTROL_BUTTONS = "buttons";
const String K_GAME_CONTROL_SCREEN_TILT = "screen_tilt";
const String K_GAME_CONTROL_BOTH = "buttons_and_tilt";

const List<String> K_GAME_CONTROL_VALUES = [K_GAME_CONTROL_BUTTONS, K_GAME_CONTROL_SCREEN_TILT, K_GAME_CONTROL_BOTH];
const String K_GAME_CONTROL_DEFAULT = K_GAME_CONTROL_BOTH;
const bool K_GAME_VIBRATE_DEFAULT = true;
const int K_GAME_CARDS_COUNT_DEFAULT = 20;

const String K_SETTINGS_PREFIX = "settings.";
const String K_SETTINGS_GAME_DURATION = "${K_SETTINGS_PREFIX}game.duration";
const String K_SETTINGS_GAME_CARDS_COUNT = "${K_SETTINGS_PREFIX}game.cards.count";
const String K_SETTINGS_GAME_CONTROL = "${K_SETTINGS_PREFIX}game.control";
const String K_SETTINGS_GAME_VIBRATE = "${K_SETTINGS_PREFIX}game.vibrate";

const K_SENSORS_THROTTLE = Duration(milliseconds: 100);
const K_TILT_THROTTLE = Duration(seconds: 1);

enum DebugLevel { all, movement, none }
enum FeedbackType { bug, feature }

const DebugLevel K_DEBUG_TILT_SENSORS = DebugLevel.none;

class _URL {
  static const String REPO = "https://github.com/radeklat/act-draw-explain";
  final String changelog = "$REPO/blob/master/CHANGELOG.md";
  final UnmodifiableMapView<FeedbackType, String> feedback = UnmodifiableMapView({
    FeedbackType.bug: "$REPO/issues/new?labels=bug%2C+triage&template=bug_report.md",
    FeedbackType.feature: "$REPO/issues/new?labels=enhancement%2C+triage&template=feature_request.md",
  });
}

class K {
  static final url = _URL();
  static final defaultLocale = Locale("en");
}
