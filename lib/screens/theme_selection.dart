import 'package:act_draw_explain/data/game.dart';
import 'package:act_draw_explain/data/topics.dart';
import 'package:act_draw_explain/widgets/topic_card.dart';
import 'package:flutter/material.dart';

class ThemeSelectionScreen extends StatelessWidget {
  static const String ID = "theme_selection_screen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: GridView.builder(
            padding: EdgeInsets.all(20),
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 150,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
            ),
            itemBuilder: (context, index) => TopicCard(topic: topics[game.topicIDs[index]]),
            itemCount: game.topicIDs.length,
          ),
        ),
      ),
    );
  }
}


