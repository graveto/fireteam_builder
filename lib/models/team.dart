import 'fighter.dart';

class Team {
  final int id; // Add ID to Team as well
  final String name;
  List<Fighter> fighters; // Allow modification

  Team({required this.id, required this.name, required this.fighters});

  factory Team.fromMap(Map<String, dynamic> map, List<Fighter> fighters) {
    return Team(
      id: map['id'],
      name: map['name'],
      fighters: fighters,
    );
  }
}
