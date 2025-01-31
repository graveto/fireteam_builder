import 'package:fireteam_builder/weapon_stats_grid.dart';
import 'package:flutter/material.dart';

import 'fighter.dart';
import 'fighter_stats_grid.dart';

class FighterListWidget extends StatefulWidget {
  final List<Fighter> fighters;
  final List<Fighter> selectedFighters;
  final Function(List<Fighter>) onFightersSelected;

  const FighterListWidget({
    super.key,
    required this.fighters,
    required this.selectedFighters,
    required this.onFightersSelected,
  });

  @override
  State<FighterListWidget> createState() => _FighterListWidgetState();
}

class _FighterListWidgetState extends State<FighterListWidget> {
  int? _expandedIndex;
  late List<Fighter> _selectedFighters;

  @override
  void initState() {
    super.initState();
    _selectedFighters = List<Fighter>.from(widget.selectedFighters);
  }

  @override
  Widget build(BuildContext context) {
    widget.fighters.sort((a, b) => b.name.compareTo(a.name));
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Fighters'),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () {
              widget.onFightersSelected(_selectedFighters);
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: widget.fighters.length,
        itemBuilder: (context, index) {
          final fighter = widget.fighters[index];
          final uniqueWeaponNames =
              fighter.weapons.map((weapon) => weapon.name);
          final isSelected = _selectedFighters.contains(fighter);
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 4.0),
            color: Colors.white, // Set background color here
            child: ExpansionPanelList(
              elevation: 1, // Add elevation for a subtle shadow
              expandedHeaderPadding: EdgeInsets.zero, // Remove default padding
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
                          : Colors.lightGreen, // Set background color here
                      child: ListTile(
                        title: Text(
                          fighter.name,
                          style: TextStyle(
                            color: isExpanded
                                ? Colors.lightGreen
                                : Colors.green[900],
                          ),
                        ),
                        subtitle: Text(
                          uniqueWeaponNames.toSet().toList().join(', '),
                        ),
                        trailing: IconButton(
                          icon: isSelected
                              ? const Icon(Icons.remove_circle)
                              : const Icon(Icons.add_circle),
                          color: Colors.white,
                          onPressed: () {
                            setState(() {
                              // _selectedFighters.add(fighter);
                              if (isSelected) {
                                _selectedFighters.remove(fighter);
                              } else {
                                _selectedFighters.add(fighter);
                              }
                            });
                          },
                        ),
                      ),
                    );
                  },
                  body: Column(
                    children: [
                      Row(
                        // Row for Energy Shield and Role
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
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
    );
  }
}
