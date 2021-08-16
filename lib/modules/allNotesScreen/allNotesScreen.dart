import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import '../../models/dataSaved.dart';
import '../../shared/components/doubleTapToUndo.dart';
import '../../shared/components/selectedActionsAppbar.dart';

import '../../modules/searchScreen/searchInitScreen.dart';
import '../../shared/components/roundedButton.dart';
import '../../global/responsive.dart';
import '../../logic/service.dart';
import '../../shared/network/local/Mynode.dart';
import '../../shared/components/addNewNote.dart';
import '../../modules/allNotesScreen/allNotes.dart';

class AllNotesScreen extends StatefulWidget {

  @override
  _AllNotesScreenState createState() => _AllNotesScreenState();
}

class _AllNotesScreenState extends State<AllNotesScreen> {
  Mynode myNode = Mynode();

  DoubleTapToExit doubleTapToUndo = DoubleTapToExit();

  DataSavedService dataSavedServiceWrite;

  @override
  void initState() {
    Provider.of<DataSavedService>(context ,listen: false).getDataSaved();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    DataSavedService dataSavedServiceWrite = Provider.of<DataSavedService>(context ,listen: false);
    print('build AllNotesScreen');
    return SafeArea(child: WillPopScope(
      onWillPop: () async{
        if(dataSavedServiceWrite.selectedItemsCheckBox){
          dataSavedServiceWrite.initSelectedItems();
          dataSavedServiceWrite.setSelectedItemsCheckBox(false);
          return false;
        }else{
          return doubleTapToUndo.action(context);
        }
      },
      child: Scaffold(

        body: AllNotes(),

        floatingActionButton: AddNewNote(),

        appBar: PreferredSize(
          preferredSize: Size.fromHeight(responsive.responsiveHigh(context, 0.07)),
          child: SelectedActionsAppbar(dataSavedServiceWrite==null ?DataSaved() :dataSavedServiceWrite.dataSaved,
            title: 'Notes',
            notSelectedTrilling: RoundedButton(
                child: Icon(Icons.search_outlined,size: 20,),
                tooltip: 'Search',
                onPressed: (){
                  Navigator.push(context, CupertinoPageRoute(builder: (_)=> SearchInitScreen()));
                }),
            appearSelectAll: true,
          )
        )
      ),
    ));
  }
}