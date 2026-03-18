import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/baby.dart';
import '../models/record.dart';
import '../models/growth_data.dart';
import '../models/vaccine.dart';
import '../models/milestone.dart';

class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();
  static Database? _database;

  factory DatabaseService() => _instance;

  DatabaseService._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'baby_app.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    // 宝宝表
    await db.execute('''
      CREATE TABLE babies (
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        gender TEXT NOT NULL,
        birthDate TEXT NOT NULL,
        avatarPath TEXT,
        createdAt TEXT NOT NULL,
        updatedAt TEXT NOT NULL,
        isActive INTEGER NOT NULL DEFAULT 1
      )
    ''');

    // 记录表
    await db.execute('''
      CREATE TABLE records (
        id TEXT PRIMARY KEY,
        babyId TEXT NOT NULL,
        type TEXT NOT NULL,
        startTime TEXT NOT NULL,
        endTime TEXT,
        content TEXT,
        amount REAL,
        unit TEXT,
        note TEXT,
        photoPaths TEXT,
        videoPath TEXT,
        createdAt TEXT NOT NULL,
        FOREIGN KEY (babyId) REFERENCES babies (id)
      )
    ''');

    // 生长数据表
    await db.execute('''
      CREATE TABLE growth_data (
        id TEXT PRIMARY KEY,
        babyId TEXT NOT NULL,
        date TEXT NOT NULL,
        weight REAL,
        height REAL,
        headCircumference REAL,
        note TEXT,
        createdAt TEXT NOT NULL,
        FOREIGN KEY (babyId) REFERENCES babies (id)
      )
    ''');

    // 疫苗表
    await db.execute('''
      CREATE TABLE vaccines (
        id TEXT PRIMARY KEY,
        babyId TEXT NOT NULL,
        name TEXT NOT NULL,
        description TEXT,
        doseNumber INTEGER NOT NULL,
        totalDoses INTEGER NOT NULL,
        scheduledDate TEXT,
        actualDate TEXT,
        status TEXT NOT NULL,
        note TEXT,
        createdAt TEXT NOT NULL,
        FOREIGN KEY (babyId) REFERENCES babies (id)
      )
    ''');

    // 里程碑表
    await db.execute('''
      CREATE TABLE milestones (
        id TEXT PRIMARY KEY,
        babyId TEXT NOT NULL,
        title TEXT NOT NULL,
        description TEXT,
        expectedMonth INTEGER,
        achievedDate TEXT,
        isAchieved INTEGER NOT NULL DEFAULT 0,
        photoPath TEXT,
        note TEXT,
        createdAt TEXT NOT NULL,
        FOREIGN KEY (babyId) REFERENCES babies (id)
      )
    ''');

    // 创建索引
    await db.execute('CREATE INDEX idx_records_babyId ON records(babyId)');
    await db.execute('CREATE INDEX idx_records_startTime ON records(startTime)');
    await db.execute('CREATE INDEX idx_growth_babyId ON growth_data(babyId)');
    await db.execute('CREATE INDEX idx_vaccines_babyId ON vaccines(babyId)');
    await db.execute('CREATE INDEX idx_milestones_babyId ON milestones(babyId)');
  }

  // Baby CRUD
  Future<String> insertBaby(Baby baby) async {
    final db = await database;
    await db.insert('babies', baby.toMap());
    
    // 初始化疫苗计划
    await _initVaccineSchedule(baby.id, baby.birthDate);
    // 初始化里程碑
    await _initMilestones(baby.id);
    
    return baby.id;
  }

  Future<List<Baby>> getBabies() async {
    final db = await database;
    final maps = await db.query('babies', orderBy: 'createdAt DESC');
    return maps.map((m) => Baby.fromMap(m)).toList();
  }

  Future<Baby?> getActiveBaby() async {
    final db = await database;
    final maps = await db.query(
      'babies',
      where: 'isActive = ?',
      whereArgs: [1],
      limit: 1,
    );
    if (maps.isEmpty) return null;
    return Baby.fromMap(maps.first);
  }

  Future<void> updateBaby(Baby baby) async {
    final db = await database;
    await db.update(
      'babies',
      baby.toMap(),
      where: 'id = ?',
      whereArgs: [baby.id],
    );
  }

  Future<void> setActiveBaby(String babyId) async {
    final db = await database;
    await db.transaction((txn) async {
      await txn.update('babies', {'isActive': 0});
      await txn.update(
        'babies',
        {'isActive': 1},
        where: 'id = ?',
        whereArgs: [babyId],
      );
    });
  }

  // Record CRUD
  Future<String> insertRecord(Record record) async {
    final db = await database;
    await db.insert('records', record.toMap());
    return record.id;
  }

  Future<List<Record>> getRecordsByBaby(String babyId, {int limit = 100}) async {
    final db = await database;
    final maps = await db.query(
      'records',
      where: 'babyId = ?',
      whereArgs: [babyId],
      orderBy: 'startTime DESC',
      limit: limit,
    );
    return maps.map((m) => Record.fromMap(m)).toList();
  }

  Future<List<Record>> getRecordsByDate(String babyId, DateTime date) async {
    final db = await database;
    final start = DateTime(date.year, date.month, date.day);
    final end = start.add(const Duration(days: 1));
    
    final maps = await db.query(
      'records',
      where: 'babyId = ? AND startTime >= ? AND startTime < ?',
      whereArgs: [babyId, start.toIso8601String(), end.toIso8601String()],
      orderBy: 'startTime DESC',
    );
    return maps.map((m) => Record.fromMap(m)).toList();
  }

  Future<Map<String, int>> getTodayStats(String babyId) async {
    final now = DateTime.now();
    final records = await getRecordsByDate(babyId, now);
    
    final stats = <String, int>{
      'feeding': 0,
      'sleep': 0,
      'food': 0,
      'diaper': 0,
    };
    
    for (final record in records) {
      if (stats.containsKey(record.type)) {
        stats[record.type] = stats[record.type]! + 1;
      }
    }
    
    return stats;
  }

  // Growth Data CRUD
  Future<String> insertGrowthData(GrowthData data) async {
    final db = await database;
    await db.insert('growth_data', data.toMap());
    return data.id;
  }

  Future<List<GrowthData>> getGrowthData(String babyId) async {
    final db = await database;
    final maps = await db.query(
      'growth_data',
      where: 'babyId = ?',
      whereArgs: [babyId],
      orderBy: 'date ASC',
    );
    return maps.map((m) => GrowthData.fromMap(m)).toList();
  }

  // Vaccine CRUD
  Future<String> insertVaccine(Vaccine vaccine) async {
    final db = await database;
    await db.insert('vaccines', vaccine.toMap());
    return vaccine.id;
  }

  Future<List<Vaccine>> getVaccines(String babyId) async {
    final db = await database;
    final maps = await db.query(
      'vaccines',
      where: 'babyId = ?',
      whereArgs: [babyId],
      orderBy: 'scheduledDate ASC',
    );
    return maps.map((m) => Vaccine.fromMap(m)).toList();
  }

  Future<List<Vaccine>> getPendingVaccines(String babyId) async {
    final db = await database;
    final maps = await db.query(
      'vaccines',
      where: 'babyId = ? AND status = ?',
      whereArgs: [babyId, 'pending'],
      orderBy: 'scheduledDate ASC',
    );
    return maps.map((m) => Vaccine.fromMap(m)).toList();
  }

  Future<void> completeVaccine(String vaccineId, DateTime date) async {
    final db = await database;
    await db.update(
      'vaccines',
      {
        'status': 'completed',
        'actualDate': date.toIso8601String(),
      },
      where: 'id = ?',
      whereArgs: [vaccineId],
    );
  }

  // Milestone CRUD
  Future<String> insertMilestone(Milestone milestone) async {
    final db = await database;
    await db.insert('milestones', milestone.toMap());
    return milestone.id;
  }

  Future<List<Milestone>> getMilestones(String babyId) async {
    final db = await database;
    final maps = await db.query(
      'milestones',
      where: 'babyId = ?',
      whereArgs: [babyId],
      orderBy: 'expectedMonth ASC',
    );
    return maps.map((m) => Milestone.fromMap(m)).toList();
  }

  Future<void> achieveMilestone(String milestoneId, DateTime date) async {
    final db = await database;
    await db.update(
      'milestones',
      {
        'isAchieved': 1,
        'achievedDate': date.toIso8601String(),
      },
      where: 'id = ?',
      whereArgs: [milestoneId],
    );
  }

  // 初始化疫苗计划
  Future<void> _initVaccineSchedule(String babyId, DateTime birthDate) async {
    final now = DateTime.now();
    
    for (final vaccine in standardVaccineSchedule) {
      final name = vaccine['name'] as String;
      final doses = vaccine['doses'] as int;
      final months = vaccine['months'] as List<dynamic>;
      
      for (int i = 0; i < doses; i++) {
        final month = months[i] as int;
        final scheduledDate = birthDate.add(Duration(days: month * 30));
        
        final v = Vaccine(
          id: '${babyId}_${name}_$i',
          babyId: babyId,
          name: name,
          doseNumber: i + 1,
          totalDoses: doses,
          scheduledDate: scheduledDate,
          status: scheduledDate.isBefore(now) ? 'overdue' : 'pending',
          createdAt: now,
        );
        
        await insertVaccine(v);
      }
    }
  }

  // 初始化里程碑
  Future<void> _initMilestones(String babyId) async {
    final now = DateTime.now();
    
    for (final m in standardMilestones) {
      final milestone = Milestone(
        id: '${babyId}_${m['title']}',
        babyId: babyId,
        title: m['title'] as String,
        expectedMonth: m['expectedMonth'] as int,
        createdAt: now,
      );
      
      await insertMilestone(milestone);
    }
  }

  // 关闭数据库
  Future<void> close() async {
    final db = await database;
    await db.close();
    _database = null;
  }
}
