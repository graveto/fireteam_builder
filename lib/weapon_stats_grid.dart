import 'package:fireteam_builder/weapon.dart';
import 'package:flutter/material.dart';

//... (Fighter and Weapon class definitions)

class WeaponStatsList extends StatelessWidget {
  final List<Weapon> weapons;

  const WeaponStatsList({
    super.key,
    required this.weapons,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Header row
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(
                  width: 100,
                  child: Text(
                    "Name",
                    style: TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.left,
                  ),
                ),
                const SizedBox(
                  width: 80,
                  child: Text(
                    "Type",
                    style: TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.left,
                  ),
                ),
                const SizedBox(
                  width: 50,
                  child: Text(
                    "Range",
                    style: TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.left,
                  ),
                ),
                const SizedBox(
                  width: 30,
                  child: Text(
                    "AP",
                    style: TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.left,
                  ),
                ),
                const SizedBox(
                  width: 100,
                  child: Text(
                    "Keywords",
                    style: TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.left,
                  ),
                ),
              ],
            ),
          ),
        ),
        // Weapon rows
        ...weapons.map((weapon) {
          return Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                      width: 100,
                      child: Text(
                        weapon.name,
                        textAlign: TextAlign.left,
                      )),
                  SizedBox(
                      width: 80,
                      child: Text(
                        weapon.type,
                        textAlign: TextAlign.left,
                      )),
                  SizedBox(
                      width: 50,
                      child: Text(
                        weapon.range,
                        textAlign: TextAlign.left,
                      )),
                  SizedBox(
                      width: 30,
                      child: Text(
                        weapon.ap.toString(),
                        textAlign: TextAlign.left,
                      )),
                  SizedBox(
                    width: 100,
                    child: Text(
                      weapon.keywords.join(', '),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ],
    );
  }
}
