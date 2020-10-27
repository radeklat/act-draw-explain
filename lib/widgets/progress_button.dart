import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProgressButton extends StatelessWidget {
  final String title;
  final IconData iconData;
  final Color color;
  final Function(bool) onPressed;
  final bool value;
  final AutoSizeGroup buttonsGroup;

  const ProgressButton({
    Key key,
    @required this.title,
    @required this.iconData,
    @required this.color,
    @required this.onPressed,
    this.value,
    this.buttonsGroup,
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
              AutoSizeText(
                title,
                maxFontSize: Theme.of(context).textTheme.button.fontSize,
                minFontSize: Theme.of(context).textTheme.bodyText1.fontSize,
                presetFontSizes: [24, 21, 18, 16],
                textAlign: TextAlign.center,
                maxLines: 2,
                wrapWords: false,
                group: buttonsGroup,
              ),
            ],
          ),
        ),
        onPressed: () {
          onPressed(value);
        },
      ),
    );
  }
}
