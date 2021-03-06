import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static Database _db;

  static Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDB();
    return _db;
  }

  static Future<Database> initDB() async {
    final dbPath = await getDatabasesPath();
    return await openDatabase(join(dbPath, 'trips.db'),
        version: 1,
        onCreate: (database, version) => database.execute(
            "CREATE TABLE trips(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, name TEXT, color TEXT,averageSpeed REAL, distance REAL, maxSpeed REAL, altitude REAL,duration INTEGER, calories INTEGER, startTime TEXT, endTime TEXT, coordinatesList TEXT)"));
  }


  static Future<void> insertTrip(String table, Map<String,dynamic> data) async{
     final database = await db;
     database.insert(table, data, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<List<Map<String,dynamic>>> getAllTrips(String table) async{
    final database = await db;
    return database.query(table);
  }
}
