import 'package:act_draw_explain/data/game.dart';
import 'package:act_draw_explain/data/topics.dart';
import 'package:act_draw_explain/screens/settings.dart';
import 'package:act_draw_explain/widgets/topic_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class TopicSelectionScreen extends StatelessWidget {
  static const String ID = "topic_selection_screen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  SizedBox(
                    width: 48,
                  ),
                  Text(
                    "Act, Draw, Explain",
                    style: TextStyle(fontSize: K_FONT_SIZE_NORMAL),
                  ),
                  IconButton(
                    icon: Icon(Icons.settings, size: K_SIZE_ICON, color: K_COLOR_ICON),
                    onPressed: () {
                      Navigator.pushNamed(context, SettingsScreen.ID);
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: GridView.builder(
                padding: EdgeInsets.all(16),
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 150,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                ),
                itemBuilder: (context, index) => TopicCard(topic: topics[game.topicIDs[index]]),
                itemCount: game.topicIDs.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
