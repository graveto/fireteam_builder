class Fighter {
  final int id; // Add the ID!
  final String name;
  final String energyShield;
  final String role;
  final String sp;
  final String ra;
  final String fi;
  final String sv;
  final String ar;
  final String hp;
  final List<Weapon> weapons;

  Fighter({
    required this.id,
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

  factory Fighter.fromMap(Map<String, dynamic> map, List<Weapon> weapons) {
    return Fighter(
      id: map['id'],
      // Include ID from the map
      name: map['name'],
      energyShield: map['energyShield'],
      role: map['role'],
      sp: map['sp'],
      ra: map['ra'],
      fi: map['fi'],
      sv: map['sv'],
      ar: map['ar'],
      hp: map['hp'],
      weapons: weapons,
    );
  }
}

class Weapon {
  final String name;
  final String type;
  final String range;
  final String ap;
  final List<String> keywords;

  Weapon({
    required this.name,
    required this.type,
    required this.range,
    required this.ap,
    required this.keywords,
  });

  Weapon.fromMap(Map<String, dynamic> map)
      : name = map['name'],
        type = map['type'],
        range = map['range'],
        ap = map['ap'],
        keywords = map['keywords'].split(',');
}

