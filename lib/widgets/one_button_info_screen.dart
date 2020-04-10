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
                      style: TextStyle(color: Colors.black87, fontSize: 48),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              MaterialButton(
                color: Colors.lightGreenAccent,
                onPressed: onPressed,
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                child: Text(
                  buttonText,
                  style: TextStyle(fontSize: 30),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
