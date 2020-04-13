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

      Question(id: 21, text: "Zvonařka"),
      Question(id: 22, text: "Dolní nádraží"),
      Question(id: 23, text: "Orloj na Moravském náměstí"),
      Question(id: 24, text: "Fontána před Janáčkovým divadlem"),
      Question(id: 25, text: "Mahenovo divadlo"),
      Question(id: 26, text: "Vozovna Medlánky"),
      Question(id: 27, text: "Přehrada"),
      Question(id: 28, text: "Moulin Rogue"),
      Question(id: 29, text: "Denisovy sady"),
      Question(id: 30, text: "Brněnské podzemí"),
      Question(id: 31, text: "Kostnice pod kotelem sv. Jakuba"),
      Question(id: 32, text: "Cejl"),
      Question(id: 33, text: "Myší díra"),
      Question(id: 34, text: "Zelňák"),
      Question(id: 35, text: "Pod hodinami"),
      Question(id: 36, text: "Socha Jošta"),
      Question(id: 37, text: "U Kapucínů"),
      Question(id: 38, text: "Moravák"),
      Question(id: 39, text: "Vaňkovka"),
      Question(id: 40, text: "Katedrála svatých Petra a Pavla"),
      Question(id: 41, text: "Hrad Špilbek"),
      Question(id: 42, text: "Pekařská"),
      Question(id: 43, text: "Červený kostel"),
      Question(id: 44, text: "Jakubské náměstí"),
      Question(id: 45, text: "Lužánky"),
      Question(id: 46, text: "Vila Tugendhat"),
      Question(id: 47, text: "Slovaňák"),
      Question(id: 48, text: "Semilasso"),
      Question(id: 49, text: "Listovky"),

      Question(id: 50, text: "Hra o trůny"),
      Question(id: 51, text: "Willow / Buffy, přemožitelka upírů"),
      Question(id: 52, text: "Melrose Place"),
      Question(id: 53, text: "Coal / Čarodějky"),
      Question(id: 54, text: "Esmeralda"),
      Question(id: 55, text: "Phoebe / Přátelé"),
      Question(id: 56, text: "Tak jde čas"),
      Question(id: 57, text: "M*A*S*H"),
      Question(id: 58, text: "Mulder a Scullyová"),
      Question(id: 59, text: "Jak jsem poznal vaši matku"),
      Question(id: 60, text: "Brandon Walsh / Beverly Hills 90210"),
      Question(id: 61, text: "Dr. Zoidberg / Futurama"),
      Question(id: 62, text: "Lala / Teletubbies"),
      Question(id: 63, text: "Kryten / Červený trpaslík"),
      Question(id: 64, text: "Sheldon / Teorie velkého třesku"),
//      Question(id: 65, text: ""),
//      Question(id: 66, text: ""),
//      Question(id: 67, text: ""),
//      Question(id: 68, text: ""),
//      Question(id: 69, text: ""),
    ],
    key: (question) => question.id,
    value: (question) => question,
  ),
);
