import 'package:act_draw_explain/constants.dart';
import 'package:act_draw_explain/controllers/score.dart';
import 'package:act_draw_explain/models/results.dart';
import 'package:act_draw_explain/screens/game/end_game.dart';
import 'package:act_draw_explain/screens/game/play/countdown.dart';
import 'package:act_draw_explain/screens/game/play/explain.dart';
import 'package:act_draw_explain/screens/game/start_game.dart';
import 'package:act_draw_explain/screens/help.dart';
import 'package:act_draw_explain/screens/settings.dart';
import 'package:act_draw_explain/screens/topic_edit.dart';
import 'package:act_draw_explain/screens/topic_selection.dart';
import 'package:act_draw_explain/utilities/vibrations.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:preferences/preferences.dart';
import 'package:provider/provider.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

// To enable Analytics Debug mode on an emulated Android device, execute the following command line:
//    adb shell setprop debug.firebase.analytics.app sk.lat.act_draw_explain
// This behavior persists until you explicitly disable Debug mode by executing the following command line:
//    adb shell setprop debug.firebase.analytics.app .none.
FirebaseAnalytics analytics = FirebaseAnalytics();

main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Crashlytics.instance.enableInDevMode = false;  // Pass all uncaught errors from the framework to Crashlytics.
  FlutterError.onError = Crashlytics.instance.recordFlutterError;

  await PrefService.init();
  GameVibrations.init();
  GameSounds.init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<TopicBestScore>(create: (_) => TopicBestScore()),
      ],
      child: MaterialApp(
//        debugShowCheckedModeBanner: false,
        title: 'Act, Draw, Explain',
        theme: AppTheme,
        initialRoute: TopicSelectionScreen.ID,
        navigatorObservers: [
          FirebaseAnalyticsObserver(analytics: analytics),
        ],
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
                case TopicEditScreen.ID:
                  return TopicEditScreen(topicID: arguments);
                case SettingsScreen.ID:
                  return SettingsScreen();
                case HelpScreen.ID:
                  return HelpScreen();
              }
              return null;
            },
          );
        },
      ),
    );
  }
}
