import 'package:act_draw_explain/generated/l10n.dart';
import 'package:act_draw_explain/models/game/new.dart';
import 'package:act_draw_explain/widgets/countdown_text.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import 'activity_icon.dart';

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