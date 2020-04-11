import 'package:flutter/material.dart';

import '../../constants.dart';

class TopicCounter extends StatelessWidget {
  const TopicCounter({
    Key key,
    @required this.value,
    @required this.foregroundColor,
    this.alignment,
  }) : super(key: key);

  final String value;
  final Color foregroundColor;
  final Alignment alignment;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: alignment,
      padding: EdgeInsets.all(5),
      child: Text(
        value,
        style: TextStyle(fontSize: K_FONT_SIZE_SMALL, fontWeight: FontWeight.w400, color: foregroundColor),
        textAlign: TextAlign.center,
      ),
    );
  }
}