import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._internal();

  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    debugPrint('Initializing database');
    final path = join(await getDatabasesPath(), 'app_database.db');
    return openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE tasks (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        slug TEXT,
        url TEXT,
        title TEXT NOT NULL,
        content TEXT NOT NULL,
        image TEXT,
        thumbnail TEXT,
        status TEXT,
        category TEXT,
        publishedAt TEXT,
        updatedAt TEXT,
        userId INTEGER
      )
      ''');
  }

  Future<int> insertTask(Map<String, dynamic> task) async {
    try {
      final db = await database;
      return db.insert('tasks', task);
    } catch (e) {
      return 0;
    }
  }

  Future<int> updateTask(Map<String, dynamic> task) async {
    try {
      final db = await database;
      final id = task['id'];
      return db.update('tasks', task, where: 'id = ?', whereArgs: [id]);
    } catch (e) {
      debugPrint('Error updating task: $e');
      return 0;
    }
  }

  Future<int> deleteTask(int id) async {
    try {
      final db = await database;
      return db.delete('tasks', where: 'id = ?', whereArgs: [id]);
    } catch (e) {
      debugPrint('Error deleting task: $e');
      return 0;
    }
  }

  Future<List<Map<String, dynamic>>> getTasks() async {
    try {
      final db = await database;
      return db.query('tasks');
    } catch (e) {
      debugPrint('Error fetching tasks: $e');
      return [];
    }
  }
}
