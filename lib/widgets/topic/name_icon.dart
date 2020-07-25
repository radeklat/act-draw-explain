import 'package:act_draw_explain/models/topic.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: LayoutBuilder(
                builder: (context, constraint) => Icon(
                  topic.icon.icon,
                  size: constraint.biggest.height,
                  color: foregroundColor.withOpacity(0.8),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 5),
              child: Center(
                child: AutoSizeText(
                  topic.text(Localizations.localeOf(context)),
                  style: Theme.of(context).textTheme.button.copyWith(color: foregroundColor),
                  textAlign: TextAlign.center,
                  maxLines: 3,
                  minFontSize: Theme.of(context).textTheme.overline.fontSize,
                  overflow: TextOverflow.fade,
                  wrapWords: false,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}