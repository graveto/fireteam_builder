import 'fighter.dart';

class Fireteam {
  String name;
  List<Fighter> fighters;

  Fireteam(this.name, {List<Fighter>? fighters}) : fighters = fighters ?? [];

  void addFighter(Fighter fighter) {
    fighters.add(fighter);
  }

  void removeFighter(Fighter fighter) {
    fighters.remove(fighter);
  }

  int get fighterCount => fighters.length;
}
