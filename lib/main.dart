import 'package:act_draw_explain/constants.dart';
import 'package:act_draw_explain/screens/game/end_game.dart';
import 'package:act_draw_explain/screens/game/play/countdown.dart';
import 'package:act_draw_explain/screens/game/play/explain.dart';
import 'package:act_draw_explain/screens/game/start_game.dart';
import 'package:act_draw_explain/screens/help.dart';
import 'package:act_draw_explain/screens/settings.dart';
import 'package:act_draw_explain/screens/topic_selection.dart';
import 'package:flutter/material.dart';
import 'package:preferences/preferences.dart';


main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PrefService.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Act, Draw, Explain',
      theme: ThemeData(
        primaryColor: K_COLOR_FAIL,
        accentColor: Colors.pinkAccent,
        backgroundColor: K_COLOR_BACKGROUND,
        buttonColor: Colors.pinkAccent,

        // http://spencermortensen.com/articles/typographic-scale/
        textTheme: TextTheme(
          display1: TextStyle(fontSize: 192, color: Colors.black87),
          display2: TextStyle(fontSize: 96, color: Colors.black87),
          display3: TextStyle(fontSize: 48, color: Colors.black87),
          display4: TextStyle(fontSize: 36, color: Colors.black87),
          title: TextStyle(fontSize: 30, color: Colors.pink.shade700),
          subtitle: TextStyle(fontSize: 21, color: Colors.pink.shade600),
          body1: TextStyle(fontSize: 16),
          button: TextStyle(fontSize: 24, color: Colors.white),
          overline: TextStyle(fontSize: 12, letterSpacing: 0),
        ),
      ),
      initialRoute: TopicSelectionScreen.ID,
      onGenerateRoute: (settings) {
        final arguments = settings.arguments;
        return MaterialPageRoute(
          settings: RouteSettings(name: settings.name),
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
              case CountdownScreen.ID:
                return CountdownScreen(topicID: arguments);
              case SettingsScreen.ID:
                return SettingsScreen();
              case HelpScreen.ID:
                return HelpScreen();
            }
            return null;
          },
        );
      },
    );
  }
}
