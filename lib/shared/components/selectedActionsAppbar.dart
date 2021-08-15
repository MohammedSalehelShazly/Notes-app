import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import '../../models/dataSaved.dart';

import '../../global/responsive.dart';
import '../../logic/service.dart';
import '../../shared/components/roundedButton.dart';
import '../../shared/network/local/Mynode.dart';
import 'appDialog.dart';

class SelectedActionsAppbar extends StatelessWidget {

  final DataSaved dataSaved;
  final String title;
  final Widget notSelectedTrilling;
  final Widget leading;
  bool appearSelectAll;

  SelectedActionsAppbar(this.dataSaved ,{
    @required this.title,
    @required this.notSelectedTrilling,
    this.leading,
    this.appearSelectAll = false
  });

  final Mynode myNode = Mynode();

  @override
  Widget build(BuildContext context) {
    return Consumer<DataSavedService>(
      builder:(_,prov,__)=> AppBar(
        automaticallyImplyLeading: false,
        title: AnimatedSwitcher(
          duration: Duration(milliseconds: 600),
          transitionBuilder: (Widget child, Animation<double> animation) {
            return ScaleTransition(scale: animation, child: child);
          },
          child: !prov.selectedItemsCheckBox
              ? Row(
            key: ValueKey('1'),
            mainAxisAlignment: leading!=null&& notSelectedTrilling==null ? MainAxisAlignment.start :MainAxisAlignment.spaceBetween,
            children: [

              if(leading !=null)
                leading,

              Text(title ,style: TextStyle(fontWeight:FontWeight.w500 ,fontSize: responsive.textScale(context)*22 ,color: Colors.black),textAlign: TextAlign.left,),

              if(notSelectedTrilling !=null)
                notSelectedTrilling

            ],
          )

              : Row(
            key: ValueKey('2'),
            mainAxisAlignment: !appearSelectAll? MainAxisAlignment.start :MainAxisAlignment.spaceBetween,
            children: [
              RoundedButton(
                child: Icon(Icons.delete_outline ,color: Colors.red ,size: 22,),
                tooltip: 'Delete',
                onPressed: (){
                  print(prov.listOfSelectedID());
                  showCupertinoDialog(context: context, builder: (_)=> AppDialog(
                    screenCtx: context,
                    content: 'If you delete ${prov.selectedItemsCheckBox ?"selected" :"all"} notes, you won\'t be able to return your notes again.',
                    doneActionTitle: 'Delete',
                    doneAction:() async{
                      if(prov.selectedItemsCheckBox)
                        await myNode.deleteSomeNotes(context , prov.listOfSelectedID());
                      else
                        await myNode.deleteAll(context);

                      prov.setSelectedItemsCheckBox(false);
                      Navigator.pop(context);
                    },
                  ));
                },
              ),
              RoundedButton(
                child: Icon(Icons.share_outlined ,size: 20,),
                tooltip: 'Share',
                onPressed:(){
                  print(prov.listOfSelectedID());
                  Share.share(
                    prov.selectedNotes(dataSaved.dataSaved).map((e)
                    => e.name +'\n'+ e.content +'\n--------------------------------'+'\n'
                    ).toString()

                        +'\n'+ 'Written by Notes app ,connect us .. https://www.linkedin.com/in/ma7mad-salle7-6162261a3/',
                  );
                },
              ),

              if(appearSelectAll)
                Expanded(child: Align(
                  alignment: Alignment.centerRight,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Theme(
                        data: ThemeData(
                            unselectedWidgetColor: Colors.black.withOpacity(0.7)
                        ),
                        child: Checkbox(
                          value: prov.selectAll,
                          onChanged: (val){
                            prov.reverseSelectAll();
                            print('listOfSelectedID ${prov.listOfSelectedID()}');
                          },
                          visualDensity: VisualDensity.compact,
                        ),
                      ),
                      Text('All' ,style: TextStyle(fontSize: 10 ,color: Colors.black87.withOpacity(0.7)),),
                    ],
                  ),
                ),)
            ],),
        ),



      ),
    );
  }
}
