// Import the test package and Counter class
import 'package:act_draw_explain/models/game/data.dart';
import 'package:flutter/material.dart';
import 'package:test/test.dart';

import '../../utils/game_data.dart';

void main() {
  group('Game', () {
    test('should initialize data', () async {
      WidgetsFlutterBinding.ensureInitialized();
      var loader = LocalAssetLoader();
      await GameData.initialize(loader.supportedLocales, loader);
      expect(GameData.questions, isNotEmpty);
      expect(GameData.topics, isNotEmpty);
    });
  });
}
