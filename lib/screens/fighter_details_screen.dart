import 'package:flutter/material.dart';
import 'package:fireteam_builder/models/fighter.dart';

class FighterDetailsScreen extends StatelessWidget {
  final Fighter fighter;

  const FighterDetailsScreen({super.key, required this.fighter});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(fighter.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Energy Shield: ${fighter.energyShield}'),
            Text('Role: ${fighter.role}'),
            Text('SP: ${fighter.sp}'),
            Text('RA: ${fighter.ra}'),
            Text('FI: ${fighter.fi}'),
            Text('SV: ${fighter.sv}'),
            Text('AR: ${fighter.ar}'),
            Text('HP: ${fighter.hp}'),
            SizedBox(height: 20),
            Text('Weapons:', style: TextStyle(fontWeight: FontWeight.bold)),
            ...fighter.weapons.map(
              (weapon) => ListTile(
                title: Text(weapon.name),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Type: ${weapon.type}'),
                    Text('Range: ${weapon.range}'),
                    Text('AP: ${weapon.ap}'),
                    Text('Keywords: ${weapon.keywords.join(', ')}'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
