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
        child: ListView(
          children: <Widget>[
            HelpCard(
              children: <Widget>[
                TextTitle("Jak hrát"),
                TextBody1(
                  "Hra je určena pro 2 a více hráčů. V případě více hráčů je možné se rozdělit do několik týmů "
                  "o minimálně dvou hráčích. Principem hry je uhodnout co nejvíce zobrazených termínů. V průběhu "
                  "se nesmí používat slova se stejným kořenem, jako hádaný termín. Hráč může hádat dokud neodpoví "
                  "správně. Pokud je však hra limitovaná časem nebo je termín příliš těžký, je možné jej přeskočit.",
                ),
                TextBody1(
                  "Způsob ovládání lze změnit v nastaveních, která jsou k dispozici na hlavní obrazovce pod symbolem "
                  "ozubeného kola.",
                ),
                TextSubtitle("Tlačítka"),
                TextBody1(
                  "Na obrazovce s hádaným termínem jsou zobrazena tlačítka pro správnou a špatnou odpověď.",
                ),
                TextSubtitle("Naklopení displeje"),
                TextBody1(
                  "Telefon je nutné mít přiskutý na čele. Správná odpověď se zvolí naklopením displeje dolu, "
                  "špatná naklopením nahoru.",
                ),
              ],
            ),
            HelpCard(
              children: <Widget>[
                TextTitle("Ovládání hry"),
                TextSubtitle("Styl slepec"),
                TextBody1(
                  "Jeden z hráčů hádá termín a nevidí jej, ostatní jej vidí a snaží se jej popsat. Zda byla odpověď "
                      "správná či špatná lze označit naklopením telefonu.",
                ),
                TextSubtitle("Styl vypravěc"),
                TextBody1(
                  "Jeden z hráčů vidí hádáný termín a popisuje jej, ostatní jej nevidí a hádají. Odpověď lze označit "
                      "tlačítky.",
                ),
                TextSubtitle("Na čas"),
                TextBody1(
                  "V nastaveních zvolte délku hry. Kdo stihne nejvíce odpovědí v časovém limitu?",
                ),
                TextSubtitle("Nejvyšší skóre"),
                TextBody1(
                  "V nastaveních zvolte neomezenou délku hry. Hra trvá dokud nedojou termíny. Kdo má nejvíce uhodnuto?",
                ),

              ],
            ),
            HelpCard(
              children: <Widget>[
                TextTitle("Hry pro pokročilé"),

              ],
            ),
          ],
        ),
      ),
    );
  }
}

class HelpCard extends StatelessWidget {
  final List<Widget> children;

  const HelpCard({
    Key key,
    this.children,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: children),
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
      child: Text(text, style: Theme.of(context).textTheme.headline5.copyWith(color: Theme.of(context).accentColor)),
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
      child: Text(text, style: Theme.of(context).textTheme.headline6),
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
      child: Text(text, style: Theme.of(context).textTheme.bodyText1),
    );
  }
}
