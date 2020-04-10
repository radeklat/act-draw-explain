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