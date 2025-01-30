import 'package:flutter/material.dart';

import 'fighter.dart';

//... (Fighter and Weapon class definitions)

class FighterStatsGrid extends StatelessWidget {
  final Fighter fighter;

  const FighterStatsGrid({super.key, required this.fighter});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Header row
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: const [
            SizedBox(width: 50, child: Text("SP", style: TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.center,)),
            SizedBox(width: 50, child: Text("RA", style: TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.center,)),
            SizedBox(width: 50, child: Text("FI", style: TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.center,)),
            SizedBox(width: 50, child: Text("SV", style: TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.center,)),
            SizedBox(width: 50, child: Text("AR", style: TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.center,)),
            SizedBox(width: 50, child: Text("HP", style: TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.center,)),
          ],
        ),
        // Values row
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(width: 50, child: Text(fighter.sp.toString(), textAlign: TextAlign.center,)),
            SizedBox(width: 50, child: Text(fighter.ra.toString(), textAlign: TextAlign.center,)),
            SizedBox(width: 50, child: Text(fighter.fi.toString(), textAlign: TextAlign.center,)),
            SizedBox(width: 50, child: Text(fighter.sv.toString(), textAlign: TextAlign.center,)),
            SizedBox(width: 50, child: Text(fighter.ar.toString(), textAlign: TextAlign.center,)),
            SizedBox(width: 50, child: Text(fighter.hp.toString(), textAlign: TextAlign.center,)),
          ],
        ),
      ],
    );
  }
}