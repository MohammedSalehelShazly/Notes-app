import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

import '../../global/responsive.dart';
import '../../global/timeFormatter.dart';
import '../../logic/service.dart';
import '../../models/taskSaved.dart';
import '../../modules/allNotesScreen/noteItemDetails.dart';
import '../../logic/mainProv.dart';

class NoteItem extends StatelessWidget {

  TaskSaved taskSaved;
  NoteItem({@required this.taskSaved});

  bool timeDataEqualUpdateDate()
      => DateTime.parse(taskSaved.date).hour + DateTime.parse(taskSaved.date).minute + DateTime.parse(taskSaved.date).second
          == DateTime.parse(taskSaved.lastUpdate).hour + DateTime.parse(taskSaved.lastUpdate).minute + DateTime.parse(taskSaved.lastUpdate).second;

  @override
  Widget build(BuildContext context) {
    return Consumer<MainProv>(
      builder:(_,prov,__)=> InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: () async{
          prov.changeClr(Color(int.parse(taskSaved.color)));
          prov.setEnableEdit(false);

          await Navigator.push(context, CupertinoPageRoute(builder: (_)=>NoteItemDetails(taskSaved))).then((value){
            prov.resetAppearWheel(false);
          });
        },
        onLongPress: (){
          if( !Provider.of<DataSavedService>(context ,listen: false).selectedItemsCheckBox){
            Provider.of<DataSavedService>(context ,listen: false).setSelectedItemsCheckBox(true);
            Provider.of<DataSavedService>(context ,listen: false).setSelectedItems(taskSaved.id, true);
          }
        },
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 5),
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: Color(int.parse( taskSaved.color )),
          ),
          child: Column(children: [
              Text(
                taskSaved.name,
                maxLines: 1,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: responsive.textScale(context)*17,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff000000)),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 3),
                alignment: Alignment.centerLeft,
                child: Text(
                  taskSaved.content,
                  softWrap: true,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.start,
                  style: TextStyle(color: Color(0xff000000))
                ),
              ),
              Row(
              children: [
                Expanded(
                  child: TimeFormatter(isEng: true, localTime24: DateTime.parse(taskSaved.date),).timeFormat(textStyle: TextStyle(color: Colors.black54),),
                ),

                if(!timeDataEqualUpdateDate())
                  Text('last edit: ' ,style: TextStyle(color: Color(0xff000000)),maxLines: 1,),

                if(!timeDataEqualUpdateDate())
                  TimeFormatter(isEng: true, localTime24: DateTime.parse(taskSaved.lastUpdate),).timeFormat(textStyle: TextStyle(color: Colors.black54)),
            ],),

          ],),
        ),
      ),
    );
  }
}




