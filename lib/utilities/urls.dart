import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

void openUrl(BuildContext context, String url) async {
  if (await canLaunchUrlString(url)) {
    launchUrlString(url);
  } else {
    // TODO: Translate
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Nelze otevřít vychozí webový problížeč.")));
  }
}