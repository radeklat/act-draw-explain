import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CrashScreen extends StatelessWidget {
  final FlutterErrorDetails details;

  const CrashScreen({this.details});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "This is embarrassing.\nApplication crashed :(",
                    style: TextStyle(fontSize: 32)
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 16),
                    child: Text("Report has been sent to the developers."),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
