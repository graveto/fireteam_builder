import 'package:fireteam_builder/weapon.dart';
import 'package:flutter/material.dart';

import 'create_fireteam_widget.dart';
import 'data/fighters.dart';
import 'fighter.dart';
import 'fighter_list.dart';
import 'fireteam.dart';

class FireteamListWidget extends StatefulWidget {
  const FireteamListWidget({super.key});

  @override
  State<FireteamListWidget> createState() => _FireteamListWidgetState();
}

class _FireteamListWidgetState extends State<FireteamListWidget> {
  List<Fireteam> _fireteams = [];

  @override
  void initState() {
    super.initState();
    // Load fireteams from storage or initialize with default data
    _loadFireteams();
  }

  void _loadFireteams() {
    // Simulate loading fireteams from storage
    // Replace this with your actual storage logic
    List<Fireteam> loadedFireteams = [
      Fireteam("Alpha Team", fighters: []),
      Fireteam("Bravo Team", fighters: []),
    ];
    loadedFireteams[0].addFighter(
      Fighter(
        name: 'Spartan Brawler',
        energyShield: 2,
        role: '',
        sp: 2,
        ra: 5,
        fi: 3,
        sv: 5,
        ar: 2,
        hp: 4,
        weapons: [
          Weapon(
            name: 'M11 Combat Knife',
            type: 'Close Combat',
            range: 'CC',
            ap: 2,
            keywords: ['ESD (1)'],
          ),
          Weapon(
            name: 'Needler',
            type: 'Ranged',
            range: 'R3',
            ap: 0,
            keywords: ['Lethal (1)', 'Rapid Fire', 'Weight of Fire (1)'],
          ),
        ],
      ),
    );
  }

  void _addFireteam(Fireteam fireteam) {
    setState(() {
      _fireteams.add(fireteam);
    });
  }

  void _updateFireteam(Fireteam updatedFireteam) {
    setState(() {
      final index =
          _fireteams.indexWhere((team) => team.name == updatedFireteam.name);
      if (index != -1) {
        _fireteams[index] = updatedFireteam;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          if (_fireteams.isEmpty)
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 100.0),
                child: const Text(
                  'Build your first fireteam',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            )
          else
            ListView.builder(
              itemCount: _fireteams.length,
              itemBuilder: (context, index) {
                final fireteam = _fireteams[index];
                return ListTile(
                  title: Text(fireteam.name),
                  subtitle: Text(
                    fireteam.fighters
                        .map((fighter) => fighter.name)
                        .toList()
                        .join(', '),
                  ),
                  // Add more details or actions here if needed
                );
              },
            ),
          Positioned(
            bottom: 20,
            right: 20,
            child: FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CreateFireteamWidget(
                      onFireteamCreated: (newFireteam) {
                        _addFireteam(newFireteam);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FighterListWidget(
                              fighters: fighters,
                              selectedFighters: const [],
                              onFightersSelected: (selectedFighters) {
                                setState(() {
                                  newFireteam.fighters.clear();
                                  newFireteam.fighters.addAll(selectedFighters);
                                });
                                _updateFireteam(newFireteam);
                                Navigator.pop(context);
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
              child: const Icon(Icons.add),
            ),
          ),
        ],
      ),
    );
  }
}
