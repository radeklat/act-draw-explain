import 'package:act_draw_explain/analytics.dart';
import 'package:flutter/material.dart';
import 'package:preferences/preference_service.dart';
import 'package:provider/provider.dart';

import '../../../../constants.dart';

class BrushColorButton extends StatelessWidget {
  final Function onPressed;
  final Color color;

  const BrushColorButton({
    Key key,
    @required this.color,
    @required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: MaterialButton(
        onPressed: onPressed,
        color: color,
        padding: EdgeInsets.all(24),
        minWidth: 0,
        shape: CircleBorder(side: BorderSide(width: 2.0, color: Colors.black87)),
      ),
    );
  }
}

class BrushColorDialog extends StatelessWidget {
  static List<Color> colors = [
    Colors.black,
    Colors.grey,
    Colors.red,
    Colors.orange,
    Colors.yellow,
    Colors.lime,
    Colors.green,
    Colors.blue[200],
    Colors.blue,
    Colors.purple,
    Colors.pink[100],
    Colors.brown,
  ];
  final Function(Color) onChange;

  const BrushColorDialog({
    Key key,
    @required this.onChange,
  }) : super(key: key);

  Widget buildButton(BuildContext context, Color color) {
    return Center(
      child: BrushColorButton(
        onPressed: () {
          PrefService.setInt(K.settings.game.brushColor.key, color.value);
          Provider.of<Analytics>(context, listen: false).brushColorChoice(color);
          this.onChange(color);
          Navigator.of(context).pop();
        },
        color: color,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(color: Colors.black, offset: Offset(0, 10), blurRadius: 10)],
        ),
        child: GridView.count(
          padding: const EdgeInsets.all(32.0),
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          crossAxisCount: 3,
          shrinkWrap: true,
          children: colors.map((color) => buildButton(context, color)).toList(),
        ),
      ),
    );
  }
}
