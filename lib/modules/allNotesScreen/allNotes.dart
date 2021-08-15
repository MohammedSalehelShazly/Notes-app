import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../shared/network/local/Mynode.dart';
import '../../logic/service.dart';
import '../../shared/components/noHaveTasks.dart';
import '../../shared/components/NoteItem.dart';

class AllNotes extends StatelessWidget {

  Mynode myNode = Mynode();

  @override
  Widget build(BuildContext context) {

    DataSavedService dataSavedService = Provider.of<DataSavedService>(context);
    DataSavedService dataSavedServiceWrite = Provider.of<DataSavedService>(context ,listen: false);

    return
      dataSavedServiceWrite.dataSaved == null ? Center(child: CupertinoActivityIndicator(),)
          :
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child:
        dataSavedServiceWrite.dataSaved.dataSaved.isEmpty
            ? Center(child: NoHaveTasks('You haven\'t any notes yet'))
            :
        Scrollbar(
          child: ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: dataSavedServiceWrite.dataSaved.dataSaved.length,
            itemBuilder: (context ,index){

              return Row(
                children: [
                  Expanded(child: NoteItem(taskSaved: dataSavedService.dataSaved.dataSaved[index])),

                  Consumer<DataSavedService>(
                      builder:(_,prov,__)
                      =>
                          AnimatedSwitcher(
                            duration: Duration(milliseconds: 600),
                            reverseDuration: Duration(milliseconds: 100),
                            transitionBuilder: (Widget child, Animation<double> animation) {
                              return ScaleTransition(scale: animation, child: child);
                            },
                            child: !prov.selectedItemsCheckBox ?
                            SizedBox()
                                :
                            Checkbox(
                              visualDensity: VisualDensity.compact,
                              value: prov.selectedItems[prov.dataSaved.dataSaved[index].id],
                              onChanged: (val){
                                prov.setSelectedItems(prov.dataSaved.dataSaved[index].id , val);
                              },
                            ),
                          ))
                ],
              );
                        }),
                  ),
          );
  }
}
