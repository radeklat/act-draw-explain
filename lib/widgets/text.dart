import 'dart:ui';

import 'package:act_draw_explain/utilities/urls.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../analytics.dart';

class TextCard extends StatelessWidget {
  final List<Widget> children;

  const TextCard({
    Key key,
    this.children,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: children),
      ),
    );
  }
}

class TextTitle extends StatelessWidget {
  final String text;

  const TextTitle(this.text, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 0, bottom: 16),
      child: Text(text, style: Theme.of(context).textTheme.headline5.copyWith(color: Theme.of(context).accentColor)),
    );
  }
}

class TextSubtitle extends StatelessWidget {
  final String text;

  const TextSubtitle(this.text, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 4, bottom: 8),
      child: Text(text, style: Theme.of(context).textTheme.headline6),
    );
  }
}

class TextBody1 extends StatelessWidget {
  final String text;

  const TextBody1(this.text, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(text, style: Theme.of(context).textTheme.bodyText1),
    );
  }
}

class TextBodyLink extends StatelessWidget {
  final String text;
  final String url;
  final TextStyle baseStyle;

  const TextBodyLink({Key key, @required this.text, @required this.url, this.baseStyle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle style = baseStyle ?? Theme.of(context).textTheme.bodyText1;
    style = style.copyWith(color: Colors.lightBlue);

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: InkWell(
        child: Text(text, style: style),
        onTap: () {
          openUrl(context, url);
          Provider.of<Analytics>(context, listen: false).clickedLink(url);
        },
      ),
    );
  }
}

class TextButton extends StatelessWidget {
  final Function onPressed;
  final String text;

  const TextButton({Key key, this.onPressed, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: MaterialButton(
        color: Theme.of(context).buttonColor,
        onPressed: onPressed,
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
        child: Text(text, style: Theme.of(context).textTheme.button),
      ),
    );
  }
}
