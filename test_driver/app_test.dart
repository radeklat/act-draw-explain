// Imports the Flutter Driver API.
import 'dart:io';
import 'dart:math';

import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

Random random = Random();

void main() {
  int total = 20;

  group('FEATURE: Finish game play when all card are guessed in time limit |', () {
    FlutterDriver driver;
    int score = 0;

    // Connect to the Flutter driver before running any tests.
    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    // Close the connection to the driver after the tests have completed.
    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });

    test('GIVEN I choose topic ID 1', () async {
      await driver.tap(find.byValueKey("topic_card_1"));
    });

    test('AND I start the game', () async {
      await driver.tap(find.byValueKey("start_game_button"), timeout: Duration(milliseconds: 500));
    });

    test('AND I wait for the countdown', () async {
      sleep(Duration(seconds: 5));
    });

    test('WHEN I answer questions randomly', () async {
      while (true) {
        bool pass = random.nextBool();
        score += (pass) ? 1 : 0;
        try {
          await driver.tap(
            find.byValueKey((pass) ? "answer_correct" : "answer_wrong"),
            timeout: Duration(seconds: 2),
          );
        } catch (DriverError) {
          print("No more buttons to click. Assuming end of game.");
          break;
        }
      }
    });

    test('THEN I should see appropriate score', () async {
      String scoreText = await driver.getText(find.byValueKey("end_game_text"));
      assert (scoreText.endsWith("$score/$total"));
    });

    test('AND be able to go back to list of topics', () async {
      await driver.tap(find.byValueKey("end_game_button"));
      assert(find.byValueKey("topic_card_1") != null);
    });
  });

  group('FEATURE: Finish game play by timeout |', () {
    FlutterDriver driver;

    // Connect to the Flutter driver before running any tests.
    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    // Close the connection to the driver after the tests have completed.
    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });

    test('GIVEN I choose topic ID 1', () async {
      await driver.tap(find.byValueKey("topic_card_1"));
    });

    test('AND I start the game', () async {
      await driver.tap(find.byValueKey("start_game_button"), timeout: Duration(milliseconds: 500));
    });

    test('AND I wait for the countdown', () async {
      sleep(Duration(seconds: 5));
    });

    test('WHEN I answer first question right', () async {
      await driver.tap(find.byValueKey("answer_correct"), timeout: Duration(seconds: 2));
    });

    test('AND I wait until the end of the game', () async {
      sleep(Duration(seconds: 90));
    });

    test('THEN I should see appropriate score', () async {
      String scoreText = await driver.getText(find.byValueKey("end_game_text"));
      assert (scoreText.endsWith("1/$total"));
    });

    test('AND be able to go back to list of topics', () async {
      await driver.tap(find.byValueKey("end_game_button"));
      assert(find.byValueKey("topic_card_1") != null);
    });
  });
}
