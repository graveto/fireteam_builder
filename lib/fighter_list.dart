import 'package:fireteam_builder/weapon_stats_grid.dart';
import 'package:flutter/material.dart';

import 'fighter.dart';
import 'fighter_stats_grid.dart';

class FighterListWidget extends StatefulWidget {
  final List<Fighter> fighters;

  const FighterListWidget({super.key, required this.fighters});

  @override
  State<FighterListWidget> createState() => _FighterListWidgetState();
}

class _FighterListWidgetState extends State<FighterListWidget> {
  int? _expandedIndex;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.fighters.length,
      itemBuilder: (context, index) {
        final fighter = widget.fighters[index];
        return ExpansionPanelList(
          expansionCallback: (int itemIndex, bool isExpanded) {
            setState(() {
              _expandedIndex = isExpanded ? index : null;
            });
          },
          children: [
            ExpansionPanel(
              headerBuilder: (BuildContext context, bool isExpanded) {
                return ListTile(
                  title: Text(
                    fighter.name,
                  ),
                );
              },
              body: Column(
                children: [
                  Row(  // Row for Energy Shield and Role
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            ListTile(
                              title: Text("Energy Shield: ${fighter.energyShield}"),
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
        );
      },
    );
  }
}
