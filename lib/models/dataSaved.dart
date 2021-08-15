import 'package:flutter/cupertino.dart';
import 'taskSaved.dart';

class DataSaved{

  List<TaskSaved> dataSaved;

  DataSaved({
    @required this.dataSaved
  });

  factory DataSaved.fromDB( Map<String, dynamic> dataSaved )
    => DataSaved(
        dataSaved : List<TaskSaved>.from(dataSaved["data"].map((x) => TaskSaved.fromDB(x))),
    );

}
