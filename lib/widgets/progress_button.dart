import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Icon(
                iconData,
                color: color,
                size: 50,
              ),
              Text(title),
            ],
          ),
        ),
        onPressed: () {onPressed(value);},
      ),
    );
  }
}