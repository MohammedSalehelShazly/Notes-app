import 'package:flutter/cupertino.dart';

import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../../../logic/service.dart';


class Mynode {

  initialDB() async {
    var docDir = await getDatabasesPath();
    String path = join(docDir, 'tasks.db');
    Database database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
          await db.execute(
            'CREATE TABLE Test (id INTEGER PRIMARY KEY, name TEXT, content TEXT, color TEXT ,date TEXT ,lastUpdate TEXT)',);
        });
    return database;
  }

  deleteAll(BuildContext context) async{
    Database init = await initialDB();
    var delete = await init.delete('Test');
    /// update old lists ,to add new (note) to them
    Provider.of<DataSavedService>(context ,listen: false).searchNotes();
    await  Provider.of<DataSavedService>(context ,listen: false).getDataSaved();
    Provider.of<DataSavedService>(context ,listen: false).searchNotes();
    return delete;
  }

  deleteSomeNotes(BuildContext context ,List<int> idList) async{
    Database init = await initialDB();
    var del;
    for(int i=0 ;i<idList.length ;i++){
      del = await init.delete('Test' ,where: 'id = "${idList[i]}"');
    }
    /// update old lists ,to add new (note) to them
    Provider.of<DataSavedService>(context ,listen: false).searchNotes();
    await  Provider.of<DataSavedService>(context ,listen: false).getDataSaved();
    Provider.of<DataSavedService>(context ,listen: false).searchNotes();
    return del;
  }

  Future<List<Map<String, dynamic>>> showOldValues() async{
    Database init = await initialDB();
    return init.rawQuery('SELECT * FROM Test') ;
  }


  insertRow(BuildContext context ,{@required String name, @required String content, @required String color}) async {
    Database db = await initialDB();
    var insert = await db.insert('Test', {
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

  /// ================================================================================================================================================================


  selectCustomTask(int index) async{
    var init = await initialDB();
    var selection = await init.rawQuery('SELECT name, content,color FROM Test') ;
    return selection[index];
  }

  updateNote(BuildContext context ,int id ,{@required String name, @required String content, @required String color}) async{
    Database init = await initialDB();
    var update = await init.update('Test', {
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