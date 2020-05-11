import 'package:act_draw_explain/data/game.dart';
import 'package:act_draw_explain/data/topics.dart';
import 'package:act_draw_explain/widgets/topic/card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants.dart';
import 'help.dart';
import 'settings.dart';

class TopicSelectionScreen extends StatelessWidget {
  static const String ID = "topic_selection_screen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Act, Draw, Explain"),
        actions: <Widget>[
          AppBarPopupMenu(),
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: GridView.extent(
              padding: EdgeInsets.all(16),
              maxCrossAxisExtent: 150,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              children: [
                ...game.topicIDs.map((topicID) => TopicCard(topic: topics[topicID])).toList()
              ], //AddTopicCard()],
            ),
          ),
        ],
      ),
    );
  }
}

class AppBarPopupMenu extends StatelessWidget {
  const AppBarPopupMenu({
    Key key,
  }) : super(key: key);

  void openChangelog(context) async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String url = "$CHANGELOG_URL#${packageInfo.version}";

    if (await canLaunch(url)) {
      launch(url);
    } else {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text("Nelze otevřít vychozí webový problížeč."),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      onSelected: (String screenID) async {
        if (screenID == "changelog") {
          openChangelog(context);
        } else {
          Navigator.pushNamed(context, screenID);
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        PopupMenuItem<String>(value: SettingsScreen.ID, child: Text("Nastavení")),
        PopupMenuItem<String>(value: HelpScreen.ID, child: Text("Nápověda")),
        PopupMenuItem<String>(value: "changelog", child: Text("Seznam změn")),
      ],
    );
  }
}
