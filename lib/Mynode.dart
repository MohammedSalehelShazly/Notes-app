

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io' as io;
import 'package:async/async.dart';


class Mynode {

  String _externalName;


  set externalName(String value) {
    _externalName = value;
  }

  String get externalName => _externalName;





  initialDB() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'tasks.db');
    Database database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
          await db.execute(
            'CREATE TABLE Test (id INTEGER PRIMARY KEY, name TEXT, content TEXT, color TEXT ,fontColor Text ,date TEXT ,lastUpdate TEXT)',);
        });
    return database;
  }


  /*Future getAll(atrbuiets) async {
    var x = await insertRow(atrbuiets);
    var y = await x.rawQuery('SELECT * FROM Test');
    return y;
  }*/

  deleteAll() async{
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'tasks.db');
    var delAction = await deleteDatabase(path);
    return delAction;
  }

  deleteOneTask(String dateDeleted) async{
    var init = await initialDB();
    var del = await init.rawQuery('DELETE FROM Test WHERE date="$dateDeleted"') ; // because index of LisView != id
    return del;
  }



  showOldValues() async{
    var init = await initialDB();
    return init.rawQuery('SELECT * FROM Test') ;
  }

  insertRow(Map <String,dynamic> atrbuiets) async {
    var db = await initialDB();
    await db.transaction((txn) async {
      await txn.rawInsert(
          'INSERT INTO Test(name, content, color ,fontColor ,date ,lastUpdate) VALUES("${atrbuiets['name']}", "${atrbuiets['content']}", "${atrbuiets['color']}" , "${atrbuiets['fontColor']}" , "${atrbuiets['date'] }" , "${atrbuiets['lastUpdate'] }")');
    });

    var y = await db.rawQuery('SELECT * FROM Test');
    return y;
  }


  selectCustomTask(int index) async{
    var init = await initialDB();
    var selection = await init.rawQuery('SELECT name, content,color FROM Test') ;
    return selection[index];
  }

  updateNote(atrbuiets , _date) async{
    Database init = await initialDB();

    await init.transaction((txn) async {
      await txn.update( 'date = $_date' , {
        'name' : "${atrbuiets['name']}",
        'content' : "${atrbuiets['content']}",
        'color' : "${atrbuiets['color']}",
        'fontColor' : "${atrbuiets['fontColor']}",
        'lastUpdate' : "${atrbuiets['lastUpdate']}",
      });
    });
    return init;
  }










/*


// Update some record
    int count = await database.rawUpdate(
        'UPDATE Test SET name = ?, value = ? WHERE name = ?',
        ['updated name', '9876', 'some name']);
    print('updated: $count');

// Get the records
    List<Map> list = await database.rawQuery('SELECT * FROM Test');
    List<Map> expectedList = [
      {'name': 'updated name', 'id': 1, 'value': 9876, 'num': 456.789},
      {'name': 'another name', 'id': 2, 'value': 12345678, 'num': 3.1416}
    ];

    print(list);
    print(expectedList);
    //assert(const DeepCollectionEquality().equals(list, expectedList));

// Count the records
    count = Sqflite
        .firstIntValue(await database.rawQuery('SELECT COUNT(*) FROM Test'));
    assert(count == 2);

// Delete a record
    count = await database
        .rawDelete('DELETE FROM Test WHERE name = ?', ['another name']);
    assert(count == 1);
*/

// Close the database
//    await database.close();



}