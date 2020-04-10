import 'package:flutter/material.dart';

import '../constants.dart';

class CountdownText extends StatefulWidget {
  const CountdownText({Key key, @required this.duration, @required this.onFinished}) : super(key: key);

  final Duration duration;
  final Function onFinished;

  @override
  _CountdownTextState createState() => _CountdownTextState();
}

class _CountdownTextState extends State<CountdownText> with SingleTickerProviderStateMixin {
  AnimationController animationController;
  int totalSeconds;
  int remainingSeconds;

  void configureAnimation() {
    if (totalSeconds == null && widget.duration != null) {
      totalSeconds = widget.duration.inSeconds;
      remainingSeconds = totalSeconds;

      animationController = AnimationController(
        duration: widget.duration,
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
  }

  @override
  void initState() {
    super.initState();
    configureAnimation();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    configureAnimation();
    return Text(
      remainingSeconds.toString(),
      style: TextStyle(fontSize: K_FONT_SIZE_NORMAL),
    );
  }
}
