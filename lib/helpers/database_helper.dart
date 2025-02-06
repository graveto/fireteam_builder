import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:fireteam_builder/seeds/fighter_seeds.dart';
import 'package:fireteam_builder/models/fighter.dart';
import 'package:fireteam_builder/models/team.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static Database? _database;

  DatabaseHelper._privateConstructor();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  _initDatabase() async {
    String path = join(await getDatabasesPath(), 'fireteam_builder.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE teams (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL
      )
    ''');
    await db.execute('''
      CREATE TABLE fighters (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        energyShield TEXT NOT NULL,
        role TEXT,
        sp TEXT NOT NULL,
        ra TEXT  NOT NULL,
        fi TEXT NOT NULL,
        sv TEXT NOT NULL,
        ar TEXT NOT NULL,
        hp TEXT NOT NULL
      )
    ''');
    await db.execute('''
      CREATE TABLE weapons (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        fighterId INTEGER NOT NULL,
        name TEXT NOT NULL,
        type TEXT NOT NULL,
        range TEXT NOT NULL,
        ap TEXT NOT NULL,
        keywords TEXT NOT NULL,
        FOREIGN KEY (fighterId) REFERENCES fighters (id)
      )
    ''');
    await db.execute('''
      CREATE TABLE team_fighters (
        teamId INTEGER NOT NULL,
        fighterId INTEGER NOT NULL,
        FOREIGN KEY (teamId) REFERENCES teams (id),
        FOREIGN KEY (fighterId) REFERENCES fighters (id),
        PRIMARY KEY (teamId, fighterId) 
      )
    ''');
  }

  Future<void> seedFighters() async {
    // Check if fighters are already seeded
    Database db = await instance.database;
    List<Map<String, dynamic>> existingFighters = await db.query('fighters');
    if (existingFighters.isNotEmpty) {
      return; // Fighters are already seeded
    }

    // Seed fighters
    for (var fighter in fighters) {
      await insertFighter(fighter);
    }
  }

  // Teams
  Future<int> insertTeam(Map<String, dynamic> teamData) async {
    Database db = await instance.database;
    return await db.insert('teams', teamData);
  }

  Future<List<Team>> getTeams() async {
    Database db = await instance.database;
    List<Map<String, dynamic>> teamMaps = await db.query('teams');

    // Get all team-fighter relationships in one query
    List<Map<String, dynamic>> teamFighterMaps =
        await db.query('team_fighters');

    // Create a map to group fighter IDs by team ID
    Map<int, List<int>> teamFighterIds = {};
    for (var map in teamFighterMaps) {
      int teamId = map['teamId'];
      int fighterId = map['fighterId'];
      teamFighterIds.putIfAbsent(teamId, () => []).add(fighterId);
    }

    List<Team> teams = [];
    for (var teamMap in teamMaps) {
      int teamId = teamMap['id'];
      // Get the fighter IDs for this team
      List<int> fighterIds = teamFighterIds[teamId] ?? [];

      // Fetch the actual Fighter objects *once*
      List<Fighter> teamFighters = [];
      if (fighterIds.isNotEmpty) {
        teamFighters = await getFightersByIds(fighterIds);
      }

      teams
          .add(Team(id: teamId, name: teamMap['name'], fighters: teamFighters));
    }
    return teams;
  }

  Future<List<Fighter>> getFightersByIds(List<int> fighterIds) async {
    if (fighterIds.isEmpty) return []; // Important: handle empty list

    Database db = await instance.database;
    // Use a parameterized query with '?' placeholders for each ID
    String placeholders = fighterIds.map((_) => '?').join(',');
    List<Map<String, dynamic>> fighterMaps = await db.query(
      'fighters',
      where: 'id IN ($placeholders)', // Correctly use placeholders
      whereArgs: fighterIds, // Pass the IDs as a List
    );

    return Future.wait(fighterMaps.map((fighterMap) async {
      int fighterId = fighterMap['id'];
      List<Weapon> weapons = await _getFighterWeapons(fighterId);
      return Fighter.fromMap(fighterMap, weapons);
    }));
  }

  Future<void> deleteTeam(int id) async {
    Database db = await instance.database;
    await db.delete('teams', where: 'id =?', whereArgs: [id]);
  }

  // Fighters
  Future<int> insertFighter(Fighter fighter) async {
    Database db = await instance.database;
    int fighterId = await db.insert('fighters', {
      'name': fighter.name,
      'energyShield': fighter.energyShield,
      'role': fighter.role,
      'sp': fighter.sp,
      'ra': fighter.ra,
      'fi': fighter.fi,
      'sv': fighter.sv,
      'ar': fighter.ar,
      'hp': fighter.hp,
    });

    // Insert weapons for the fighter
    for (var weapon in fighter.weapons) {
      await db.insert('weapons', {
        'fighterId': fighterId,
        'name': weapon.name,
        'type': weapon.type,
        'range': weapon.range,
        'ap': weapon.ap,
        'keywords': weapon.keywords
            .join(','), // Store keywords as comma-separated string
      });
    }

    return fighterId;
  }

  Future<List<Fighter>> getFighters() async {
    Database db = await instance.database;
    List<Map<String, dynamic>> fighterMaps = await db.query('fighters');

    // Use Future.wait to resolve all futures and return a Future<List<Fighter>>
    return Future.wait(fighterMaps.map((fighterMap) async {
      int fighterId = fighterMap['id'];
      List<Weapon> weapons = await _getFighterWeapons(fighterId);
      return Fighter.fromMap(fighterMap, weapons);
    }));
  }

  Future<Fighter> getFighter(int id) async {
    Database db = await instance.database;
    List<Map<String, dynamic>> fighterMaps = await db.query(
      'fighters',
      where: 'id =?',
      whereArgs: [id],
    );

    if (fighterMaps.isNotEmpty) {
      List<Map<String, dynamic>> weaponMaps = await db.query(
        'weapons',
        where: 'fighterId =?',
        whereArgs: [id],
      );
      List<Weapon> weapons =
          weaponMaps.map((weaponMap) => Weapon.fromMap(weaponMap)).toList();

      return Fighter.fromMap(fighterMaps[0], weapons);
    } else {
      throw Exception('Fighter not found');
    }
  }

  // Team Fighters - No change needed here, as the core logic is fine

  Future<void> insertTeamFighter(int teamId, int fighterId) async {
    Database db = await instance.database;
    await db.insert('team_fighters', {
      'teamId': teamId,
      'fighterId': fighterId,
    });
  }

  Future<List<Fighter>> getTeamFighters(int teamId) async {
    Database db = await instance.database;
    List<Map<String, dynamic>> maps = await db.rawQuery('''
      SELECT f.*
      FROM fighters f
      INNER JOIN team_fighters tf ON f.id = tf.fighterId
      WHERE tf.teamId =?
    ''', [teamId]);
    return Future.wait(maps.map((map) async {
      int fighterId = map['id'];
      List<Weapon> weapons = await _getFighterWeapons(fighterId);
      return Fighter.fromMap(map, weapons);
    }));
  }

  Future<List<Weapon>> _getFighterWeapons(int fighterId) async {
    Database db = await instance.database;
    List<Map<String, dynamic>> weaponMaps = await db.query(
      'weapons',
      where: 'fighterId =?',
      whereArgs: [fighterId],
    );
    return weaponMaps.map((weaponMap) => Weapon.fromMap(weaponMap)).toList();
  }

  Future<Team> getTeam(int id) async {
    Database db = await instance.database;
    List<Map<String, dynamic>> teamMaps = await db.query(
      'teams',
      where: 'id =?',
      whereArgs: [id],
    );

    if (teamMaps.isNotEmpty) {
      return Team(
        id: teamMaps[0]['id'],
        name: teamMaps[0]['name'],
        fighters: await getTeamFighters(id), // Fetch associated fighters
      );
    } else {
      throw Exception('Team not found');
    }
  }

  // GREATLY SIMPLIFIED updateTeam
  Future<int> updateTeam(Team team) async {
    Database db = await instance.database;

    // 1. Update the team name (if needed)
    await db.update(
      'teams',
      {'name': team.name},
      where: 'id = ?',
      whereArgs: [team.id],
    );

    // 2. Delete *all* existing fighter associations for this team
    await db.delete(
      'team_fighters',
      where: 'teamId = ?',
      whereArgs: [team.id],
    );

    // 3. Insert the new fighter associations
    for (Fighter fighter in team.fighters) {
      // Make SURE the fighter has an ID.
      await db.insert(
        'team_fighters',
        {'teamId': team.id, 'fighterId': fighter.id},
      );
    }

    return 0; // Or return team.id if you need it
  }
}
