import 'dart:ui';

import 'package:act_draw_explain/analytics.dart';
import 'package:act_draw_explain/screens/game/play/activity/brush_size.dart';
import 'package:act_draw_explain/widgets/countdown_text.dart';
import 'package:flutter/material.dart';
import 'package:preferences/preference_service.dart';
import 'package:provider/provider.dart';

import '../../../../constants.dart';
import 'brush_color.dart';

// Based on https://ptyagicodecamp.github.io/building-cross-platform-finger-painting-app-in-flutter.html

//Class to define a point touched at canvas
class TouchPoints {
  Paint paint;
  Offset points;

  TouchPoints({this.points, this.paint});
}

class TouchPointsChangeNotifier extends ChangeNotifier {
  final List<TouchPoints> points = [];
  bool _modified = false;

  bool get modified {
    return _modified;
  }

  void add(TouchPoints touchPoints) {
    points.add(touchPoints);
    _modified = true;
    notifyListeners();
  }

  void clear() {
    points.clear();
    notifyListeners();
  }
}

class MyPainter extends CustomPainter {
  MyPainter({this.pointsList});

  //Keep track of the points tapped on the screen
  List<TouchPoints> pointsList;
  List<Offset> offsetPoints = List();

  //This is where we can draw on canvas.
  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 0; i < pointsList.length - 1; i++) {
      if (pointsList[i] != null && pointsList[i + 1] != null) {
        //Drawing line when two consecutive points are available
        canvas.drawLine(pointsList[i].points, pointsList[i + 1].points, pointsList[i].paint);
      } else if (pointsList[i] != null && pointsList[i + 1] == null) {
        offsetPoints.clear();
        offsetPoints.add(pointsList[i].points);
        offsetPoints.add(Offset(pointsList[i].points.dx + 0.1, pointsList[i].points.dy + 0.1));

        //Draw points when two points are not next to each other
        canvas.drawPoints(PointMode.points, offsetPoints, pointsList[i].paint);
      }
    }
  }

  //Called when CustomPainter is rebuilt.
  //Returning true because we want canvas to be rebuilt to reflect new changes.
  @override
  bool shouldRepaint(MyPainter oldDelegate) => true;
}

class PaintWidget extends StatefulWidget {
  const PaintWidget({
    Key key,
    @required this.countdownText,
  }) : super(key: key);

  final CountdownText countdownText;

  @override
  _PaintWidgetState createState() => _PaintWidgetState();
}

class _PaintWidgetState extends State<PaintWidget> {
  double opacity = 1.0;
  StrokeCap strokeType = StrokeCap.round;
  double strokeWidth = PrefService.getDouble(K.settings.game.brushSize.key) ?? K.settings.game.brushSize.defaultValue;
  Color selectedColor = Color(
    PrefService.getInt(K.settings.game.brushColor.key) ?? K.settings.game.brushColor.defaultValue,
  );

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.only(left: 16),
                  child: widget.countdownText,
                ),
                Row(
                  children: [
                    BrushColorButton(
                      color: selectedColor,
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return BrushColorDialog(
                              onChange: (newColor) {
                                setState(() {
                                  selectedColor = newColor;
                                });
                              },
                            );
                          },
                        );
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: BrushSizeButton(
                        size: strokeWidth,
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return BrushSizeDialog(
                                onChange: (newSize) {
                                  setState(() {
                                    strokeWidth = newSize;
                                  });
                                },
                              );
                            },
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 0, right: 16),
                      child: MaterialButton(
                        onPressed: () {
                          Provider.of<Analytics>(context, listen: false).clearCanvas();
                          Provider.of<TouchPointsChangeNotifier>(context, listen: false).clear();
                        },
                        color: Colors.white,
                        minWidth: 0,
                        child: Icon(
                          Icons.delete,
                          size: 24.0,
                        ),
                        padding: EdgeInsets.all(12),
                        shape: CircleBorder(),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 8, right: 8, bottom: 8),
              child: Container(
                decoration: BoxDecoration(color: Colors.white, border: Border.all(color: Colors.black54, width: 2.0)),
                child: ClipRect(
                  child: Builder(
                    builder: (context) {
                      return GestureDetector(
                        onPanDown: (details) {
                          RenderBox renderBox = context.findRenderObject();
                          Provider.of<TouchPointsChangeNotifier>(context, listen: false).add(
                            TouchPoints(
                              points: renderBox.globalToLocal(details.globalPosition),
                              paint: Paint()
                                ..strokeCap = strokeType
                                ..isAntiAlias = true
                                ..color = selectedColor.withOpacity(opacity)
                                ..strokeWidth = strokeWidth,
                            ),
                          );
                        },
                        onPanUpdate: (details) {
                          RenderBox renderBox = context.findRenderObject();
                          Provider.of<TouchPointsChangeNotifier>(context, listen: false).add(
                            TouchPoints(
                              points: renderBox.globalToLocal(details.globalPosition),
                              paint: Paint()
                                ..strokeCap = strokeType
                                ..isAntiAlias = true
                                ..color = selectedColor.withOpacity(opacity)
                                ..strokeWidth = strokeWidth,
                            ),
                          );
                        },
                        onPanEnd: (details) {
                          var touchPoints = Provider.of<TouchPointsChangeNotifier>(context, listen: false);
                          if (!touchPoints.modified) {
                            Provider.of<Analytics>(context, listen: false).paintCanvas();
                          }
                          touchPoints.add(null);
                        },
                        child: Consumer<TouchPointsChangeNotifier>(
                            builder: (_context, provider, _child) => CustomPaint(
                                  size: Size.infinite,
                                  painter: MyPainter(pointsList: provider.points),
                                )),
                      );
                    },
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
