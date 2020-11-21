import 'package:act_draw_explain/analytics.dart';
import 'package:flutter/material.dart';
import 'package:preferences/preference_service.dart';
import 'package:provider/provider.dart';

import '../../../../constants.dart';

class BrushSizeButton extends StatelessWidget {
  final Function onPressed;
  final double size;

  const BrushSizeButton({
    Key key,
    @required this.onPressed,
    @required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      color: Colors.white,
      minWidth: 0,
      padding: EdgeInsets.all(28 - (size / 2)),
      child: Container(
        height: size,
        width: size,
        decoration: BoxDecoration(color: Colors.black87, shape: BoxShape.circle),
      ),
      shape: CircleBorder(side: BorderSide(width: 2.0, color: Colors.black87)),
    );
  }
}

class BrushSizeDialog extends StatelessWidget {
  static List<double> brushSizes = [1.0, 2.0, 4.0, 8.0, 16.0, 32.0];
  final Function(double) onChange;

  const BrushSizeDialog({
    Key key,
    @required this.onChange,
  }) : super(key: key);

  Widget buildButton(BuildContext context, double size) {
    return Center(
      child: BrushSizeButton(
        onPressed: () {
          PrefService.setDouble(K.settings.game.brushSize.key, size);
          Provider.of<Analytics>(context, listen: false).brushSizeChoice(size);
          this.onChange(size);
          Navigator.of(context).pop();
        },
        size: size,
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
          children: brushSizes.map((size) => buildButton(context, size)).toList(),
        ),
      ),
    );
  }
}
