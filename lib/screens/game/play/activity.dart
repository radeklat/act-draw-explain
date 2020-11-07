import 'package:act_draw_explain/analytics.dart';
import 'package:act_draw_explain/animations/answer_color.dart';
import 'package:act_draw_explain/constants.dart';
import 'package:act_draw_explain/controllers/score.dart';
import 'package:act_draw_explain/generated/l10n.dart';
import 'package:act_draw_explain/models/game/new.dart';
import 'package:act_draw_explain/models/results.dart';
import 'package:act_draw_explain/screens/game/end_game.dart';
import 'package:act_draw_explain/utilities/orientation.dart';
import 'package:act_draw_explain/widgets/countdown_text.dart';
import 'package:act_draw_explain/widgets/empty_app_bar.dart';
import 'package:act_draw_explain/widgets/progress_button.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:preferences/preference_service.dart';
import 'package:provider/provider.dart';
import 'package:wakelock/wakelock.dart';

class ActivityScreen extends StatefulWidget {
  static const String ID = "activity_screen";
  final NewGame newGame;

  const ActivityScreen({Key key, @required this.newGame}) : super(key: key);

  @override
  _ActivityScreenState createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> with SingleTickerProviderStateMixin {
  ScoreController scoreController;
  AnswerColorAnimation answerColorAnimation;

  Color backgroundColor = K_COLOR_BACKGROUND;
  String questionText = "";
  Activity activity;
  Duration gameDuration;
  bool questionVisible = true;
  Stopwatch stopwatch = Stopwatch();

  @override
  void initState() {
    super.initState();

    Wakelock.enable();
    setPreferredOrientationPortrait();

    gameDuration = Duration(
      seconds: PrefService.getInt(K.settings.game.duration.key) ?? K.settings.game.duration.defaultValue,
    );

    answerColorAnimation = AnswerColorAnimation(
      vsync: this,
      listener: (newColor) {
        setState(() {
          backgroundColor = newColor;
        });
      },
    );

    // `Localizations.localeOf(context).languageCode` is not available directly in initState
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        scoreController = ScoreController(
          topic: widget.newGame.topic,
          activities: widget.newGame.activities,
          locale: Localizations.localeOf(context),
          onNextQuestion: (newQuestion, activity) {
            setState(() {
              questionText = newQuestion;
              this.activity = activity;
            });
          },
          logQuestion: (topic, question, duration, state) => Provider.of<Analytics>(context, listen: false)
              .playedQuestion(topic, question, duration, state, gameDuration),
          onGameEnd: (gameResult) {
            Provider.of<Analytics>(context, listen: false).playedGame(widget.newGame.topic, gameDuration, gameResult);
            Navigator.pushReplacementNamed(context, EndGameScreen.ID, arguments: gameResult);
          },
          setNewScore: (newScore) {
            Provider.of<TopicBestScore>(context, listen: false)
                .record(topicID: widget.newGame.topic.id, newScore: newScore);
          },
          maxQuestions: int.parse(
              PrefService.getString(K.settings.game.cardsCount.key) ?? "${K.settings.game.cardsCount.defaultValue}"),
        );
      });
      stopwatch.start();
    });
  }

  @override
  void dispose() {
    Wakelock.disable();
    setPreferredOrientationsAll();
    answerColorAnimation?.dispose();
    super.dispose();
  }

  void nextQuestion(bool passed) {
    setState(() {
      questionVisible = true;
    });
    scoreController.nextQuestion(passed: passed);

    if (scoreController.hasMoreQuestions) answerColorAnimation.startAnimation(passed);
  }

  Color get primaryColor {
    switch (activity) {
      case Activity.act:
        return Colors.teal[800];
      case Activity.draw:
        return Colors.deepPurple[800];
      case Activity.explain:
        return Colors.red[800];
    }

    return null;
  }

  Color get secondaryColor {
    switch (activity) {
      case Activity.act:
        return Colors.greenAccent[400];
      case Activity.draw:
        return Colors.purple[500];
      case Activity.explain:
        return Colors.amber[700];
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    if (activity == null) {
      return Scaffold();
    }

    AutoSizeGroup buttonsGroup = AutoSizeGroup();
    String middleButtonText;
    IconData middleButtonIcon;

    if (activity == Activity.draw) {
      middleButtonText = (questionVisible) ? "Draw" : "Question";
      middleButtonIcon = (questionVisible) ? Icons.brush : Icons.font_download_outlined;
    } else {
      middleButtonText = (questionVisible) ? S.of(context).button_question_hide : S.of(context).button_question_show;
      middleButtonIcon = (questionVisible) ? Icons.visibility_off : Icons.visibility;
    }

    return Scaffold(
      appBar: EmptyAppBar(backgroundColor: primaryColor),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, stops: [
              0,
              0.35,
              0.5,
              0.5,
              1
            ], colors: [
              primaryColor,
              secondaryColor.withOpacity(0.22),
              secondaryColor.withOpacity(0),
              K_COLOR_BACKGROUND.withOpacity(0),
              backgroundColor
            ]),
          ),
//          color: backgroundColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Builder(
                builder: (context) {
                  if (activity == Activity.draw && questionVisible == false) {
                    return PaintWidget(
                      countdownText: CountdownText(
                        onFinished: scoreController?.endGame,
                        stopwatch: stopwatch,
                        duration: gameDuration,
                        style: Theme.of(context).textTheme.headline4.copyWith(color: Colors.white),
                      ),
                    );
                  }

                  return QuestionWidget(
                    activity: activity,
                    countdownText: CountdownText(
                      onFinished: scoreController?.endGame,
                      stopwatch: stopwatch,
                      duration: gameDuration,
                      style: Theme.of(context).textTheme.headline4.copyWith(color: Colors.white),
                    ),
                    questionText: questionText,
                    questionVisible: questionVisible,
                  );
                },
              ),
              Container(
                decoration: BoxDecoration(boxShadow: kElevationToShadow[8], color: Theme.of(context).bottomAppBarColor),
                child: Row(
                  children: <Widget>[
                    ProgressButton(
                      title: S.of(context).button_answer_correct,
                      iconData: Icons.thumb_up,
                      color: K_COLOR_PASS,
                      value: true,
                      onPressed: nextQuestion,
                      key: Key("answer_correct"),
                      buttonsGroup: buttonsGroup,
                    ),
                    ProgressButton(
                      title: middleButtonText,
                      iconData: middleButtonIcon,
                      color: Colors.black54,
                      value: questionVisible,
                      onPressed: (hideQuestion) {
                        setState(() {
                          questionVisible = !questionVisible;
                        });
                      },
                      key: Key("toggle_visibility"),
                      buttonsGroup: buttonsGroup,
                    ),
                    ProgressButton(
                      title: S.of(context).button_answer_wrong,
                      iconData: Icons.thumb_down,
                      color: K_COLOR_FAIL,
                      value: false,
                      onPressed: nextQuestion,
                      key: Key("answer_wrong"),
                      buttonsGroup: buttonsGroup,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class QuestionWidget extends StatelessWidget {
  const QuestionWidget({
    Key key,
    @required this.activity,
    @required this.countdownText,
    @required this.questionVisible,
    @required this.questionText,
  }) : super(key: key);

  final Activity activity;
  final CountdownText countdownText;
  final bool questionVisible;
  final String questionText;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ActivityIcon(activity: activity),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: ActivityIcon.SIZE / 2),
                child: Text(
                  activityToName(activity, S.of(context)),
                  style: Theme.of(context).textTheme.headline4.copyWith(color: Colors.white),
                ),
              ),
              ActivityIcon(activity: activity, reversed: true),
            ],
          ),
          if (countdownText != null)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[countdownText],
            ),
          if (questionVisible)
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: AutoSizeText(
                      questionText,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline4,
                      minFontSize: Theme.of(context).textTheme.headline5.fontSize,
                      wrapWords: false,
                      maxLines: 4,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class PaintWidget extends StatelessWidget {
  const PaintWidget({
    Key key,
    @required this.countdownText,
  }) : super(key: key);

  final CountdownText countdownText;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.only(left: 16),
                  child: countdownText,
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: MaterialButton(
                        onPressed: () {},
                        color: Colors.blue,
                        padding: EdgeInsets.all(24),
                        minWidth: 0,
                        shape: CircleBorder(side: BorderSide(width: 2.0, color: Colors.black87)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: MaterialButton(
                        onPressed: () {},
                        color: Colors.white,
                        minWidth: 0,
                        padding: EdgeInsets.all(20),
                        child: Container(
                          height: 8,
                          width: 8,
                          decoration: BoxDecoration(color: Colors.black87, shape: BoxShape.circle),
                        ),
                        shape: CircleBorder(side: BorderSide(width: 2.0, color: Colors.black87)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 0, right: 16),
                      child: MaterialButton(
                        onPressed: () {},
                        color: Colors.white,
                        minWidth: 0,
                        child: Icon(
                          Icons.delete,
                          size: 24.0,
                        ),
                        padding: EdgeInsets.all(12),
                        shape: CircleBorder(),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(left: 8, right: 8, bottom: 8),
              decoration: BoxDecoration(color: Colors.white, border: Border.all(color: Colors.black54, width: 2.0)),
            ),
          )
        ],
      ),
    );
  }
}

class ActivityIcon extends StatelessWidget {
  const ActivityIcon({
    Key key,
    @required this.activity,
    this.reversed = false,
  }) : super(key: key);

  final Activity activity;
  final bool reversed;

  static const double SIZE = 40.0;

  @override
  Widget build(BuildContext context) {
    String reversed = (this.reversed) ? "-reversed" : "";
    return Image.asset(
      'assets/activity_icons/${describeEnum(activity)}$reversed.png',
      height: SIZE,
    );
  }
}
