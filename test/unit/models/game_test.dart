// Import the test package and Counter class
import 'package:act_draw_explain/models/game.dart';
import 'package:flutter/material.dart';
import 'package:test/test.dart';

import '../../mock_data.dart';

void main() {
  group('Game', () {
    test('should initialize data', () async {
      WidgetsFlutterBinding.ensureInitialized();
      await GameData.initialize(LocalAssetLoader());
      expect(GameData.questions, isNotEmpty);
      expect(GameData.topics, isNotEmpty);
    });
  });
}
