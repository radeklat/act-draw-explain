import 'dart:collection';

import 'package:act_draw_explain/models/question.dart';

UnmodifiableMapView<int, Question> questions = UnmodifiableMapView(
  Map.fromIterable(
    [
      Question(id: 1, text: "Emanuel"),
      Question(id: 2, text: "Mrazík"),
      Question(id: 3, text: "Hurvínek"),
      Question(id: 4, text: "Rákosníček"),
      Question(id: 5, text: "Bob A Bobek"),
      Question(id: 6, text: "Sněhurka"),
      Question(id: 7, text: "Krteček"),
      Question(id: 8, text: "Pat a Mat"),
      Question(id: 9, text: "Pejsek a Kočička"),
      Question(id: 10, text: "Spejbl"),
      Question(id: 11, text: "Ferda Mravenec"),
      Question(id: 12, text: "Večerníček"),
      Question(id: 13, text: "Včelka Mája"),
      Question(id: 14, text: "Bolek a Lolek"),
      Question(id: 15, text: "Večernice"),
      Question(id: 16, text: "Křemílek a Vochomurka"),
      Question(id: 17, text: "Víla Amálka"),
      Question(id: 18, text: "Krakonoš"),
      Question(id: 19, text: "Jeníček a Mařenka"),
      Question(id: 20, text: "Rumcajs"),
    ],
    key: (question) => question.id,
    value: (question) => question,
  ),
);
