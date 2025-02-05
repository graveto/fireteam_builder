import 'package:flutter/material.dart';
import 'package:fireteam_builder/models/fighter.dart';

class FighterDetailsScreen extends StatelessWidget {
  final Fighter fighter;

  const FighterDetailsScreen({super.key, required this.fighter});

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(color: Colors.white);
    return Scaffold(
      appBar: AppBar(
        title: Text(fighter.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Energy Shield: ${fighter.energyShield}', style: textStyle),
            Text('Role: ${fighter.role}', style: textStyle),
            Text('SP: ${fighter.sp}', style: textStyle),
            Text('RA: ${fighter.ra}', style: textStyle),
            Text('FI: ${fighter.fi}', style: textStyle),
            Text('SV: ${fighter.sv}', style: textStyle),
            Text('AR: ${fighter.ar}', style: textStyle),
            Text('HP: ${fighter.hp}', style: textStyle),
            SizedBox(height: 20),
            Text(
              'Weapons:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            ...fighter.weapons.map(
              (weapon) => ListTile(
                title: Text(weapon.name, style: textStyle),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Type: ${weapon.type}', style: textStyle),
                    Text('Range: ${weapon.range}', style: textStyle),
                    Text('AP: ${weapon.ap}', style: textStyle),
                    Text('Keywords: ${weapon.keywords.join(', ')}',
                        style: textStyle),
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
