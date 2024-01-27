// ignore: depend_on_referenced_packages
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
    String path = join(await getDatabasesPath(), 'new_zikirmatik_database.db');

    _database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        db.execute('''
          CREATE TABLE zikir_table (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            count INTEGER,
            title TEXT,
            date TEXT
          )
        ''');
      },
    );
  }

  Future<int> insertZikir(int count, String text) async {
    if (!_database.isOpen) {
      throw Exception("Database not open");
    }

    final deneme = await _database.insert('zikir_table', {
      'count': count,
      'title': text,
      'date': DateTime.now().toString(),
    });
    return deneme;
  }

  Future<List<Map<String, dynamic>>> getAllZikirs() async {
    if (!_database.isOpen) {
      throw Exception("Database not open");
    }
    return _database.query('zikir_table');
  }
}
