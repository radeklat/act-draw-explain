import 'package:act_draw_explain/analytics.dart';
import 'package:act_draw_explain/constants.dart';
import 'package:act_draw_explain/data/topics.dart';
import 'package:act_draw_explain/utilities/urls.dart';
import 'package:act_draw_explain/widgets/text.dart';
import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:provider/provider.dart';

class AboutScreen extends StatefulWidget {
  static const String ID = "about_screen";

  @override
  _AboutScreenState createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  String appVersion = "";

  @override
  void initState() {
    super.initState();
    PackageInfo.fromPlatform().then(
      (packageInfo) => setState(() {
        appVersion = packageInfo.version;
      }),
    );
  }

  List<Widget> sources() {
    List<String> allHosts = [];

    topics.values.forEach(
      (topic) => allHosts.addAll(
        topic.sources.map(
          (url) => Uri.parse(url).host.replaceFirst("www.", ""),
        ),
      ),
    );

    return allHosts.toSet().map((host) => TextBodyLink(text: host, url: "http://$host/")).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            TextCard(
              children: <Widget>[
                TextTitle("Verze aplikace"),
                TextSubtitle(appVersion),
                TextBodyLink(
                  text: "seznam změn",
                  url: "${K.url.changelog}#$appVersion",
                  baseStyle: Theme.of(context).textTheme.headline6,
                )
              ],
            ),
            TextCard(
              children: <Widget>[
                TextTitle("Použité zdroje"),
                TextSubtitle("Balíčky"),
                ...sources(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
