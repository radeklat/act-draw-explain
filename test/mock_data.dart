import 'dart:io';

import 'package:act_draw_explain/models/translation_file.dart';
import 'package:mockito/mockito.dart';

/// Loads files from local filesystem
class LocalAssetLoader extends AssetLoader {
  Future<String> loadString(filename) async {
    String pwd = Directory.current.path;
    if (pwd.endsWith("test")) {
      // Command line starts tests in the `test` directory, AndroidStudio in repo root
      pwd = Directory.current.parent.path;
    }
    return await File("$pwd/$filename").readAsString();
  }
}

class MockAssetLoader extends Mock implements AssetLoader {}
