import 'package:flutter/material.dart';
import 'package:fireteam_builder/models/fighter.dart';
import 'package:fireteam_builder/models/team.dart';
import 'package:fireteam_builder/widgets/fighter_list_item.dart';

import '../helpers/database_helper.dart';

class EditTeamScreen extends StatefulWidget {
  final int teamId;

  const EditTeamScreen({super.key, required this.teamId});

  @override
  _EditTeamScreenState createState() => _EditTeamScreenState();
}

class _EditTeamScreenState extends State<EditTeamScreen> {
  late Team _team;
  List<Fighter> _allFighters = [];
  final List<int> _selectedFighterIds = []; // Use a Set of IDs!
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadTeamAndFighters();
  }

  Future<void> _loadTeamAndFighters() async {
    setState(() {
      _isLoading = true;
    });

    final dbHelper = DatabaseHelper.instance;
    _team = await dbHelper.getTeam(widget.teamId); // Get the team
    _allFighters = await dbHelper.getFighters(); // Get all fighters

    print("All Fighters (from DB):");
    for (var f in _allFighters) {
      print("  ID: ${f.id}, Name: ${f.name}");
    }

    // Populate _selectedFighterIds with the IDs of the fighters in the team
    _selectedFighterIds.clear();
    for (var fighter in _team.fighters) {
      _selectedFighterIds
          .add(fighter.id); // Safe to use ! because id is checked
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    _allFighters.sort((a, b) => a.name.compareTo(b.name));
    return Scaffold(
      appBar: AppBar(
        title:
            _isLoading ? const Text("Loading...") : Text('Edit ${_team.name}'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView.builder(
                itemCount: _allFighters.length,
                itemBuilder: (context, index) {
                  final fighter = _allFighters[index];
                  // Check if the fighter's ID is in the selected set
                  bool isSelected = _selectedFighterIds.contains(fighter.id);

                  return Card(
                      color: Colors.green,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero),
                      child: FighterListItem(
                        //Use the custom widget
                        fighter: fighter,
                        isSelected: isSelected,
                        onSelected: (bool value) {
                          setState(() {
                            if (value) {
                              _selectedFighterIds.add(fighter.id);
                            } else {
                              _selectedFighterIds.remove(fighter.id); //And here
                            }
                          });
                        },
                      ));
                },
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Convert selected fighter IDs back to Fighter objects
          List<Fighter> updatedFighters = _allFighters
              .where((fighter) => _selectedFighterIds.contains(fighter.id))
              .toList();
          _team.fighters = updatedFighters; // Update the team's fighters

          final dbHelper = DatabaseHelper.instance;
          await dbHelper.updateTeam(_team); // Update the team in the database

          Navigator.pop(context, _team); // Return the updated team
        },
        child: const Icon(Icons.save),
      ),
    );
  }
}
