import 'dart:collection';
import 'dart:io';

import 'package:xml/xml.dart';

const String ASSETS_DIR = "assets/data";
const String DISABLED_TRANSLATION = "DISABLED";
const String TYPE_QUESTIONS = "questions";
const String TYPE_TOPICS = "topics";
const Map<int, String> LEVEL_TO_PADDING_CHAR = {1: "#", 2: "=", 3: "-"};

printHeading(String text, {int level = 1}) {
  int columns = (stdout.hasTerminal) ? stdout.terminalColumns : 120;
  int paddingLength = ((columns - text.length - 2) / 2).floor();
  String paddingChar = LEVEL_TO_PADDING_CHAR[level]??" ";
  String paddingLeft = "".padLeft(paddingLength, paddingChar);
  String paddingRight = "".padLeft(paddingLength + (text.length % 2), paddingChar);
  print("\n$paddingLeft $text $paddingRight\n");
}

Future<XmlDocument> loadXliffAsset(String type, [String locale = ""]) async {
  if (locale != "") {
    locale = "/$locale";
  }
  var filename = '$ASSETS_DIR/$type$locale.xliff';
  return XmlDocument.parse(await File("${Directory.current.path}/$filename").readAsString());
}

injectCategoryNames() async {
  printHeading("Injecting category names into `file` of questions");

  HashMap topicIdToName = HashMap();

  var topicsXml = await loadXliffAsset("topics");
  topicsXml.findAllElements("trans-unit").forEach((XmlElement topicXml) {
    topicIdToName[topicXml.getAttribute("id")] = topicXml.findAllElements("source").single.text;
  });

  Directory("${Directory.current.path}/$ASSETS_DIR/$TYPE_QUESTIONS").listSync(followLinks: false).forEach(
    (FileSystemEntity questionFile) async {
      if (questionFile is File) {
        String fileName = questionFile.path.split(Platform.pathSeparator).last;
        String languageCode = fileName.replaceAll(".xliff", "");
        print(' * Updating "$languageCode" $TYPE_QUESTIONS');

        var questionsXml = await loadXliffAsset(TYPE_QUESTIONS, languageCode);
        questionsXml.findAllElements("file").forEach((fileXml) {
          fileXml.getAttributeNode("category")!.value = topicIdToName[fileXml.getAttribute("original")] ?? "";
        });

        questionFile.writeAsString(questionsXml.toXmlString());
      }
    },
  );
}

injectDisabled() {
  printHeading("Injecting 'DISABLED' as `target` into questions for disabled language variants");

  Directory("${Directory.current.path}/$ASSETS_DIR/$TYPE_TOPICS").listSync(followLinks: false).forEach(
    (FileSystemEntity topicsFile) async {
      if (topicsFile is File) {
        String fileName = topicsFile.path.split(Platform.pathSeparator).last;
        String languageCode = fileName.replaceAll(".xliff", "");
        print(' * Updating "$languageCode" $TYPE_QUESTIONS');

        var topicsXml = await loadXliffAsset(TYPE_TOPICS, languageCode);
        Set<String> disabledTopicIDs = {};
        topicsXml.findAllElements("trans-unit").forEach((XmlElement topicXml) {
          if (topicXml.findAllElements("target").single.text == DISABLED_TRANSLATION) {
            disabledTopicIDs.add(topicXml.getAttribute("id")!);
          }
        });

        if (disabledTopicIDs.isNotEmpty) {
          var questionsXml = await loadXliffAsset(TYPE_QUESTIONS, languageCode);
          disabledTopicIDs.forEach((String topicID) {
            questionsXml.findAllElements("file").forEach((fileXml) {
              if (disabledTopicIDs.contains(fileXml.getAttribute("original"))) {
                fileXml.findAllElements("target").forEach((targetXml) {
                  (targetXml.descendants.single as XmlText).text = DISABLED_TRANSLATION;
                });
              }
            });
          });
          File(
            "${Directory.current.path}/$ASSETS_DIR/$TYPE_QUESTIONS/$languageCode.xliff",
          ).writeAsString(questionsXml.toXmlString());
        }
      }
    },
  );
}

listFreeIDs() {
  printHeading("List of free IDs");

  [TYPE_TOPICS, TYPE_QUESTIONS].forEach((fileType) async {
    Set<int> seenIDs = {};
    int maxID = 0;
    var documentXml = await loadXliffAsset(fileType);
    documentXml.findAllElements("trans-unit").forEach((topic) {
      var id = int.parse(topic.getAttribute("id")!);
      seenIDs.add(id);
      if (id > maxID) maxID = id;
    });
    var freeIDs = ({for (var i = 1; i <= maxID; i += 1) i}).difference(seenIDs).toList();

    printHeading(fileType, level: 2);
    if (freeIDs.isNotEmpty) {
      print("Free IDs out of sequence: ${freeIDs.join(", ")}");
    }
    print("First free sequential ID: ${maxID + 1}");
  });
}

List<int> _range(XmlElement xmlRange) {
  int min = int.parse(xmlRange.getAttribute("min")!);
  int max = int.parse(xmlRange.getAttribute("max")!);
  return [for (var i = min; i <= max; i += 1) i];
}
RegExp _idRegExp = RegExp(r"[0-9]+");

listTopics() async {
  printHeading("List of packages in topics");

  var topicsXml = await loadXliffAsset(TYPE_TOPICS);
  topicsXml.findAllElements("trans-unit").forEach((topic) {
    var id = int.parse(topic.getAttribute("id")!);
    printHeading("Package ID $id", level: 2);
    topic.findAllElements("package-ids").forEach((package) {
      var level = package.getAttribute("level");
      var visible = (package.getAttribute("visible") == "false") ? ", hidden" : "";
      Set<int> IDs = Set();
      package.descendants.forEach((XmlNode xmlQuestionIDsItem) {
        if (xmlQuestionIDsItem is XmlElement) {
          if (xmlQuestionIDsItem.name.local == "list") {
            IDs.addAll(_idRegExp.allMatches(xmlQuestionIDsItem.text).map((match) => int.parse(match.group(0)!)));
          } else if (xmlQuestionIDsItem.name.local == "range") {
            IDs.addAll(_range(xmlQuestionIDsItem));
          }
        }
      });

      print(" * Level $level: ${IDs.length} questions$visible");
    });
  });
}

main() async {
  await injectCategoryNames();
  await listTopics();
  injectDisabled();
  listFreeIDs();
}
