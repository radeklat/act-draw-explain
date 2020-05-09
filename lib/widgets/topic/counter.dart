import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';

class TopicCounter extends StatelessWidget {
  const TopicCounter({
    Key key,
    @required this.valueTop,
    @required this.valueBottom,
    @required this.foregroundColor,
    this.alignment,
  }) : super(key: key);

  final String valueTop;
  final String valueBottom;
  final Color foregroundColor;
  final Alignment alignment;

  @override
  Widget build(BuildContext context) {
    final TextStyle style =
        Theme.of(context).textTheme.overline.copyWith(fontWeight: FontWeight.w400, color: foregroundColor);
    return Container(
      alignment: alignment,
      padding: EdgeInsets.all(5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            child: Text(valueTop, style: style),
          ),
          Container(
            padding: EdgeInsets.only(top: 2),
            decoration: BoxDecoration(
              border: Border(top: BorderSide(color: foregroundColor, width: 1)),
            ),
            child: Text(valueBottom, style: style),
          ),
        ],
      ),
    );
  }
}
