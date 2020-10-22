import 'package:act_draw_explain/constants.dart';
import 'package:act_draw_explain/generated/l10n.dart';
import 'package:act_draw_explain/models/game/data.dart';
import 'package:act_draw_explain/widgets/text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';

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

    GameData.topics.values.forEach(
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
                TextTitle(S.of(context).about_title_version),
                TextSubtitle(appVersion),
                TextBodyLink(
                  text: S.of(context).about_changelog_link,
                  url: "${K.url.changelog}#$appVersion",
                  baseStyle: Theme.of(context).textTheme.headline6,
                )
              ],
            ),
            TextCard(
              children: <Widget>[
                TextTitle(S.of(context).about_sources_title),
                TextSubtitle(S.of(context).about_packages_title),
                ...sources(),
              ],
            ),
            TextCard(
              children: <Widget>[
                TextTitle(S.of(context).about_licenses_title
                ),
                MaterialButton(
                  child: Text(
                    S.of(context).about_licenses_button,
                    style: Theme.of(context).textTheme.headline6.copyWith(color: Colors.lightBlue),
                  ),
                  onPressed: () => showLicensePage(context: context, applicationVersion: appVersion),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
