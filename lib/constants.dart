import 'dart:collection';

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
const Duration K_DURATION_PLAY_GAME = Duration(seconds: 60);

const List<int> K_DURATIONS_PLAY_GAME = [30, 60, 90, 2 * 60, 3 * 60, 5 * 60, 0];
const int K_DURATION_PLAY_GAME_DEFAULT = 90;

const String K_SETTINGS_GAME_DURATION = "settings.game.duration";