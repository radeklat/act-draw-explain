import 'package:flutter/animation.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/scheduler.dart';

import '../constants.dart';

class AnswerColorAnimation {
  ColorTween _colorTween = ColorTween(end: K_COLOR_BACKGROUND);
  AnimationController _animationController;
  Animation _animation;
  Function(Color) listener;

  AnswerColorAnimation({@required TickerProvider vsync, @required this.listener}) {
    _animationController = AnimationController(
      duration: K_DURATION_PASS_FAIL_ANIMATION,
      vsync: vsync,
    )
      ..addListener(() {
        listener(_animation.value);
      });

    _animation = _colorTween.animate(_animationController);
  }

  void startAnimation(bool passed) {
    _colorTween.begin = (passed) ? K_COLOR_PASS : K_COLOR_FAIL;
    _animationController.forward(from: 0);
  }

  void dispose() {
    _animationController.dispose();
  }
}