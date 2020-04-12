import 'package:act_draw_explain/data/game.dart';
import 'package:act_draw_explain/data/topics.dart';
import 'package:act_draw_explain/screens/settings.dart';
import 'package:act_draw_explain/widgets/topic/card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class HelpScreen extends StatelessWidget {
  static const String ID = "help_screen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: <Widget>[
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      TextTitle("Jak hrát"),
                      TextBody1(
                        "Hra je určena pro 2 a více hráčů. V případě více hráčů je možné se rozdělit do několik týmů "
                        "o minimálně dvou hráčích. Principem hry je uhodnout co nejvíce zobrazených termínů. V průběhu "
                        "se nesmí používat slova se stejným kořenem, jako hádaný termín.",
                      ),
                      TextSubtitle("Styl slepec"),
                      TextBody1(
                        "Jeden z hráčů hádá termín a nevidí jej, ostatní jej vidí a snaží se jej popsat.",
                      ),
                      TextSubtitle("Styl vypravěc"),
                      TextBody1(
                        "Jeden z hráčů vidí hádáný termín a popisuje jej, ostatní jej nevidí a hádají.",
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      TextTitle("Ovládání hry"),
                      TextBody1(
                        "Způsob ovládání lze změnit v nastaveních, která jsou k dispozici na hlavní obrazovce pod symbolem ozubeného kola.",
                      ),
                      TextSubtitle("Tlačítka"),
                      TextBody1(
                        "Na obrazovce s hádaným termínem jsou zobrazena tlačítka pro správnou a špatnou odpověď. Na "
                        "dotyk reaguje celá polovina obrazovky nad tlačítkem.",
                      ),
                      TextBody1(
                        "Ve hře dvou hráčů je možné telefon držet v ruce tak, aby jej druhý neviděl a nechat jej hádat. "
                        "Pokud je hráčů více nebo je několik týmů, lze telefon držet přitisknutý na čelo a poklepávat na "
                        "pravou nebo levou část obrazovky pro správnou či špatnou odpověď.",
                      ),
                      TextSubtitle("Naklopení displeje"),
                      TextBody1(
                        "Telefon je nutné mít přiskutý na čele. Správná odpověď se zvolí naklopením displeje dolu, "
                        "špatná naklopením nahoru. Toto ovládání nelze použít pro Styl vypravěč.",
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      TextTitle("Hry pro pokročilé"),
                      TextSubtitle("Nejvyšší skóre"),
                      TextBody1(
                        "V nastaveních zvolte neomezenou délku hry. Hra trvá dokud nedojou termíny. Kdo má nejvíce uhodnuto?",
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TextTitle extends StatelessWidget {
  final String text;

  const TextTitle(this.text, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 0, bottom: 16),
      child: Text(text, style: Theme.of(context).textTheme.title),
    );
  }
}


class TextSubtitle extends StatelessWidget {
  final String text;

  const TextSubtitle(this.text, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 4, bottom: 8),
      child: Text(text, style: Theme.of(context).textTheme.subtitle),
    );
  }
}

class TextBody1 extends StatelessWidget {
  final String text;

  const TextBody1(this.text, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(text, style: Theme.of(context).textTheme.body1),
    );
  }
}

