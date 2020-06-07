import 'dart:collection';

import 'package:act_draw_explain/models/topic.dart';
import 'package:flutter/material.dart';

UnmodifiableListView<int> range(int min, int max, {List<int> extra}) {
  return UnmodifiableListView([for (var i = min; i <= max; i += 1) i, ...(extra ?? [])]);
}

UnmodifiableMapView<int, Topic> topics = UnmodifiableMapView(
  Map.fromIterable(
    [
      Topic(
        id: 2,
        name: "Brno",
        color: Colors.red,
        icon: Icon(Icons.location_city),
        questionIDs: range(21, 49, extra: [264, 265]),
      ),
      Topic(
        id: 1,
        name: "Pohádky",
        color: Colors.lightBlueAccent,
        icon: Icon(Icons.ac_unit),
        questionIDs: range(1, 20, extra: range(355, 384)),
      ),
      Topic(
        id: 3,
        name: "Zahraniční seriály",
        color: Colors.deepPurple,
        icon: Icon(Icons.tv),
        questionIDs: range(50, 64),
      ),
      Topic(
        id: 4,
        name: "IMDb Top 20 Movies",
        color: Colors.amber,
        icon: Icon(Icons.movie),
        questionIDs: range(65, 84),
      ),
      Topic(
        id: 5,
        name: "ČSFD Top 20 Filmů",
        color: Colors.redAccent,
        icon: Icon(Icons.tv),
        questionIDs: range(85, 103, extra: [76]),
      ),
      Topic(
        id: 6,
        name: "ČSFD Top 20 Seriálů",
        color: Colors.redAccent,
        icon: Icon(Icons.tv),
        questionIDs: range(105, 124),
      ),
      Topic(
        id: 7,
        name: "RuPaul's Drag Race",
        color: Colors.pinkAccent,
        icon: Icon(Icons.looks),
        questionIDs: range(125, 172, extra: [435, 436, 901, 902, 903, 1109, 1110, 1111, 1112, 1113, 1114, 1115]),
      ),
      Topic(
          id: 8,
          name: "Top Android Apps",
          color: Colors.green,
          icon: Icon(Icons.android),
          questionIDs: range(173, 201),
          sources: ["https://play.google.com/store/apps/top?hl=en_GB"]),
      Topic(
        id: 9,
        name: "Praha",
        color: Colors.amberAccent,
        icon: Icon(Icons.location_city),
        questionIDs: range(202, 240),
      ),
      Topic(
        id: 10,
        name: "České památky",
        color: Colors.blue,
        icon: Icon(Icons.account_balance),
        questionIDs: range(241, 263, extra: [41, 46, 203, 204, 207, 221]),
      ),
      Topic(
          id: 11,
          name: "Čeští interpreti",
          color: Colors.purpleAccent,
          icon: Icon(Icons.music_note),
          questionIDs: range(266, 302),
          sources: ["http://www.zpev.hlasujpro.cz/zpevacky.html"]),
      Topic(
          id: 12,
          name: "Čeští herci a herečky",
          color: Colors.lime,
          icon: Icon(Icons.theaters),
          questionIDs: range(303, 342, extra: [292, 302]),
          sources: ["http://www.herec.hlasujpro.cz"]),
      Topic(
        id: 13,
        name: "Prezidenti ČR a ČS",
        color: Colors.yellow,
        icon: Icon(Icons.person),
        questionIDs: range(343, 353),
      ),
      Topic(
        id: 14,
        name: "Státy Evropy",
        color: Colors.blueAccent,
        icon: Icon(Icons.public),
        questionIDs: range(385, 434),
      ),
      Topic(
          id: 15,
          name: "National dishes",
          color: Colors.brown,
          icon: Icon(Icons.restaurant),
          questionIDs: range(437, 503),
          sources: ["https://en.wikipedia.org/wiki/National_dish#By_country"]),
      Topic(
        id: 16,
        name: "Nejlépe placení herci",
        color: Colors.amber,
        icon: Icon(Icons.star),
        questionIDs: range(504, 548),
      ),
      Topic(
        id: 17,
        name: "Nejlépe placení hudebníci",
        color: Colors.lightGreenAccent,
        icon: Icon(Icons.headset),
        questionIDs: range(550, 589),
      ),
      Topic(
        id: 18,
        name: "Nejkrásnější města ČR",
        color: Colors.pinkAccent,
        icon: Icon(Icons.location_city),
        questionIDs: range(591, 628, extra: [243]),
      ),
      Topic(
        id: 19,
        name: "Společenské hry",
        color: Colors.lightBlue,
        icon: Icon(Icons.extension),
        questionIDs: range(629, 649),
      ),
      Topic(
          id: 20,
          name: "Umělecké styly",
          color: Colors.tealAccent,
          icon: Icon(Icons.palette),
          questionIDs: range(650, 674),
          sources: ["https://cs.wikipedia.org/wiki/Kategorie:Um%C4%9Bleck%C3%A9_sm%C4%9Bry"]),
      Topic(
          id: 21,
          name: "Sporty",
          color: Colors.purple,
          icon: Icon(Icons.pool),
          questionIDs: range(675, 751, extra: [919, 955, 973, 980, 981, 983, 989, 991, 996, 1000, 1010, 1028]),
          sources: [
            "https://cs.wikipedia.org/wiki/Seznam_olympijsk%C3%BDch_sport%C5%AF",
            "https://cs.wikipedia.org/wiki/Abecedn%C3%AD_seznam_sportovn%C3%ADch_discipl%C3%ADn",
          ]),
      Topic(
        id: 22,
        name: "Zvířata",
        color: Colors.green,
        icon: Icon(Icons.pets),
        questionIDs: range(752, 900),
      ),
      Topic(
        id: 23,
        name: "Koníčky",
        color: Colors.pinkAccent,
        icon: Icon(Icons.favorite),
        questionIDs: range(904, 1028, extra: [
          675,
          679,
          680,
          682,
          684,
          688,
          690,
          691,
          692,
          695,
          696,
          701,
          703,
          705,
          707,
          708,
          710,
          719,
          724,
          726,
          727,
          728,
          730,
          731,
          732,
          733,
          734,
          735,
          736,
          737,
          742,
          743,
          744,
          745,
          746,
          748,
          749,
          750,
        ]),
        sources: ["https://en.wikipedia.org/wiki/List_of_hobbies"],
      ),
      Topic(
          id: 24,
          name: "Videohry",
          color: Colors.yellow,
          icon: Icon(Icons.games),
          questionIDs: range(1029, 1108),
          sources: [
            "https://en.wikipedia.org/wiki/List_of_best-selling_video_games",
            "https://en.wikipedia.org/wiki/Arcade_game#List_of_highest-grossing_games",
            "https://en.wikipedia.org/wiki/List_of_video_games_by_monthly_active_player_count",
            "https://en.wikipedia.org/wiki/List_of_video_games_considered_the_best",
            "https://en.wikipedia.org/wiki/List_of_best-selling_game_consoles",
          ]),
      Topic(
          id: 25,
          name: "Jídlo a pití",
          color: Colors.brown,
          icon: Icon(Icons.restaurant_menu),
          questionIDs: range(1116, 1239),
          sources: [
            "https://en.wikipedia.org/wiki/Lists_of_foods",
            "https://en.wikipedia.org/wiki/Category:Appetizers",
            "https://en.wikipedia.org/wiki/Category:Condiments",
            "https://en.wikipedia.org/wiki/Category:Confectionery",
            "https://en.wikipedia.org/wiki/Category:Fast_food",
            "https://en.wikipedia.org/wiki/List_of_desserts",
            "https://en.wikipedia.org/wiki/List_of_street_foods",
            "https://en.wikipedia.org/wiki/Specialty_food",
            "https://en.wikipedia.org/wiki/List_of_drinks",
            "https://en.wikipedia.org/wiki/List_of_cocktails",
            "https://en.wikipedia.org/wiki/List_of_alcoholic_drinks",
          ]),
      Topic(
          id: 26,
          name: "Povolání",
          color: Colors.limeAccent,
          icon: Icon(Icons.work),
          questionIDs: range(1240, 1433),
          sources: ["https://www.prace.cz/encyklopedie-profesi/"]),
      Topic(
          id: 27,
          name: "Povinná četba",
          color: Colors.lightBlueAccent,
          icon: Icon(Icons.import_contacts),
          questionIDs: range(1434, 1567),
          sources: [
            "https://www.gvm.cz/images/stories/o-studiu/komise/cj/seznam-cetby-maturita-2019-2020.pdf",
          ]),
      Topic(
          id: 28,
          name: "Hudební nástroje",
          color: Colors.redAccent,
          icon: Icon(Icons.audiotrack),
          questionIDs: range(1568, 1612),
          sources: ["https://cs.wikipedia.org/wiki/Seznam_hudebn%C3%ADch_n%C3%A1stroj%C5%AF"]),
      Topic(
          id: 29,
          name: "Nejprodávanější singly",
          color: Colors.amber,
          icon: Icon(Icons.trending_up),
          questionIDs: range(1613, 1692),
          sources: ["https://en.wikipedia.org/wiki/List_of_best-selling_singles"]),
      Topic(
          id: 30,
          name: "České firmy",
          color: Colors.lime,
          icon: Icon(Icons.business_center),
          questionIDs: range(1693, 1742),
          sources: [
            "https://www.czechtop100.cz/cs/projekty/zebricky/100-nejvyznamnejsich",
            "https://cs.wikipedia.org/wiki/Kategorie:%C4%8Cesk%C3%A9_firmy",
          ]),
    ],
    key: (topic) => topic.id,
    value: (topic) => topic,
  ),
);
