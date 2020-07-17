import 'dart:io';
import 'dart:ui';

import 'package:act_draw_explain/models/translation_file.dart';
import 'package:act_draw_explain/utilities/intl.dart';
import 'package:mockito/mockito.dart';

/// Loads files from local filesystem
class LocalAssetLoader extends AssetLoader {
  String get rootFolder {
    String pwd = Directory.current.path;
    // Command line starts tests in the `test` directory, AndroidStudio in repo root
    return (pwd.endsWith("test")) ? Directory.current.parent.path : pwd;
  }

  Future<String> loadString(String type, [String locale]) async {
    return await File("$rootFolder/${languageFile(type, locale)}").readAsString();
  }

  List<Locale> get supportedLocales {
    return Directory("$rootFolder/${AssetLoader.ASSETS_DIR}/topics")
        .listSync(followLinks: false)
        .where((element) => element is File)
        .map(
          (file) => localeFromString(
            file.path.split(Platform.pathSeparator).last.replaceAll(".xliff", ""),
          ),
        )
        .toList();
  }
}

class MockAssetLoader extends Mock implements AssetLoader {}
