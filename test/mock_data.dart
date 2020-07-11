import 'dart:io';

import 'package:act_draw_explain/models/translation_file.dart';
import 'package:mockito/mockito.dart';

/// Loads files from local filesystem
class LocalAssetLoader extends AssetLoader {
  Future<String> loadString(filename) async {
    return await File(filename).readAsString();
  }
}

class MockAssetLoader extends Mock implements AssetLoader {}
