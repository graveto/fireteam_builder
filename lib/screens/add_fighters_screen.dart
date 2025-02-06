import 'package:flutter/material.dart';
import 'package:fireteam_builder/models/fighter.dart';
import 'package:fireteam_builder/models/team.dart';
import 'package:fireteam_builder/widgets/fighter_list_item.dart';

import '../helpers/database_helper.dart';

class AddFightersScreen extends StatefulWidget {
  final String teamName;
  final int? id;

  const AddFightersScreen({super.key, required this.teamName, this.id});

  @override
  _AddFightersScreenState createState() => _AddFightersScreenState();
}

class _AddFightersScreenState extends State<AddFightersScreen> {
  List<Fighter> selectedFighters = [];
  List<Fighter> _allFighters = [];
  List<Fighter> fighters = [];

  @override
  void initState() {
    super.initState();
    _loadTeamAndFighters();
  }

  Future<void> _loadTeamAndFighters() async {
    final dbHelper = DatabaseHelper.instance; // Get the team
    _allFighters = await dbHelper.getFighters(); // Get all fighters

    setState(() {
      fighters = _allFighters;
    });
  }

  @override
  Widget build(BuildContext context) {
    fighters.sort((a, b) => a.name.compareTo(b.name));
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Fighters to ${widget.teamName}'),
      ),
      body: ListView.builder(
        itemCount: fighters.length,
        itemBuilder: (context, index) {
          final fighter = _allFighters[index];
          return Card(
            color: Colors.green,
            // Wrap FighterListItem in a Card
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                  Radius.circular(5.0)), // Set border radius to zero
            ),
            child: FighterListItem(
              fighter: fighter,
              isSelected: selectedFighters.contains(fighter),
              onSelected: (bool value) {
                setState(() {
                  if (value) {
                    selectedFighters.add(fighter);
                  } else {
                    selectedFighters.remove(fighter);
                  }
                });
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Create the Team object with the optional id
          //

          final dbHelper = DatabaseHelper.instance;
          final teamId = await dbHelper.insertTeam(
              {'name': widget.teamName}); // Insert the team into the database
          final newTeam = Team(
              id: teamId, name: widget.teamName, fighters: selectedFighters);

          // Save fighters for the team
          for (var fighter in newTeam.fighters) {
            await dbHelper.insertTeamFighter(teamId, fighter.id);
          }

          Navigator.pop(context, newTeam); // Return the newTeam
        },
        child: Icon(Icons.save),
      ),
    );
  }
}
