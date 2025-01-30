import 'package:flutter/material.dart';
import 'package:fireteam_builder/fighter.dart';

import 'data/fighters.dart';
import 'fighter_list.dart';

class SelectedFightersWidget extends StatefulWidget {

  const SelectedFightersWidget({super.key});

  @override
  State<SelectedFightersWidget> createState() => _SelectedFightersWidgetState();
}

class _SelectedFightersWidgetState extends State<SelectedFightersWidget> {
  List<Fighter> _selectedFighters = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: _selectedFighters.isEmpty
                ? const Center(
              child: Text('No fighters selected'),
            )
                : ListView.builder(
              itemCount: _selectedFighters.length,
              itemBuilder: (context, index) {
                final fighter = _selectedFighters[index];
                return ListTile(
                  title: Text(fighter.name),
                  subtitle: Text(fighter.role),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FighterListWidget(
                      fighters: fighters,
                      selectedFighters: _selectedFighters,
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
  }
}