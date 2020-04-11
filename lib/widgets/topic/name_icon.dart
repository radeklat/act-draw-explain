import 'package:act_draw_explain/models/topic.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';

class TopicNameIcon extends StatelessWidget {
  const TopicNameIcon({
    Key key,
    @required this.foregroundColor,
    @required this.topic,
  }) : super(key: key);

  final Color foregroundColor;
  final Topic topic;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 200,
      padding: EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            topic.icon.icon,
            size: 50,
            color: foregroundColor.withOpacity(0.8),
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            constraints: BoxConstraints(maxHeight: 50),
            child: AutoSizeText(
              topic.name,
              style: TextStyle(fontSize: K_FONT_SIZE_NORMAL, fontWeight: FontWeight.w500, color: foregroundColor),
              textAlign: TextAlign.center,
              maxLines: 3,
              minFontSize: K_FONT_SIZE_SMALL,
              overflow: TextOverflow.fade,
            ),
          ),
        ],
      ),
    );
  }
}