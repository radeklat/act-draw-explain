import 'package:flutter/material.dart';

class ProgressButton extends StatelessWidget {
  final String title;
  final IconData iconData;
  final Color color;
  final Function onPressed;

  const ProgressButton({
    Key key,
    @required this.title,
    @required this.iconData,
    @required this.color,
    @required this.onPressed,
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
              style: TextStyle(fontSize: 21),
            ),
          ],
        ),
        onPressed: onPressed,
      ),
    );
  }
}