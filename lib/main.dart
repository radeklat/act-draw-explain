import 'package:act_draw_explain/screens/end_game.dart';
import 'package:act_draw_explain/screens/game/explain.dart';
import 'package:act_draw_explain/screens/start_game.dart';
import 'package:act_draw_explain/screens/topic_selection.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Act, Draw, Explain',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: TopicSelectionScreen.ID,
      onGenerateRoute: (settings) {
        final arguments = settings.arguments;
        return MaterialPageRoute(
          builder: (context) {
            switch (settings.name) {
              case ExplainScreen.ID:
                return ExplainScreen(topicID: arguments);
              case StartGameScreen.ID:
                return StartGameScreen(topicID: arguments);
              case TopicSelectionScreen.ID:
                return TopicSelectionScreen();
              case EndGameScreen.ID:
                return EndGameScreen(lastGameResult: arguments);
            }
            return null;
          },
        );
      },
    );
  }
}
