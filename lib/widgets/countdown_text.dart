import 'dart:async';

import 'package:flutter/material.dart';
import 'package:act_draw_explain/utilities/duration.dart';

class CountdownText extends StatefulWidget {
  const CountdownText({
    Key key,
    @required this.onFinished,
    @required this.duration,
    this.style,
  }) : super(key: key);

  final Function onFinished;
  final Duration duration;
  final TextStyle style;

  @override
  _CountdownTextState createState() => _CountdownTextState();
}

class _CountdownTextState extends State<CountdownText> with SingleTickerProviderStateMixin {
  StreamSubscription _stream;
  Stopwatch _stopwatch = Stopwatch();
  Duration _remainingTime;
  bool _disabled = false;

  @override
  void initState() {
    super.initState();

    if (widget.duration.inSeconds == 0) {
      _disabled = true;
      return;
    }

    _remainingTime = widget.duration;
    _stopwatch.start();
    _stream = Stream.periodic(Duration(seconds: 1)).listen((_value) {
      Duration newRemainingTime = widget.duration - _stopwatch.elapsed;

      if (newRemainingTime.inSeconds <= 0) {
        stop(isDisposing: false);
        newRemainingTime = Duration(seconds: 1);
      }

      setState(() {
        _remainingTime = newRemainingTime;
      });
    });
  }

  void stop({bool isDisposing}) {
    _stopwatch?.stop();
    _stream?.cancel();

    if (!isDisposing) {
      setState(() {
        _stopwatch = null;
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
      (_disabled) ? "" : _remainingTime.format(),
      style: widget.style,
    );
  }
}
