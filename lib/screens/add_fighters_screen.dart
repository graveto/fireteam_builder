import 'package:flutter/material.dart';
import 'package:fireteam_builder/models/fighter.dart';
import 'package:fireteam_builder/models/team.dart';
import 'package:fireteam_builder/widgets/fighter_list_item.dart';

class AddFightersScreen extends StatefulWidget {
  final String teamName;

  const AddFightersScreen({super.key, required this.teamName});

  @override
  _AddFightersScreenState createState() => _AddFightersScreenState();
}

class _AddFightersScreenState extends State<AddFightersScreen> {
  List<Fighter> selectedFighters = [];

  @override
  Widget build(BuildContext context) {
    fighters.sort((a, b) => a.name.compareTo(b.name));
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Characters to ${widget.teamName}'),
      ),
      body: ListView.builder(
        itemCount: fighters.length,
        itemBuilder: (context, index) {
          final fighter = fighters[index];
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
        onPressed: () {
          final newTeam =
              Team(name: widget.teamName, fighters: selectedFighters);
          Navigator.pop(context, newTeam);
        },
        child: Icon(Icons.save),
      ),
    );
  }
}
