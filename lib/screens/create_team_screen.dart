import 'package:flutter/material.dart';
import 'package:fireteam_builder/screens/add_fighters_screen.dart';

class CreateTeamScreen extends StatefulWidget {
  const CreateTeamScreen({super.key});

  @override
  _CreateTeamScreenState createState() => _CreateTeamScreenState();
}

class _CreateTeamScreenState extends State<CreateTeamScreen> {
  final _formKey = GlobalKey<FormState>();
  String _teamName = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Team'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              TextFormField(
                style: TextStyle(color: Colors.white), // White text color
                decoration: InputDecoration(
                  labelText: 'Team Name',
                  labelStyle:
                      TextStyle(color: Colors.white), // White label color
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a team name';
                  }
                  return null;
                },
                onSaved: (value) {
                  _teamName = value!;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightGreen, // Light green background
                  foregroundColor:
                      const Color(0xFF003819), // Dark green text color
                ),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    final newTeam = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            AddFightersScreen(teamName: _teamName),
                      ),
                    );
                    if (newTeam != null) {
                      Navigator.pop(context, newTeam);
                    }
                  }
                },
                child: Text('Add Characters'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
