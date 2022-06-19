import 'dart:async';

import 'package:act_draw_explain/controllers/score.dart';
import 'package:act_draw_explain/utilities/vibrations.dart';
import 'package:flutter/material.dart';
import 'package:act_draw_explain/utilities/duration.dart';

class CountdownText extends StatefulWidget {
  static Stopwatch get defaultStopwatch {
    Stopwatch stopwatch = Stopwatch();
    stopwatch.start();
    return stopwatch;
  }

  CountdownText({
    Key? key,
    required this.onFinished,
    required this.duration,
    required this.style,
    Stopwatch? stopwatch, // use external stopwatch if you want to keep the time in multiple components
  })  : this._stopwatch = (stopwatch == null) ? defaultStopwatch : stopwatch,
        this._externalStopwatch = (stopwatch != null),
        super(key: key);

  final Function onFinished;
  final Duration duration;
  final TextStyle style;
  final Stopwatch _stopwatch;
  final bool _externalStopwatch;

  @override
  _CountdownTextState createState() => _CountdownTextState();
}

class _CountdownTextState extends State<CountdownText> with SingleTickerProviderStateMixin {
  StreamSubscription? _stream;
  Duration? _remainingTime;
  bool _disabled = false;
  static GameSounds gameSounds = GameSounds();

  @override
  void initState() {
    super.initState();

    if (widget.duration.inSeconds == 0) {
      _disabled = true;
      return;
    }

    _remainingTime = (widget._externalStopwatch) ? this.newRemainingTime() : widget.duration;
    _stream = Stream.periodic(Duration(seconds: 1)).listen((_value) {
      Duration newRemainingTime = this.newRemainingTime();

      if (newRemainingTime.inSeconds < 1) {
        stop(isDisposing: false);
        newRemainingTime = Duration(seconds: 1);
      } else if (newRemainingTime.inSeconds <= 5) {
        GameVibrations.timerTick();
        gameSounds.timerTick();
      }

      setState(() {
        _remainingTime = newRemainingTime;
      });
    });
  }

  Duration newRemainingTime() {
    return widget.duration - widget._stopwatch.elapsed + Duration(seconds: 1);
  }

  void stop({required bool isDisposing}) {
    _stream?.cancel();

    if (!isDisposing) {
      widget._stopwatch.stop();
      setState(() {
        _stream = null;
      });
      widget.onFinished();
    }
  }

  @override
  void dispose() {
    stop(isDisposing: true);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      (_disabled || _remainingTime == null) ? "" : _remainingTime!.format(),
      style: widget.style,
    );
  }
}
