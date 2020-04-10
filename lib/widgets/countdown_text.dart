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

  @override
  void initState() {
    super.initState();
    totalSeconds = widget.duration.inSeconds;
    remainingSeconds = totalSeconds;

    animationController = AnimationController(
      duration: widget.duration,
      vsync: this,
      upperBound: totalSeconds.toDouble(),
    );
    animationController.addListener(() {
      setState(() {
        remainingSeconds = animationController.value.toInt() + 1;
      });
    });

    animationController
      ..reverse(from: totalSeconds.toDouble())
      ..addStatusListener((status) {
        if (status == AnimationStatus.dismissed) {
          widget.onFinished();
        }
      });
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      remainingSeconds.toString(),
      style: TextStyle(fontSize: K_FONT_SIZE_NORMAL),
    );
  }
}
