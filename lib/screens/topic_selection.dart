import 'package:act_draw_explain/data/game.dart';
import 'package:act_draw_explain/data/topics.dart';
import 'package:act_draw_explain/utilities/device_info.dart';
import 'package:act_draw_explain/widgets/topic/card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
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

  void openUrl(BuildContext context, String url) async {
    if (await canLaunch(url)) {
      launch(url);
    } else {
      Scaffold.of(context).showSnackBar(SnackBar(content: Text("Nelze otevřít vychozí webový problížeč.")));
    }
  }

  void openChangelog(BuildContext context) async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    openUrl(context, "${K.url.changelog}#${packageInfo.version}");
  }

  void openFeedback(context, url) async {
    String deviceInfo = await collectDeviceInfo();
    // TODO: Download template from the repo, replace a placeholder and pre-fill with:
    openUrl(context, url); // + "&body=" + Uri.encodeComponent(deviceInfo));
    Navigator.pop(context, "");
    Clipboard.setData(ClipboardData(text: deviceInfo));
    Fluttertoast.showToast(
        msg: "Informace o zařízení zkopírována do schránky.",
        timeInSecForIosWeb: 5,
    );
  }

  Future<void> chooseFeedback(BuildContext context) async {
    await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: Text(
            'Zpětná vazba',
          ),
          children: <Widget>[
            SimpleDialogOption(
              onPressed: () {
                openFeedback(context, K.url.featureRequest);
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text('Návrh na vylepšení', style: Theme.of(context).textTheme.bodyText1),
              ),
            ),
            SimpleDialogOption(
              onPressed: () {
                openFeedback(context, K.url.bugReport);
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text('Nahlásit chybu', style: Theme.of(context).textTheme.bodyText1),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      onSelected: (String screenID) async {
        if (screenID == "changelog") {
          openChangelog(context);
        } else if (screenID == "feedback") {
          chooseFeedback(context);
        } else {
          Navigator.pushNamed(context, screenID);
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        PopupMenuItem<String>(value: SettingsScreen.ID, child: Text("Nastavení")),
        PopupMenuItem<String>(value: HelpScreen.ID, child: Text("Nápověda")),
        PopupMenuItem<String>(value: "feedback", child: Text("Zpětná vazba")),
        PopupMenuItem<String>(value: "changelog", child: Text("Seznam změn")),
      ],
    );
  }
}
