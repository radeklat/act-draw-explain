import 'package:flutter/material.dart';

import '../constants.dart';

class ProgressButton extends StatelessWidget {
  final String title;
  final IconData iconData;
  final Color color;
  final Function(bool) onPressed;
  final bool value;

  const ProgressButton({
    Key key,
    @required this.title,
    @required this.iconData,
    @required this.color,
    @required this.onPressed,
    this.value
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FlatButton(
        child: Column(
          children: <Widget>[
            Icon(
              iconData,
              color: color,
              size: 50,
            ),
            Text(
              title,
              style: TextStyle(fontSize: K_FONT_SIZE_NORMAL, color: K_COLOR_FONT_PRIMARY),
            ),
          ],
        ),
        onPressed: () {onPressed(value);},
      ),
    );
  }
}