import 'package:fireteam_builder/weapon.dart';

class Fighter {
  final String name;
  final int energyShield;
  final String role; // e.g., "Scout"
  final int sp;
  final int ra;
  final int fi;
  final int sv;
  final int ar;
  final int hp;
  final List<Weapon> weapons;

  Fighter({
    required this.name,
    required this.energyShield,
    required this.role,
    required this.sp,
    required this.ra,
    required this.fi,
    required this.sv,
    required this.ar,
    required this.hp,
    required this.weapons,
  });
}

