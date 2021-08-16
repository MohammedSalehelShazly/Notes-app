import 'package:flutter/cupertino.dart';

import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../../../logic/service.dart';


class Mynode {

  initialDB() async {
    var docDir = await getDatabasesPath();
    String path = join(docDir, 'notes.db');
    Database database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
          await db.execute(
            'CREATE TABLE notesTable (id INTEGER PRIMARY KEY, name TEXT, content TEXT, color TEXT ,date TEXT ,lastUpdate TEXT)',);
        });
    return database;
  }

  static Database _db ;
  Future<Database> get db async{
    if(_db == null)
      _db = await initialDB();
    return _db;
  }



  deleteAll(BuildContext context) async{
    Database myDB = await db;
    var delete = await myDB.delete('notesTable');
    /// update old lists ,to add new (note) to them
    Provider.of<DataSavedService>(context ,listen: false).searchNotes();
    await  Provider.of<DataSavedService>(context ,listen: false).getDataSaved();
    Provider.of<DataSavedService>(context ,listen: false).searchNotes();
    return delete;
  }

  deleteSomeNotes(BuildContext context ,List<int> idList) async{
    Database myDB = await db;
    var del;
    for(int i=0 ;i<idList.length ;i++){
      del = await myDB.delete('notesTable' ,where: 'id = "${idList[i]}"');
    }
    /// update old lists ,to add new (note) to them
    Provider.of<DataSavedService>(context ,listen: false).searchNotes();
    await  Provider.of<DataSavedService>(context ,listen: false).getDataSaved();
    Provider.of<DataSavedService>(context ,listen: false).searchNotes();
    return del;
  }

  Future<List<Map<String, dynamic>>> showOldValues() async{
    Database myDB = await db;
    return myDB.rawQuery('SELECT * FROM notesTable') ;
  }


  insertRow(BuildContext context ,{@required String name, @required String content, @required String color}) async {
    Database myDB = await db;
    var insert = await myDB.insert('notesTable', {
      'name' : name,
      'content' : content,
      'color' : color,
      'date' : "${DateTime.now()}",
      'lastUpdate' : "${DateTime.now()}"
    });
    /// update old lists ,to add new (note) to them
    Provider.of<DataSavedService>(context ,listen: false).searchNotes();
    await  Provider.of<DataSavedService>(context ,listen: false).getDataSaved();
    Provider.of<DataSavedService>(context ,listen: false).searchNotes();
    return insert;
  }

  updateNote(BuildContext context ,int id ,{@required String name, @required String content, @required String color}) async{
    Database init = await db;
    var update = await init.update('notesTable', {
      'name' : name,
      'content' : content,
      'color' : color,
      'lastUpdate' : "${DateTime.now()}",
    },
      where: 'id = "$id"'
    );
    /// update old lists ,to add new (note) to them
    Provider.of<DataSavedService>(context ,listen: false).searchNotes();
    await  Provider.of<DataSavedService>(context ,listen: false).getDataSaved();
    Provider.of<DataSavedService>(context ,listen: false).searchNotes();
    return update;
  }

}