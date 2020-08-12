import 'package:flutter/material.dart';

class EmptyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Color backgroundColor;

  const EmptyAppBar({@required this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return Container(color: backgroundColor);
  }

  @override
  Size get preferredSize => Size(0.0, 0.0);
}