
import 'package:flutter/cupertino.dart';

class TaskSaved{

  final int    id;
  final String name;
  final String content;
  final String color;
  final String fontColor;
  final String date;
  final String lastUpdate;

  TaskSaved({
    @required this.id,
    @required this.name,
    @required this.content,
    @required this.color,
    @required this.fontColor,
    @required this.date,
    @required this.lastUpdate,
  });

  factory TaskSaved.fromDB( Map<String, dynamic> dataSaved )=>
      TaskSaved(
        id: dataSaved['id'],
        name: dataSaved['name'],
        content: dataSaved['content'],
        color: dataSaved['color'],
        fontColor: dataSaved['fontColor'],
        date: dataSaved['date'],
        lastUpdate: dataSaved['lastUpdate'],);

}
