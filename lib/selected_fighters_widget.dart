import 'package:fireteam_builder/weapon_stats_grid.dart';
import 'package:flutter/material.dart';
import 'package:fireteam_builder/fighter.dart';

import 'data/fighters.dart';
import 'fighter_list.dart';
import 'fighter_stats_grid.dart';

class SelectedFightersWidget extends StatefulWidget {
  const SelectedFightersWidget({super.key});

  @override
  State<SelectedFightersWidget> createState() => _SelectedFightersWidgetState();
}

class _SelectedFightersWidgetState extends State<SelectedFightersWidget> {
  int? _expandedIndex;
  List<Fighter> _selectedFighters = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          if (_selectedFighters.isEmpty)
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'No fighters selected',
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () async {
                        final result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FighterListWidget(
                              fighters: fighters,
                              selectedFighters: _selectedFighters,
                              onFightersSelected: (fighters) {},
                            ),
                          ),
                        );
                        if (result != null && result is List<Fighter>) {
                          setState(() {
                            _selectedFighters = result;
                          });
                        }
                      },
                      child: const Text('Add Fighter'),
                    ),
                  ],
                ),
              ),
            )
          else
            LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: _selectedFighters.length,
                        itemBuilder: (context, index) {
                          final fighter = _selectedFighters[index];
                          final uniqueWeaponNames = fighter.weapons
                              .map((weapon) => weapon.name)
                              .toSet()
                              .toList()
                              .join(', ');
                          return Container(
                            margin: const EdgeInsets.symmetric(vertical: 4.0),
                            color: Colors.white,
                            child: ExpansionPanelList(
                              elevation: 1,
                              expandedHeaderPadding: EdgeInsets.zero,
                              expansionCallback: (int itemIndex, bool isExpanded) {
                                setState(() {
                                  _expandedIndex = isExpanded ? index : null;
                                });
                              },
                              children: [
                                ExpansionPanel(
                                  backgroundColor: Colors.lightGreen,
                                  headerBuilder: (BuildContext context, bool isExpanded) {
                                    return Container(
                                      color: isExpanded
                                          ? Colors.green[900]
                                          : Colors.lightGreen,
                                      child: ListTile(
                                        title: Text(
                                          fighter.name,
                                          style: TextStyle(
                                            color: isExpanded
                                                ? Colors.lightGreen
                                                : Colors.green[900],
                                          ),
                                        ),
                                        subtitle: Text(uniqueWeaponNames),
                                        trailing: IconButton(
                                          icon: const Icon(Icons.remove_circle),
                                          color: Colors.white,
                                          onPressed: () {
                                            setState(() {
                                              _selectedFighters.remove(fighter);
                                            });
                                          },
                                        ),
                                      ),
                                    );
                                  },
                                  body: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                        children: [
                                          Expanded(
                                            child: Column(
                                              children: [
                                                ListTile(
                                                  title: Text(
                                                      "Energy Shield: ${fighter.energyShield}"),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            child: Column(
                                              children: [
                                                ListTile(
                                                  title: Text("Role: ${fighter.role}"),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      FighterStatsGrid(
                                        fighter: fighter,
                                      ),
                                      WeaponStatsList(
                                        weapons: fighter.weapons,
                                      ),
                                    ],
                                  ),
                                  isExpanded: _expandedIndex == index,
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 20),
                      Center(
                        child: ElevatedButton(
                          onPressed: () async {
                            final result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FighterListWidget(
                                  fighters: fighters,
                                  selectedFighters: _selectedFighters,
                                  onFightersSelected: (fighters) {},
                                ),
                              ),
                            );
                            if (result != null && result is List<Fighter>) {
                              setState(() {
                                _selectedFighters = result;
                              });
                            }
                          },
                          child: const Text('Add Fighter'),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
        ],
      ),
    );
  }
}