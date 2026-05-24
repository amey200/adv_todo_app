
import "package:sqflite/sqflite.dart";
import "package:path/path.dart";

class TodoDatabase {
  //create database
  Future<Database> createDB() async{
    Database db = await openDatabase(
      join(await getDatabasesPath(), "TodoDB.db",
      ),
      version: 1,
      onCreate: (db, version) {
        db.execute(
          '''
            create table Todo(
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              title text,
              description text,
              date text
            )

          '''
        );
      },
    );

    return db;
  }
  
  //getData
  Future<List<Map>> getTodoItems() async{
    Database localDb = await createDB();

    List<Map> list = await localDb.query("Todo");
    return list;
  }

  //Add Data
  void insertTodoItem(Map<String, dynamic> obj) async{
    Database localDb = await createDB();
    
    await localDb.insert("Todo", obj,
    conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  //Update Data
  Future<void> updateTodoItem(Map<String, dynamic> obj) async{
    Database localDb = await createDB();

    await localDb.update("Todo", obj, where: 'id=?',whereArgs: [obj['id']]);
  }

  //Delete Data
  Future<void> deleteTodoItem(int index) async{
    Database localDb = await createDB();

    await localDb.delete("Todo", where: "id=?", whereArgs: [index]);
  }
}