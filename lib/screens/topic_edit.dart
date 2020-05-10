import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TopicEditScreen extends StatelessWidget {
  static const String ID = "topic_edit_screen";

  final int topicID;

  const TopicEditScreen({Key key, this.topicID}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 32, top: 32, right: 32, bottom: 32),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  IconPlaceholder(),
                  SizedBox(width: 16),
                  ColorPicker(),
                ],
              ),
            ),
            ListTile(
              contentPadding: EdgeInsets.only(left: 32, top: 0, right: 32, bottom: 32),
              title: TextField(
                decoration: InputDecoration(
                  labelText: "Název",
                  labelStyle: TextStyle(color: Colors.black),
                  focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                  alignLabelWithHint: true,
                ),
                textAlign: TextAlign.center,
                autofocus: true,
                style: Theme.of(context).textTheme.headline5.copyWith(fontWeight: FontWeight.normal),
              ),
            ),
            ListTile(
              contentPadding: EdgeInsets.only(left: 32, top: 0, right: 32, bottom: 8),
              title: Text(
                "Otázky",
                style: Theme.of(context).textTheme.headline5.copyWith(fontWeight: FontWeight.normal),
              ),
              trailing: IconButton(
                icon: Icon(
                  Icons.add,
                  size: 32,
                ),
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class IconPlaceholder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 100,
      decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.grey.shade300),
      child: Center(
        child: Text(
          "Ikona",
          style: Theme.of(context).textTheme.button.copyWith(fontWeight: FontWeight.normal, color: Colors.black),
        ),
      ),
    );
  }
}


class ColorPicker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.color_lens, color: Colors.grey.shade600,),
      iconSize: 32,
      onPressed: () {},
    );
  }
}