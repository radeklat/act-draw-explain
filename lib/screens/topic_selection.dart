import 'package:act_draw_explain/analytics.dart';
import 'package:act_draw_explain/generated/l10n.dart';
import 'package:act_draw_explain/models/game.dart';
import 'package:act_draw_explain/models/topic.dart';
import 'package:act_draw_explain/utilities/device_info.dart';
import 'package:act_draw_explain/utilities/urls.dart';
import 'package:act_draw_explain/widgets/topic/card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import 'about.dart';
import 'help.dart';
import 'settings.dart';

class TopicSelectionScreen extends StatelessWidget {
  static const String ID = "topic_selection_screen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).name),
        actions: <Widget>[
          AppBarPopupMenu(
            key: Key("popup_menu"),
          ),
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
              children: GameData.enabledTopics(Localizations.localeOf(context).languageCode)
                  .map((Topic topic) => TopicCard(topic: topic, key: Key("topic_card_${topic.id}")))
                  .toList(),
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

  void openFeedback(BuildContext context, FeedbackType feedbackType) async {
    String deviceInfo = await collectDeviceInfo();
    // TODO: Download template from the repo, replace a placeholder and pre-fill with:
    openUrl(context, K.url.feedback[feedbackType]); // + "&body=" + Uri.encodeComponent(deviceInfo));
    Navigator.pop(context, "");
    Clipboard.setData(ClipboardData(text: deviceInfo));
    Fluttertoast.showToast(
      msg: S.of(context).feedback_device_info_msg,
      timeInSecForIosWeb: 5,
    );
    Provider.of<Analytics>(context, listen: false).userFeedback(feedbackType);
  }

  Future<void> chooseFeedback(BuildContext context) async {
    await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: Text(
            S.of(context).menu_feedback,
          ),
          children: <Widget>[
            SimpleDialogOption(
              onPressed: () {
                openFeedback(context, FeedbackType.feature);
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(S.of(context).menu_feedback_feature, style: Theme.of(context).textTheme.bodyText1),
              ),
            ),
            SimpleDialogOption(
              onPressed: () {
                openFeedback(context, FeedbackType.bug);
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(S.of(context).menu_feedback_bug_report, style: Theme.of(context).textTheme.bodyText1),
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
        if (screenID == "feedback") {
          chooseFeedback(context);
        } else {
          Navigator.pushNamed(context, screenID);
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        PopupMenuItem<String>(
            value: SettingsScreen.ID, child: Text(S.of(context).menu_settings), key: Key("popup_menu_settings")),
        PopupMenuItem<String>(value: HelpScreen.ID, child: Text(S.of(context).menu_help), key: Key("popup_menu_help")),
        PopupMenuItem<String>(
          value: "feedback",
          child: Text(S.of(context).menu_feedback),
          key: Key("popup_menu_feedback"),
        ),
        PopupMenuItem<String>(
            value: AboutScreen.ID, child: Text(S.of(context).menu_about), key: Key("popup_menu_about")),
      ],
    );
  }
}
