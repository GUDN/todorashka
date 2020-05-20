import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;

class DBProvider {
  DBProvider._();

  static final DBProvider db = DBProvider._();

  Database _database;

  Future<Database> get database async {
    if (_database != null)
      return _database;
    _database = await initDB();
    return _database;
  }

  Future<Database> initDB() async {
    return await openDatabase(
      path.join(await getDatabasesPath(), 'todos.db'),
      onOpen: (db) {},
      onCreate: (db, version) async {
        await db.execute('CREATE TABLE todo ('
            'id INTEGER PRIMARY KEY,'
            'todo TEXT NOT NULL,'
            'creationTime INTEGER NOT NULL,'
            'index_ INTEGER)'
        );
      },
      version: 1
    );
  }
}