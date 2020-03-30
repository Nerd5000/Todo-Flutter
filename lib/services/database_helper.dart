import 'package:sqflite/sqflite.dart';
import 'package:todoapp/models/todo.dart';

class DatabaseHelper {
  Database _database;
  dynamic getPath() async {
    var databasesPath = await getDatabasesPath();
    String path = '${databasesPath}todo.db';
    return path;
  }

  Future<void> openDatabaseCU() async {
    _database = await openDatabase(await getPath(), version: 1,
        onCreate: (Database db, int version) async {
      // When creating the db, create the table
      await db.execute(
          'CREATE TABLE Todo (id INTEGER PRIMARY KEY, todo TEXT,day TEXT)');
    });
  }

  Future<void> insertDataCU(Todo todo) async {
    await _database.transaction((txn) async {
      //returns the id of the record
      int id = await txn.rawInsert(
          'INSERT INTO Todo(todo, day) VALUES(?, ?)', [todo.todo, todo.day]);
      print('inserted1: $id');
    });
  }

  Future<void> update() async {
    // returns the number of updated records
    int count = await _database.rawUpdate(
        'UPDATE Test SET name = ?, value = ? WHERE name = ?',
        ['updated name', '9876', 'some name']);
    print('updated: $count');
  }

  Future<List> read() async {
    //returns a list of Map<columnName,value>
    List<Map> list = await _database.rawQuery('SELECT * FROM Todo');
    print(list);
    return list.toList();
  }

  Future<void> delete(Todo todo) async {
    //returns a number of deleted records
    int count = await _database.rawDelete(
        'DELETE FROM Todo where day=? and todo = ?', [todo.day, todo.todo]);
    print('deleted : $count');
  }
}
