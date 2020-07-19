// Import the test package and Counter class
import 'dart:collection';

import 'package:act_draw_explain/constants.dart';
import 'package:act_draw_explain/models/question.dart';
import 'package:act_draw_explain/models/topic.dart';
import 'package:act_draw_explain/models/translation_file.dart';
import 'package:flutter/material.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:xml/xml.dart';

import '../../utils/game_data.dart';

const String MOCK_DUPLICATE_TOPIC_XLIFF = """
  <?xml version='1.0' encoding='UTF-8'?>
  <xliff version="1.2"><file original="game topics"><body>
    <trans-unit id="4" color="amber" icon="movie">
      <question-ids><list>81</list></question-ids><source>Top 20 IMDB Movies</source>
    </trans-unit>
    <trans-unit id="4" color="amber" icon="movie">
      <question-ids><list>81</list></question-ids><source>Top 20 IMDB Movies</source>
    </trans-unit>
  </body></file></xliff>
""";

void main() {
  group('TranslationsLoader', () {
    test('should fail to load duplicate items', () async {
      WidgetsFlutterBinding.ensureInitialized();
      var assetLoader = MockAssetLoader();
      when(assetLoader.loadString("assets/data/topics.xliff"))
          .thenAnswer((_) => Future.value(MOCK_DUPLICATE_TOPIC_XLIFF));
      var loader = TranslationsLoader([K.settings.locales.defaultValue], assetLoader);
      HashMap<int, Question> questions = HashMap.from({81: Question(baseText: "mock question", id: 81)});

      expect(
        () async {
          await loader.load(
            "topics",
            (XmlElement xmlTopic) => Topic.fromXmlElement(questions, xmlTopic),
            LocalizedItem.idFromXmlElement,
          );
        },
        throwsA(isA<AssertionError>()),
      );
    });
  });
}
