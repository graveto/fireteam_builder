// In screens/edit_team_screen.dart

import 'package:flutter/material.dart';
import 'package:fireteam_builder/models/fighter.dart';
import 'package:fireteam_builder/models/team.dart';
import 'package:fireteam_builder/widgets/fighter_list_item.dart';

class EditTeamScreen extends StatefulWidget {
  final Team team;

  const EditTeamScreen({super.key, required this.team});

  @override
  _EditTeamScreenState createState() => _EditTeamScreenState();
}

class _EditTeamScreenState extends State<EditTeamScreen> {
  late List<Fighter> selectedFighters;

  @override
  void initState() {
    super.initState();
    selectedFighters = List.from(widget.team.fighters);
  }

  @override
  Widget build(BuildContext context) {
    fighters.sort((a, b) => a.name.compareTo(b.name));

    return Scaffold(
      appBar: AppBar(
        title: Text('Edit ${widget.team.name}'),
      ),
      body: ListView.builder(
        itemCount: fighters.length,
        itemBuilder: (context, index) {
          final fighter = fighters[index];
          return Card(
            // Wrap FighterLis
            color: Colors.green, // tItem in a Card
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.zero, // Set border radius to zero
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
        onPressed: () {
          final updatedTeam = Team(
            name: widget.team.name,
            fighters: selectedFighters,
          );
          Navigator.pop(context, updatedTeam);
        },
        child: Icon(Icons.save),
      ),
    );
  }
}
