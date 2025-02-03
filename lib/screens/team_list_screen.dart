import 'package:flutter/material.dart';
import 'package:fireteam_builder/models/team.dart';
import 'package:fireteam_builder/screens/create_team_screen.dart';

import 'edit_team_screen.dart';

class TeamListScreen extends StatefulWidget {
  const TeamListScreen({super.key});

  @override
  _TeamListScreenState createState() => _TeamListScreenState();
}

class _TeamListScreenState extends State<TeamListScreen> {
  List<Team> teams = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Team List'),
      ),
      body: teams.isEmpty
          ? Center(
              child: Text('No teams yet. Create one!'),
            )
          : ListView.builder(
              itemCount: teams.length,
              itemBuilder: (context, index) {
                final team = teams[index];
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.zero, // Set border radius to zero
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
                                    EditTeamScreen(team: team),
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
                          onPressed: () {
                            // Remove the team from the list
                            setState(() {
                              teams.removeAt(index);
                            });
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
              setState(() {
                teams.add(newTeam);
              });
            }
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
