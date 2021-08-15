import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../modules/allNotesScreen/noteFildesStruc.dart';
import '../../shared/components/appDialog.dart';
import '../../global/responsive.dart';
import '../../shared/network/local/Mynode.dart';
import '../../global/staticVariables.dart';
import '../../models/taskSaved.dart';
import '../../logic/mainProv.dart';
import 'allNotesScreen.dart';

class NoteItemDetails extends StatefulWidget {

  TaskSaved taskSaved;
  NoteItemDetails(this.taskSaved);

  @override
  _NoteItemDetailsState createState() => _NoteItemDetailsState();
}

class _NoteItemDetailsState extends State<NoteItemDetails> {
  TextEditingController titleCtrl ;

  TextEditingController contextCtrl;

  StaticVars staticVars = StaticVars();

  Mynode myNode = Mynode();

  bool updateState = false;

  @override
  Widget build(BuildContext context) {
    if(titleCtrl ==null){
      titleCtrl = TextEditingController(text: widget.taskSaved.name??'');
      contextCtrl = TextEditingController(text: widget.taskSaved.content??'');
    }
    return Consumer<MainProv>(
      builder: (_,prov,__)=>NoteFildesStruc(
        titleCtrl: titleCtrl,
        contextCtrl: contextCtrl,
        titleFillColor: prov.enableEdit ? prov.clr :Color(int.parse(widget.taskSaved.color)),
        editState: prov.enableEdit,
        addNewNote: false,
        appDialog: AppDialog(
          screenCtx: context,
          content: 'If you back your note will lose',
          doneActionTitle: 'Back',
          doneAction:(){
            Navigator.push(context, CupertinoPageRoute(builder: (_) => AllNotesScreen()));
          },),
        savedFunction: ()async{
          await myNode.updateNote(
              context,
              widget.taskSaved.id,
              name: titleCtrl.text,
              content: contextCtrl.text,
              color: '${prov.clr.value}');
          Navigator.pop(context);
        },
        nameSaved: widget.taskSaved.name,
        contentSaved: widget.taskSaved.content,
        clrSaved: widget.taskSaved.color,
      ),
    );
  }
}




