import 'package:act_draw_explain/widgets/countdown_text.dart';
import 'package:flutter/material.dart';

class PaintWidget extends StatelessWidget {
  const PaintWidget({
    Key key,
    @required this.countdownText,
  }) : super(key: key);

  final CountdownText countdownText;

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
                  child: countdownText,
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: MaterialButton(
                        onPressed: () {},
                        color: Colors.blue,
                        padding: EdgeInsets.all(24),
                        minWidth: 0,
                        shape: CircleBorder(side: BorderSide(width: 2.0, color: Colors.black87)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: MaterialButton(
                        onPressed: () {},
                        color: Colors.white,
                        minWidth: 0,
                        padding: EdgeInsets.all(20),
                        child: Container(
                          height: 8,
                          width: 8,
                          decoration: BoxDecoration(color: Colors.black87, shape: BoxShape.circle),
                        ),
                        shape: CircleBorder(side: BorderSide(width: 2.0, color: Colors.black87)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 0, right: 16),
                      child: MaterialButton(
                        onPressed: () {},
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
            child: Container(
              margin: EdgeInsets.only(left: 8, right: 8, bottom: 8),
              decoration: BoxDecoration(color: Colors.white, border: Border.all(color: Colors.black54, width: 2.0)),
            ),
          )
        ],
      ),
    );
  }
}