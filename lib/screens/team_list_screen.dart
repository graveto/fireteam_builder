import 'package:flutter/material.dart';
import 'package:fireteam_builder/models/team.dart';
import 'package:fireteam_builder/screens/create_team_screen.dart';

import '../helpers/database_helper.dart';
import 'edit_team_screen.dart';

class TeamListScreen extends StatefulWidget {
  const TeamListScreen({super.key});

  @override
  _TeamListScreenState createState() => _TeamListScreenState();
}

class _TeamListScreenState extends State<TeamListScreen> {
  List<Team> teams = [];

  @override
  void initState() {
    super.initState();
    _loadTeams();
  }

  void _loadTeams() async {
    final dbHelper = DatabaseHelper.instance;
    await dbHelper.seedFighters();
    List<Team> fetchedTeams = await dbHelper.getTeams();
    setState(() {
      teams = fetchedTeams;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Team List'),
      ),
      body: teams.isEmpty
          ? Center(
              child: Text(
                'No teams yet. Create one!',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            )
          : ListView.builder(
              itemCount: teams.length,
              itemBuilder: (context, index) {
                final team = teams[index];
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(
                        5.0,
                      ),
                    ), // Set border radius to zero
                  ),
                  color: Colors.green, // Wrap ListTile in a Card
                  child: ListTile(
                    textColor: Color(0xFF0B1A0C),
                    // Set ListTile text color
                    iconColor: Color(0xFF0B1A0C),
                    title: Text(team.name),
                    subtitle: Text(team.fighters.map((f) => f.name).join(', ')),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            // Navigate to edit team screen
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    EditTeamScreen(teamId: team.id),
                              ),
                            ).then((updatedTeam) {
                              if (updatedTeam != null) {
                                setState(() {
                                  teams[index] = updatedTeam;
                                });
                              }
                            });
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () async {
                            // Remove the team from the list
                            final dbHelper = DatabaseHelper.instance;
                            await dbHelper.deleteTeam(
                                team.id); // Delete the team from the database
                            _loadTeams();
                          },
                        ),
                      ],
                    ),
                    onTap: () {
                      // Navigate to team details screen
                    },
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreateTeamScreen()),
          ).then((newTeam) {
            if (newTeam != null) {
              _loadTeams();
              // setState(() {
              //   teams.add(newTeam);
              // });
            }
          });
        },
        foregroundColor: Color(0xFF0B1A0C),
        child: Icon(Icons.add),
      ),
    );
  }
}
