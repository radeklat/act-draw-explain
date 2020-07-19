import 'package:act_draw_explain/utilities/color.dart';
import 'package:flutter/material.dart';
import 'package:test/test.dart';

void main() {
  group('colorByName', () {
    group('should resolve', () {
      test('colors without shade', () {
        expect(colorByName("red"), Colors.red.shade500);
      });

      test('colors with shade', () {
        expect(colorByName("red500"), Colors.red.shade500);
        expect(colorByName("red100"), Colors.red.shade100);
        expect(colorByName("red50"), Colors.red.shade50);
      });

      test('accented colors without shade', () {
        expect(colorByName("redAccent"), Colors.redAccent.shade200);
      });

      test('accented colors with shade', () {
        expect(colorByName("redAccent200"), Colors.redAccent.shade200);
        expect(colorByName("redAccent50"), Colors.redAccent.shade50);
      });

      test('black shades', () {
        expect(colorByName("black"), Colors.black);
        expect(colorByName("black12"), Colors.black12);
      });

      test('white shades', () {
        expect(colorByName("white"), Colors.white);
        expect(colorByName("white10"), Colors.white10);
      });
    });

    group('should return null', () {
      test('for strings resembling a color name', () {
        expect(colorByName("notAColor"), isNull);
      });

      test('for strings not resembling a color name', () {
        expect(colorByName("č"), isNull);
      });

      test('for invalid shades', () {
        expect(colorByName("red1000"), isNull);
        expect(colorByName("redAccent500"), isNull);
      });
    });
  });
}
