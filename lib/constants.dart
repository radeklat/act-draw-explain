import 'package:flutter/material.dart';

const Color K_COLOR_FONT_PRIMARY = Colors.black87;
const Color K_COLOR_ICON = Colors.black54;
const Color K_COLOR_PASS = Colors.lightGreen;
const Color K_COLOR_FAIL = Colors.red;
const Color K_COLOR_BACKGROUND = Colors.white;
const Color K_COLOR_BUTTON_PRIMARY = Colors.lightGreenAccent;

// http://spencermortensen.com/articles/typographic-scale/
const double K_FONT_SIZE_XX_LARGE = 192;
const double K_FONT_SIZE_X_LARGE = 96;
const double K_FONT_SIZE_LARGE = 48;
const double K_FONT_SIZE_NORMAL = 24;
const double K_FONT_SIZE_SMALL = 12;
const double K_FONT_SIZE_X_SMALL = 6;

const double K_SIZE_ICON = 32;

const Duration K_DURATION_START_GAME = Duration(seconds: 5);
const Duration K_DURATION_PASS_FAIL_ANIMATION = Duration(milliseconds: 500);

const List<int> K_GAME_DURATION_VALUES = [30, 60, 90, 2 * 60, 3 * 60, 5 * 60, 0];
const List<String> K_GAME_DURATION_DISPLAY = ["30 sec", "60 sec", "90 sec", "2 min", "3 min", "5 min", "Bez omezení"];
const int K_GAME_DURATION_DEFAULT = 90;

const List<String> K_GAME_CONTROL_VALUES = ["buttons", "screen_tilt"];
const List<String> K_GAME_CONTROL_DISPLAY = ["Tlačítka", "Naklopení telefonu"];
const String K_GAME_CONTROL_DEFAULT = "buttons";


const String K_SETTINGS_GAME_DURATION = "settings.game.duration";
const String K_SETTINGS_GAME_CONTROL = "settings.game.control";