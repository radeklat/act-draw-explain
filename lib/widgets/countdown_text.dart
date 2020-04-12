import 'package:flutter/material.dart';
import 'package:preferences/preference_service.dart';

import '../constants.dart';

class CountdownText extends StatefulWidget {
  const CountdownText({Key key, @required this.onFinished}) : super(key: key);

  final Function onFinished;

  @override
  _CountdownTextState createState() => _CountdownTextState();
}

class _CountdownTextState extends State<CountdownText> with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Duration duration;
  int totalSeconds;
  int remainingSeconds;
  bool disabled = false;

  @override
  void initState() {
    super.initState();
    duration = Duration(
      seconds: PrefService.getInt(K_SETTINGS_GAME_DURATION) ?? K_GAME_DURATION_DEFAULT,
    );

    if (duration.inSeconds == 0) {
      disabled = true;
      return;
    }

    totalSeconds = duration.inSeconds;
    remainingSeconds = totalSeconds;

    animationController = AnimationController(
      duration: duration,
      vsync: this,
      upperBound: totalSeconds.toDouble(),
    );
    animationController
      ..addListener(() {
        setState(() {
          remainingSeconds = animationController.value.toInt() + 1;
        });
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.dismissed) {
          widget.onFinished();
        }
      })
      ..reverse(from: totalSeconds.toDouble());
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      (disabled) ? "" : remainingSeconds.toString(),
      style: TextStyle(fontSize: K_FONT_SIZE_NORMAL),
    );
  }
}
