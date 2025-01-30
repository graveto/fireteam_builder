import 'package:flutter/material.dart';

import 'fighter.dart';

//... (Fighter and Weapon class definitions)

class FighterListWidget extends StatefulWidget {
  final List<Fighter> fighters;

  const FighterListWidget({Key? key, required this.fighters}): super(key: key);

  @override
  State<FighterListWidget> createState() => _FighterListWidgetState();
}

class _FighterListWidgetState extends State<FighterListWidget> {
  // Store the index of the currently expanded item
  int? _expandedIndex;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.fighters.length,
      itemBuilder: (context, index) {
        final fighter = widget.fighters[index];
        return ExpansionTile(
          title: Text(fighter.name),
          // Control the expansion state
          initiallyExpanded: _expandedIndex == index,
          onExpansionChanged: (isExpanded) {
            setState(() {
              _expandedIndex = isExpanded? index: null;
            });
          },
          children: [
            // Display fighter details here
            ListTile(
              title: Text("Energy Shield: ${fighter.energyShield}"),
            ),
            ListTile(
              title: Text("Role: ${fighter.role}"),
            ),
            // Add more details as needed...
          ],
        );
      },
    );
  }
}