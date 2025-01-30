import 'package:flutter/material.dart';

import 'fighter.dart';

class FighterStatsGrid extends StatelessWidget {
  final Fighter fighter;

  const FighterStatsGrid({super.key, required this.fighter});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 3, // 3 columns
      shrinkWrap: true, // Prevent grid from taking up unnecessary space
      physics: const NeverScrollableScrollPhysics(), // Disable scrolling
      children: [
        _StatTile(label: "SP", value: fighter.sp),
        _StatTile(label: "RA", value: fighter.ra),
        _StatTile(label: "FI", value: fighter.fi),
        _StatTile(label: "SV", value: fighter.sv),
        _StatTile(label: "AR", value: fighter.ar),
        _StatTile(label: "HP", value: fighter.hp),
      ],
    );
  }
}

class _StatTile extends StatelessWidget {
  final String label;
  final int value;

  const _StatTile({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(value.toString()),
          ],
        ),
      ),
    );
  }
}