import 'package:flutter/material.dart';
import 'package:fireteam_builder/models/fighter.dart';
import 'package:fireteam_builder/screens/fighter_details_screen.dart';

class FighterListItem extends StatelessWidget {
  final Fighter fighter;
  final bool isSelected;
  final ValueChanged<bool> onSelected;

  const FighterListItem({
    super.key,
    required this.fighter,
    required this.isSelected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Text(
        fighter.name,
        style: TextStyle(
          color: Color(0xFF0B1A0C),
        ),
      ),
      value: isSelected,
      onChanged: (value) {
        onSelected(value!);
      },
      secondary: IconButton(
        icon: Icon(Icons.info_outline),
        color: Color(0xFF0B1A0C),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FighterDetailsScreen(fighter: fighter),
            ),
          );
        },
      ),
    );
  }
}
