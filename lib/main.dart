import 'dart:async';
import 'dart:io';

import 'package:act_draw_explain/constants.dart';
import 'package:act_draw_explain/models/results.dart';
import 'package:act_draw_explain/screens/about.dart';
import 'package:act_draw_explain/screens/crash.dart';
import 'package:act_draw_explain/screens/game/end_game.dart';
import 'package:act_draw_explain/screens/game/play/countdown.dart';
import 'package:act_draw_explain/screens/game/play/explain.dart';
import 'package:act_draw_explain/screens/game/start_game.dart';
import 'package:act_draw_explain/screens/help.dart';
import 'package:act_draw_explain/screens/settings.dart';
import 'package:act_draw_explain/screens/topic_selection.dart';
import 'package:act_draw_explain/utilities/intl/languages.dart';
import 'package:act_draw_explain/utilities/logging.dart';
import 'package:act_draw_explain/utilities/vibrations.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:preferences/preferences.dart';
import 'package:provider/provider.dart';

import 'analytics.dart';
import 'generated/l10n.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Crashlytics.instance.enableInDevMode = false; // Pass all uncaught errors from the framework to Crashlytics.
  FlutterError.onError = (details) {
    Zone.current.handleUncaughtError(details.exception, details.stack);
    Crashlytics.instance.recordFlutterError(details);
  };
  ErrorWidget.builder = (FlutterErrorDetails details) => CrashScreen(details: details);
  await PrefService.init();
  await GameVibrations.init();
  Logger.logLevel = (kReleaseMode) ? Logger.WARNING : Logger.DEBUG;
  Logger.blacklist = {"TiltEvent.other", "TiltEvent.movement", "TiltEvent.detection"};

  runZoned(() {
    runApp(MyApp());
  }, onError: Crashlytics.instance.recordError);
}

class MyApp extends StatefulWidget {
  // To enable Analytics Debug mode on an emulated Android device, execute the following command line:
  //    adb shell setprop debug.firebase.analytics.app sk.lat.act_draw_explain.debug
  // This behavior persists until you explicitly disable Debug mode by executing the following command line:
  //    adb shell setprop debug.firebase.analytics.app .none.
  static FirebaseAnalytics analytics = FirebaseAnalytics();
  static FirebaseAnalyticsObserver observer = FirebaseAnalyticsObserver(analytics: analytics);
  static AppLocalizationDelegate localizationsDelegate = AppLocalizationDelegate();

  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState state = context.findAncestorStateOfType<_MyAppState>();

    // ignore: invalid_use_of_protected_member
    state.setState(() {
      state.locale = newLocale;
    });
  }

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale locale;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<TopicBestScore>(create: (_) => TopicBestScore()),
        Provider<Analytics>(create: (_) => Analytics(MyApp.analytics)),
        Provider<FirebaseAnalyticsObserver>.value(value: MyApp.observer),
      ],
      child: MaterialApp(
//        debugShowCheckedModeBanner: false,
        locale: locale ?? languageCodeOnlyLocaleFromString(Platform.localeName),
        supportedLocales: MyApp.localizationsDelegate.supportedLocales,
        localizationsDelegates: [
          MyApp.localizationsDelegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        localeResolutionCallback: (Locale deviceLocale, Iterable<Locale> supportedLocales) {
          Locale requestedLocale = this.locale ??
              languageCodeOnlyLocaleFromString(
                PrefService.getString(K.settings.languageCode.key) ?? deviceLocale.toString(),
              );

          if (localeLanguageCodeIn(requestedLocale, supportedLocales)) {
            return requestedLocale;
          }

          return Locale(K.settings.languageCode.defaultValue);
        },
        onGenerateTitle: (BuildContext context) => S.of(context).name,
        theme: appTheme,
        initialRoute: TopicSelectionScreen.ID,
        navigatorObservers: <NavigatorObserver>[MyApp.observer],
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
                  return SettingsScreen(
                    supportedLocales: MyApp.localizationsDelegate.supportedLocales,
                  );
                case HelpScreen.ID:
                  return HelpScreen();
                case AboutScreen.ID:
                  return AboutScreen();
              }
              return null;
            },
          );
        },
      ),
    );
  }
}
