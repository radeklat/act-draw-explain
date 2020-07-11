import 'dart:io';

import 'package:act_draw_explain/models/translation_file.dart';
import 'package:mockito/mockito.dart';

/// Loads files from local filesystem
class LocalAssetLoader extends AssetLoader {
  Future<String> loadString(filename) async {
    return await File(filename).readAsString();
  }
}

const String MOCK_TOPIC_XLIFF = """
<?xml version='1.0' encoding='UTF-8'?>
<xliff version="1.2">
  <file original="game topics">
    <body>
      <trans-unit id="4" color="amber" icon="movie">
        <attribution url="https://www.imdb.com/chart/top/?ref_=nv_mv_250"/>
        <question-ids>
          <range min="65" max="80"/>
          <list>81,82,83,84</list>
        </question-ids>
        <source>Top 20 IMDB Movies</source>
      </trans-unit>
    </body>
  </file>
</xliff>
""";

class MockAssetLoader extends Mock implements AssetLoader {}

MockAssetLoader getAssetLoader() {
  var assetLoader = MockAssetLoader();
  when(assetLoader.loadString("assets/data/topics.xliff")).thenAnswer((_) => Future.value(MOCK_TOPIC_XLIFF));

  return assetLoader;
}
