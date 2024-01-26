import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class CounterDatabaseHelper {
  static CounterDatabaseHelper? _instance;
  late Database _database;

  CounterDatabaseHelper._privateConstructor();

  factory CounterDatabaseHelper() {
    if (_instance == null) {
      _instance = CounterDatabaseHelper._privateConstructor();
    }
    return _instance!;
  }

  Future<void> initializeDatabase() async {
    String path = join(await getDatabasesPath(), 'zikirmatik_database.db');

    _database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        db.execute('''
          CREATE TABLE zikir_table (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            count INTEGER
          )
        ''');
      },
    );
  }

  Future<int> insertZikir(int count) async {
    if (!_database.isOpen) {
      throw Exception("Database not open");
    }
    return await _database.insert('zikir_table', {'count': count});
  }

  Future<List<Map<String, dynamic>>> getAllZikirs() async {
    if (!_database.isOpen) {
      throw Exception("Database not open");
    }
    return await _database.query('zikir_table');
  }
}
