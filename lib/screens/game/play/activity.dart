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
import 'package:act_draw_explain/widgets/progress_button.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
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
  Duration gameDuration;

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
          locale: Localizations.localeOf(context),
          onNextQuestion: (newQuestion) {
            setState(() {
              questionText = newQuestion;
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
    scoreController.nextQuestion(passed: passed);

    if (scoreController.hasMoreQuestions) answerColorAnimation.startAnimation(passed);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: backgroundColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              if (gameDuration.inSeconds > 0)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    CountdownText(
                      onFinished: scoreController?.endGame,
                      duration: gameDuration,
                      style: Theme.of(context).textTheme.headline4,
                    ),
                  ],
                ),
              Expanded(
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: AutoSizeText(
                          questionText,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headline2,
                          minFontSize: Theme.of(context).textTheme.headline5.fontSize,
                          wrapWords: false,
                          maxLines: 4,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: <Widget>[
                  ProgressButton(
                    title: S.of(context).button_answer_correct,
                    iconData: Icons.thumb_up,
                    color: K_COLOR_PASS,
                    value: true,
                    onPressed: nextQuestion,
                    key: Key("answer_correct"),
                  ),
                  ProgressButton(
                    title: S.of(context).button_answer_wrong,
                    iconData: Icons.thumb_down,
                    color: K_COLOR_FAIL,
                    value: false,
                    onPressed: nextQuestion,
                    key: Key("answer_wrong"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
