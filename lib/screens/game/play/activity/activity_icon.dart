import 'package:act_draw_explain/models/game/new.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

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