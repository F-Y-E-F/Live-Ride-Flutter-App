import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDB();
    return _db;
  }

  Future<Database> initDB() async {
    final dbPath = await getDatabasesPath();
    return await openDatabase(join(dbPath, 'trips.db'),
        version: 1,
        onCreate: (database, version) => database.execute(
            "CREATE TABLE trips(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, color TEXT,averageSpeed REAL, distance REAL, maxSpeed REAL, altitude REAL,duration INTEGER, calories INTEGER, startTime TEXT, endTime TEXT, coordinatesList TEXT)"));
  }
}
