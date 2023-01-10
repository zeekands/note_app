import 'dart:developer';

import 'package:note_app/app/data/notes_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static final DBHelper _instance = DBHelper._internal();
  static Database? _database;

  final String tableName = "tableNotes";
  final String columnId = "id";
  final String columnTitle = "title";
  final String columnDescription = "description";
  final String columnTime = "time";
  final String columnFile = "file";
  final String columnInterval = "interval";
  final String columnIsReminder = "isReminder";

  DBHelper._internal();
  factory DBHelper() => _instance;

  Future<Database?> get _db async {
    if (_database != null) {
      return _database;
    }
    _database = await _initDb();
    return _database;
  }

  Future<Database?> _initDb() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'notes_db');

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    var sql = "CREATE TABLE $tableName($columnId INTEGER PRIMARY KEY,"
        "$columnTitle TEXT,"
        "$columnDescription TEXT,"
        "$columnTime TEXT,"
        "$columnFile TEXT,"
        "$columnInterval TEXT,"
        "$columnIsReminder TEXT);";
    await db.execute(sql);
  }

  Future<int?> saveNotes(NotesModel notes) async {
    var dbClient = await _db;
    return await dbClient!.insert(tableName, notes.toJson());
  }

  Future<List?> getAllNotes() async {
    var dbClient = await _db;
    var result = await dbClient!.query(tableName, columns: [
      columnId,
      columnTitle,
      columnDescription,
      columnTime,
      columnFile,
      columnInterval,
      columnIsReminder,
    ]);
    return result.toList();
  }

  Future<int?> updateNotes(NotesModel notes) async {
    var dbClient = await _db;
    return await dbClient!.update(tableName, notes.toJson(),
        where: '$columnId = ?', whereArgs: [notes.id]);
  }

  Future<int?> deleteNotes(int id) async {
    var dbClient = await _db;
    return await dbClient!
        .delete(tableName, where: '$columnId = ?', whereArgs: [id]);
  }
}
