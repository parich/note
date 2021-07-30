import 'package:sqflite/sqflite.dart' as sqlite;
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart' as path;

class DBHelper {
  static Future<Database> dbInit() async {
    final folder = await sqlite.getDatabasesPath();

    print(folder);

    return sqlite.openDatabase(path.join(folder, "note.db"), version: 1,
        onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE notes (id TEXT PRIMARY KEY, title TEXT, subject TEXT, created TEXT, favorite INTEGER)');
    });
  }

  static Future<void> insert(String table, Map<String, dynamic> value) async {
    final db = await DBHelper.dbInit();

    db.insert(table, value,
        conflictAlgorithm: sqlite.ConflictAlgorithm.replace);
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await DBHelper.dbInit();
    return db.query(table);
  }
}

class DeleteDb {
  static void del(String table) async {
    final folder = await sqlite.getDatabasesPath();
    await sqlite.deleteDatabase(path.join(folder, table));
  }
}
