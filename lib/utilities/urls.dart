import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void openUrl(BuildContext context, String url) async {
  if (await canLaunch(url)) {
    launch(url);
  } else {
    Scaffold.of(context).showSnackBar(SnackBar(content: Text("Nelze otevřít vychozí webový problížeč.")));
  }
}