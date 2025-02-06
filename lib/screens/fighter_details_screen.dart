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
        title: Text(
          fighter.name,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text('Energy Shield:', style: textStyle),
                const SizedBox(width: 8), // Add some spacing
                Text('(${fighter.energyShield})', style: textStyle),
                const SizedBox(width: 64), // Add some spacing
                Text('Role:', style: textStyle),
                const SizedBox(width: 8), // Add some spacing
                Text(fighter.role, style: textStyle),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Text('SP', style: textStyle),
                        ],
                      ),
                      Column(
                        children: [
                          Text('RA', style: textStyle),
                        ],
                      ),
                      Column(
                        children: [
                          Text('FI', style: textStyle),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Text(fighter.sp, style: textStyle),
                        ],
                      ),
                      Column(
                        children: [
                          Text(fighter.ra, style: textStyle),
                        ],
                      ),
                      Column(
                        children: [
                          Text(fighter.fi, style: textStyle),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Text('SV: ${fighter.sv}', style: textStyle),
                  ],
                ),
                Column(
                  children: [
                    Text('AR: ${fighter.ar}', style: textStyle),
                  ],
                ),
                Column(
                  children: [
                    Text('HP: ${fighter.hp}', style: textStyle),
                  ],
                ),
              ],
            ),
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
