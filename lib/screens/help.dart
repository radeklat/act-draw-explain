import 'package:act_draw_explain/widgets/text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HelpScreen extends StatelessWidget {
  static const String ID = "help_screen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            TextCard(
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
            TextCard(
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
            TextCard(
              children: <Widget>[
                TextTitle("Hry pro pokročilé"),
                TextBody1(
                  "I když k tomu aplikace zatím nevybízí a není k tomu optimalizovaná při výběru otázek, je možné hádat "
                  "i předvedením (pantomimou) nebo nakreslením.",
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
