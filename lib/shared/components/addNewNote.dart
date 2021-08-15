import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../styles/appClrs.dart';
import '../../modules/allNotesScreen/allNotesScreen.dart';
import '../../shared/components/appDialog.dart';
import '../../logic/mainProv.dart';
import '../network/local/Mynode.dart';
import '../../modules/allNotesScreen/noteFildesStruc.dart';

class AddNewNote extends StatefulWidget {

  @override
  _AddNewNoteState createState() => _AddNewNoteState();
}

class _AddNewNoteState extends State<AddNewNote> {
  TextEditingController titleCtrl = TextEditingController();

  TextEditingController contextCtrl = TextEditingController();

  Mynode myNode = Mynode();

  bool isEmptyInput()
  => contextCtrl.text.trim().isEmpty || contextCtrl.text.trim().isEmpty;

  bool updateState = true;


  @override
  Widget build(BuildContext context) {
    return Consumer<MainProv>(
      builder: (_,prov,__)=> FloatingActionButton(
        backgroundColor: appClrs.mainColor,
        child: Text('\uFF0B' ,style: TextStyle(fontWeight: FontWeight.w900 ,color: Colors.black),),
        heroTag: 'add',
        onPressed: () async{
          prov.resetClr();

          await Navigator.push(context, MaterialPageRoute(
              builder: (context) =>
                NoteFildesStruc(
                  titleCtrl: titleCtrl,
                  contextCtrl: contextCtrl,
                  titleFillColor: prov.clr,
                  editState: true,
                  addNewNote: true,
                  appDialog: AppDialog(
                    screenCtx: context,
                    content: 'If you back your updates will lose',
                    doneActionTitle: 'Back',
                    doneAction: (){
                      Navigator.pushReplacement(context, CupertinoPageRoute(builder: (_) => AllNotesScreen()));
                    },
                  ),
                  savedFunction:()async{
                    await myNode.insertRow(context ,name:titleCtrl.text ,content:contextCtrl.text , color: '${prov.clr.value}');
                    Navigator.pushReplacement(context, CupertinoPageRoute(builder: (_) => AllNotesScreen()));
                  },
                ),
              )
          ).then((value){
            prov.resetAppearWheel(false);
            //prov.resetClr();
          });
        },
      ),
    );
  }
}
