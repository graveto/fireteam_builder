// import 'package:sqflite/sqflite.dart';
// import 'package:path/path.dart';
// import 'package:fireteam_builder/models/fighter.dart';
// import 'package:fireteam_builder/models/team.dart';
//
//
// class DatabaseHelper {
//   static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
//   static Database? _database;
//
//   DatabaseHelper._privateConstructor();
//
//   Future<Database> get database async {
//     if (_database!= null) return _database!;
//     _database = await _initDatabase();
//     return _database!;
//   }
//
//   _initDatabase() async {
//     String path = join(await getDatabasesPath(), 'team_builder.db');
//     return await openDatabase(
//       path,
//       version: 1,
//       onCreate: _onCreate,
//     );
//   }
//
//   Future _onCreate(Database db, int version) async {
//     await db.execute('''
//       CREATE TABLE teams (
//         id INTEGER PRIMARY KEY AUTOINCREMENT,
//         name TEXT NOT NULL
//       )
//     ''');
//     await db.execute('''
//       CREATE TABLE fighters (
//         id INTEGER PRIMARY KEY AUTOINCREMENT,
//         name TEXT NOT NULL,
//         energyShield INTEGER NOT NULL,
//         role TEXT,
//         sp INTEGER NOT NULL,
//         ra INTEGER NOT NULL,
//         fi INTEGER NOT NULL,
//         sv INTEGER NOT NULL,
//         ar INTEGER NOT NULL,
//         hp INTEGER NOT NULL
//       )
//     ''');
//     await db.execute('''
//       CREATE TABLE weapons (
//         id INTEGER PRIMARY KEY AUTOINCREMENT,
//         fighterId INTEGER NOT NULL,
//         name TEXT NOT NULL,
//         type TEXT NOT NULL,
//         range TEXT NOT NULL,
//         ap INTEGER NOT NULL,
//         keywords TEXT NOT NULL,
//         FOREIGN KEY (fighterId) REFERENCES fighters (id)
//       )
//     ''');
//     await db.execute('''
//       CREATE TABLE team_fighters (
//         teamId INTEGER NOT NULL,
//         fighterId INTEGER NOT NULL,
//         FOREIGN KEY (teamId) REFERENCES teams (id),
//         FOREIGN KEY (fighterId) REFERENCES fighters (id)
//       )
//     ''');
//   }
//
//   // Teams
//   Future<int> insertTeam(Team team) async {
//     Database db = await instance.database;
//     return await db.insert('teams', {'name': team.name});
//   }
//
//   Future<List<Team>> getTeams() async {
//     Database db = await instance.database;
//     List<Map<String, dynamic>> teams = await db.query('teams');
//     return teams.map((teamMap) => Team(
//       name: teamMap['name'],
//       fighters:, // Fetch fighters separately
//     )).toList();
//   }
//
//   // Fighters
//   Future<int> insertFighter(Fighter fighter) async {
//     Database db = await instance.database;
//     int fighterId = await db.insert('fighters', {
//       'name': fighter.name,
//       'energyShield': fighter.energyShield,
//       'role': fighter.role,
//       'sp': fighter.sp,
//       'ra': fighter.ra,
//       'fi': fighter.fi,
//       'sv': fighter.sv,
//       'ar': fighter.ar,
//       'hp': fighter.hp,
//     });
//
//     // Insert weapons for the fighter
//     for (var weapon in fighter.weapons) {
//       await db.insert('weapons', {
//         'fighterId': fighterId,
//         'name': weapon.name,
//         'type': weapon.type,
//         'range': weapon.range,
//         'ap': weapon.ap,
//         'keywords': weapon.keywords.join(','), // Store keywords as comma-separated string
//       });
//     }
//
//     return fighterId;
//   }
//
//   Future<Fighter> getFighter(int id) async {
//     Database db = await instance.database;
//     List<Map<String, dynamic>> fighterMaps = await db.query(
//       'fighters',
//       where: 'id =?',
//       whereArgs: [id],
//     );
//
//     if (fighterMaps.isNotEmpty) {
//       // Fetch weapons for the fighter
//       List<Map<String, dynamic>> weaponMaps = await db.query(
//         'weapons',
//         where: 'fighterId =?',
//         whereArgs: [id],
//       );
//       List<Weapon> weapons = weaponMaps.map((weaponMap) => Weapon(
//         name: weaponMap['name'],
//         type: weaponMap['type'],
//         range: weaponMap['range'],
//         ap: weaponMap['ap'],
//         keywords: weaponMap['keywords'].split(','), // Split comma-separated string to get keywords list
//       )).toList();
//
//       return Fighter(
//         name: fighterMaps['name'],
//         energyShield: fighterMaps['energyShield'],
//         role: fighterMaps['role'],
//         sp: fighterMaps['sp'],
//         ra: fighterMaps['ra'],
//         fi: fighterMaps['fi'],
//         sv: fighterMaps['sv'],
//         ar: fighterMaps['ar'],
//         hp: fighterMaps['hp'],
//         weapons: weapons,
//       );
//     } else {
//       throw Exception('Fighter not found');
//     }
//   }
//
//   // Team Fighters
//   Future<void> insertTeamFighter(int teamId, int fighterId) async {
//     Database db = await instance.database;
//     await db.insert('team_fighters', {
//       'teamId': teamId,
//       'fighterId': fighterId,
//     });
//   }
//
//   Future<List<Fighter>> getTeamFighters(int teamId) async {
//     Database db = await instance.database;
//     List<Map<String, dynamic>> maps = await db.rawQuery('''
//       SELECT f.*
//       FROM fighters f
//       INNER JOIN team_fighters tf ON f.id = tf.fighterId
//       WHERE tf.teamId =?
//     ''', [teamId]);
//     return maps.map((map) => Fighter.fromMap(map)).toList();
//   }
// }
