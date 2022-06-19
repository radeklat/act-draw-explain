import 'package:flutter/material.dart';

Color contrastingTextColor(Color backgroundColor) {
  return (backgroundColor.computeLuminance() > 0.5) ? Colors.black : Colors.white;
}

Color darken(Color color, [double amount = .1]) {
  assert(amount >= 0 && amount <= 1);

  final hsl = HSLColor.fromColor(color);

  return hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0)).toColor();
}

Color lighten(Color color, [double amount = .1]) {
  assert(amount >= 0 && amount <= 1);

  final hsl = HSLColor.fromColor(color);

  return hsl.withLightness((hsl.lightness + amount).clamp(0.0, 1.0)).toColor();
}

// From https://api.flutter.dev/flutter/material/Colors-class.html
const Map<String, ColorSwatch> _STRING_TO_COLOR_SWATCH = {
  "pink": Colors.pink,
  "pinkAccent": Colors.pinkAccent,
  "red": Colors.red,
  "redAccent": Colors.redAccent,
  "deepOrange": Colors.deepOrange,
  "deepOrangeAccent": Colors.deepOrangeAccent,
  "orange": Colors.orange,
  "orangeAccent": Colors.orangeAccent,
  "amber": Colors.amber,
  "amberAccent": Colors.amberAccent,
  "yellow": Colors.yellow,
  "yellowAccent": Colors.yellowAccent,
  "lime": Colors.lime,
  "limeAccent": Colors.limeAccent,
  "lightGreen": Colors.lightGreen,
  "lightGreenAccent": Colors.lightGreenAccent,
  "green": Colors.green,
  "greenAccent": Colors.greenAccent,
  "teal": Colors.teal,
  "tealAccent": Colors.tealAccent,
  "cyan": Colors.cyan,
  "cyanAccent": Colors.cyanAccent,
  "lightBlue": Colors.lightBlue,
  "lightBlueAccent": Colors.lightBlueAccent,
  "blue": Colors.blue,
  "blueAccent": Colors.blueAccent,
  "indigo": Colors.indigo,
  "indigoAccent": Colors.indigoAccent,
  "purple": Colors.purple,
  "purpleAccent": Colors.purpleAccent,
  "deepPurple": Colors.deepPurple,
  "deepPurpleAccent": Colors.deepPurpleAccent,
  "brown": Colors.brown,
  "grey": Colors.grey,
};

const Map<String, Color> _STRING_TO_COLOR = {
  "black": Colors.black,
  "black12": Colors.black12,
  "black26": Colors.black26,
  "black38": Colors.black38,
  "black45": Colors.black45,
  "black54": Colors.black54,
  "black87": Colors.black87,
  "white": Colors.white,
  "white10": Colors.white10,
  "white12": Colors.white12,
  "white24": Colors.white24,
  "white30": Colors.white30,
  "white38": Colors.white38,
  "white54": Colors.white54,
  "white60": Colors.white60,
  "white70": Colors.white70,
};

const Set<String> _SIMPLE_COLORS = {"black", "white"};

RegExp _colorRegex = RegExp(r"(?<name>[a-zA-Z]+)(?<shade>[0-9]*)");

Color? colorByName(String name) {
  RegExpMatch? match = _colorRegex.firstMatch(name);

  if (match == null) return null;

  String colorName = match.namedGroup("name")!;
  int defaultShade = (colorName.endsWith("Accent")) ? 200 : 500;
  int colorShade = (match.namedGroup("shade") == "") ? defaultShade : int.parse(match.namedGroup("shade")!);

  if (_SIMPLE_COLORS.contains(colorName)) {
    return _STRING_TO_COLOR[name];
  }

  ColorSwatch? baseColor = _STRING_TO_COLOR_SWATCH[colorName];
  return (baseColor == null) ? null : baseColor[colorShade];
}