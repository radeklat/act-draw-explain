import 'package:flutter/material.dart';

class OneButtonInfoScreen extends StatelessWidget {
  final String text;
  final String buttonText;
  final Function onPressed;

  const OneButtonInfoScreen({
    Key key,
    @required this.text,
    @required this.buttonText,
    @required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Flexible(
                    child: Text(
                      text,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline4,
                      key: Key((key as ValueKey).value + "_text"),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              MaterialButton(
                color: Theme.of(context).buttonColor,
                onPressed: onPressed,
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                key: Key((key as ValueKey).value + "_button"),
                child: Text(
                  buttonText,
                  style: Theme.of(context).textTheme.button,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
