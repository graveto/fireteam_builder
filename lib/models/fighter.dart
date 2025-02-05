class Fighter {
  final String name;
  final int energyShield;
  final String role;
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

  Fighter.fromMap(Map<String, dynamic> map, this.weapons)
      : name = map['name'],
        energyShield = map['energyShield'],
        role = map['role'],
        sp = map['sp'],
        ra = map['ra'],
        fi = map['fi'],
        sv = map['sv'],
        ar = map['ar'],
        hp = map['hp'];
}

class Weapon {
  final String name;
  final String type;
  final String range;
  final int ap;
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

var fighters = [
  Fighter(
    name: 'Spartan Brawler',
    energyShield: 2,
    role: '',
    sp: 2,
    ra: 5,
    fi: 3,
    sv: 5,
    ar: 2,
    hp: 4,
    weapons: [
      Weapon(
        name: 'M11 Combat Knife',
        type: 'Close Combat',
        range: 'CC',
        ap: 2,
        keywords: ['ESD (1)'],
      ),
      Weapon(
        name: 'Needler',
        type: 'Ranged',
        range: 'R3',
        ap: 0,
        keywords: ['Lethal (1)', 'Rapid Fire', 'Weight of Fire (1)'],
      ),
    ],
  ),
  Fighter(
    name: 'Spartan Deadeye',
    energyShield: 2,
    role: 'Fast Transition',
    sp: 2,
    ra: 3,
    fi: 5,
    sv: 5,
    ar: 2,
    hp: 4,
    weapons: [
      Weapon(
        name: 'M11 Combat Knife',
        type: 'Close Combat',
        range: 'CC',
        ap: 2,
        keywords: ['ESD (1)'],
      ),
      Weapon(
        name: 'M392 DMR',
        type: 'Ranged',
        range: 'R6',
        ap: 0,
        keywords: ['Lethal (1)', 'Optics'],
      ),
    ],
  ),
  Fighter(
    name: 'Spartan Deadeye',
    energyShield: 2,
    role: 'Fast Transition',
    sp: 2,
    ra: 3,
    fi: 5,
    sv: 5,
    ar: 2,
    hp: 4,
    weapons: [
      Weapon(
        name: 'M11 Combat Knife',
        type: 'Close Combat',
        range: 'CC',
        ap: 2,
        keywords: ['ESD (1)'],
      ),
      Weapon(
        name: 'Stalker Rifle',
        type: 'Ranged',
        range: 'R6',
        ap: 1,
        keywords: ['Sniper Scope'],
      ),
    ],
  ),
  Fighter(
    name: 'Spartan MK VII',
    energyShield: 2,
    role: 'Tactician (1)',
    sp: 2,
    ra: 4,
    fi: 4,
    sv: 5,
    ar: 2,
    hp: 4,
    weapons: [
      Weapon(
        name: 'M11 Combat Knife',
        type: 'Close Combat',
        range: 'CC',
        ap: 2,
        keywords: ['ESD (1)'],
      ),
      Weapon(
        name: 'MA40 Assault Rifle',
        type: 'Ranged',
        range: 'R4',
        ap: 0,
        keywords: ['Rapid Fire', 'Weight of Fire (2)'],
      ),
    ],
  ),
  Fighter(
    name: 'Spartan MK VII',
    energyShield: 2,
    role: 'Tactician (1)',
    sp: 2,
    ra: 4,
    fi: 4,
    sv: 5,
    ar: 2,
    hp: 4,
    weapons: [
      Weapon(
        name: 'M11 Combat Knife',
        type: 'Close Combat',
        range: 'CC',
        ap: 2,
        keywords: ['ESD (1)'],
      ),
      Weapon(
        name: 'Pulse Carbine',
        type: 'Ranged',
        range: 'R4',
        ap: 1,
        keywords: ['ESD (1)', 'Weight of Fire (1)'],
      ),
    ],
  ),
  Fighter(
    name: 'Spartan Zvezda',
    energyShield: 2,
    role: 'Scout',
    sp: 1,
    ra: 4,
    fi: 5,
    sv: 4,
    ar: 2,
    hp: 4,
    weapons: [
      Weapon(
        name: 'M11 Combat Knife',
        type: 'Close Combat',
        range: 'CC',
        ap: 2,
        keywords: ['ESD (1)'],
      ),
      Weapon(
        name: 'Cindershot',
        type: 'Ranged',
        range: 'R4',
        ap: 0,
        keywords: ['ESD (1)', 'Grenade', 'Implosion (5)', 'Lethal (1)'],
      ),
    ],
  ),
  Fighter(
    name: 'Spartan Zvezda',
    energyShield: 2,
    role: 'Scout',
    sp: 1,
    ra: 4,
    fi: 5,
    sv: 4,
    ar: 2,
    hp: 4,
    weapons: [
      Weapon(
        name: 'M11 Combat Knife',
        type: 'Close Combat',
        range: 'CC',
        ap: 2,
        keywords: ['ESD (1)'],
      ),
      Weapon(
        name: 'VK78 Commando',
        type: 'Ranged',
        range: 'R6',
        ap: 0,
        keywords: ['Optics', 'Rapid Fire'],
      ),
    ],
  ),
  Fighter(
    name: 'Spartan Brawler',
    energyShield: 2,
    role: '',
    sp: 2,
    ra: 5,
    fi: 3,
    sv: 5,
    ar: 2,
    hp: 4,
    weapons: [
      Weapon(
        name: 'M11 Combat Knife',
        type: 'Close Combat',
        range: 'CC',
        ap: 2,
        keywords: ['ESD (1)'],
      ),
      Weapon(
        name: 'CQS48 Bulldog',
        type: 'Ranged',
        range: 'R2',
        ap: 2,
        keywords: ['Knockback', 'Lethal (1)'],
      ),
    ],
  ),
  Fighter(
    name: 'Master Chief',
    energyShield: 3,
    role: 'Stoic, Tactician (3)',
    sp: 2,
    ra: 3,
    fi: 3,
    sv: 3,
    ar: 2,
    hp: 5,
    weapons: [
      Weapon(
        name: 'Energy Sword',
        type: 'Close Combat',
        range: 'CC',
        ap: 3,
        keywords: ['ESD (2)', 'Lethal (1)'],
      ),
      Weapon(
        name: 'Energy Sword',
        type: 'Close Combat',
        range: 'R1',
        ap: 3,
        keywords: ['ESD (1)', 'Lunge'],
      ),
    ],
  ),
  Fighter(
    name: 'Sangheili Mercenary',
    energyShield: 3,
    role: 'Evade',
    sp: 2,
    ra: 4,
    fi: 4,
    sv: 4,
    ar: 1,
    hp: 3,
    weapons: [
      Weapon(
        name: 'Energy Sword',
        type: 'Close Combat',
        range: 'CC',
        ap: 3,
        keywords: ['ESD (2)', 'Lethal (1)'],
      ),
      Weapon(
        name: 'Energy Sword',
        type: 'Close Combat',
        range: 'R1',
        ap: 3,
        keywords: ['ESD (1)', 'Lunge'],
      ),
      Weapon(
        name: 'Plasma Grenade',
        type: 'Grenade',
        range: 'R3',
        ap: 2,
        keywords: ['Frag (4)', 'Grenade', 'Lethal (1)', 'One-Use', 'Sticky'],
      ),
    ],
  ),
  Fighter(
    name: 'Sangheili Mercenary',
    energyShield: 3,
    role: 'Evade',
    sp: 2,
    ra: 4,
    fi: 4,
    sv: 4,
    ar: 1,
    hp: 3,
    weapons: [
      Weapon(
        name: 'Energy Daggers',
        type: 'Close Combat',
        range: 'CC',
        ap: 1,
        keywords: ['Smash (1)'],
      ),
      Weapon(
        name: 'Needler',
        type: 'Ranged',
        range: 'R3',
        ap: 0,
        keywords: ['Lethal (1)', 'Rapid Fire', 'Weight of Fire (1)'],
      ),
      Weapon(
        name: 'Plasma Grenade',
        type: 'Grenade',
        range: 'R3',
        ap: 2,
        keywords: ['Frag (4)', 'Grenade', 'Lethal (1)', 'One-Use', 'Sticky'],
      ),
    ],
  ),
  Fighter(
    name: 'Sangheili Mercenary',
    energyShield: 3,
    role: 'Evade',
    sp: 2,
    ra: 4,
    fi: 4,
    sv: 4,
    ar: 1,
    hp: 3,
    weapons: [
      Weapon(
        name: 'Energy Daggers',
        type: 'Close Combat',
        range: 'CC',
        ap: 1,
        keywords: ['Smash (1)'],
      ),
      Weapon(
        name: 'Plasma Rifle',
        type: 'Ranged',
        range: 'R4',
        ap: 1,
        keywords: ['Continuous Fire', 'ESD (1)', 'Long', 'Rapid Fire'],
      ),
      Weapon(
        name: 'Plasma Grenade',
        type: 'Grenade',
        range: 'R3',
        ap: 2,
        keywords: ['Frag (4)', 'Grenade', 'Lethal (1)', 'One-Use', 'Sticky'],
      ),
    ],
  ),
  Fighter(
    name: 'Sangheili Mercenary',
    energyShield: 3,
    role: 'Evade',
    sp: 2,
    ra: 4,
    fi: 4,
    sv: 4,
    ar: 1,
    hp: 3,
    weapons: [
      Weapon(
        name: 'Energy Daggers',
        type: 'Close Combat',
        range: 'CC',
        ap: 1,
        keywords: ['Smash (1)'],
      ),
      Weapon(
        name: 'Pulse Carbine',
        type: 'Ranged',
        range: 'R4',
        ap: 1,
        keywords: ['ESD (1)', 'Weight of Fire (1)'],
      ),
      Weapon(
        name: 'Plasma Grenade',
        type: 'Grenade',
        range: 'R3',
        ap: 2,
        keywords: ['Frag (4)', 'Grenade', 'Lethal (1)', 'One-Use', 'Sticky'],
      ),
    ],
  ),
];
