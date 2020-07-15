import 'dart:collection';
import 'dart:convert';
import 'dart:io';

import 'package:xml/xml.dart';
import 'package:xml2json/xml2json.dart';

const ASSETS_DIR = "assets/data";
const Map<int, String> LEVEL_TO_PADDING_CHAR = {1: "#", 2: "=", 3: "-"};

printHeading(String text, {int level = 1}) {
  int columns = (stdout.hasTerminal) ? stdout.terminalColumns : 120;
  int paddingLength = ((columns - text.length - 2) / 2).floor();
  String paddingChar = LEVEL_TO_PADDING_CHAR[level];
  String paddingLeft = "".padLeft(paddingLength, paddingChar);
  String paddingRight = "".padLeft(paddingLength + (text.length % 2), paddingChar);
  print("\n$paddingLeft $text $paddingRight\n");
}

Future<XmlDocument> loadXliffAsset(String type, [String locale]) async {
  locale = (locale == null) ? "" : "/$locale";
  var filename = '$ASSETS_DIR/$type$locale.xliff';
  return parse(await File("${Directory.current.path}/$filename").readAsString());
}

injectCategoryNames() async {
  printHeading("Injecting category names into `file` of questions");

  HashMap topicIdToName = HashMap();

  var topicsXml = await loadXliffAsset("topics");
  topicsXml.findAllElements("trans-unit").forEach((XmlElement topicXml) {
    topicIdToName[topicXml.getAttribute("id")] = topicXml.findAllElements("source").single.text;
  });

  Directory("${Directory.current.path}/$ASSETS_DIR/questions").listSync(followLinks: false).forEach(
    (FileSystemEntity questionFile) async {
      if (questionFile is File) {
        String fileName = questionFile.path.split(Platform.pathSeparator).last;
        String languageCode = fileName.replaceAll(".xliff", "");
        print(' * Updating "$languageCode" questions');

        var questionsXml = await loadXliffAsset("questions", languageCode);
        questionsXml.findAllElements("file").forEach((fileXml) {
          fileXml.getAttributeNode("category").value = topicIdToName[fileXml.getAttribute("original")] ?? "";
        });

        questionFile.writeAsString(questionsXml.toXmlString());
      }
    },
  );
}

injectDisabled() {
  printHeading("Injecting 'DISABLED' as `target` into questions for disabled language variants");


}

main() async {
  await injectCategoryNames();
  injectDisabled();
}
