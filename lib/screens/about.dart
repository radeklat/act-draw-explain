import 'package:act_draw_explain/analytics.dart';
import 'package:act_draw_explain/constants.dart';
import 'package:act_draw_explain/utilities/urls.dart';
import 'package:act_draw_explain/widgets/text.dart';
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
                TextButton(
                  text: "seznam změn",
                  onPressed: () {
                    openUrl(context, "${K.url.changelog}#$appVersion");
                    Provider.of<Analytics>(context, listen: false).openedChangelog();
                  },
                )
              ],
            ),
            TextCard(
              children: <Widget>[
                TextTitle("Použité zdroje"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
