import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import '../../shared/components/selectedActionsAppbar.dart';

import '../../global/responsive.dart';
import '../../modules/allNotesScreen/allNotesScreen.dart';
import '../../shared/network/local/Mynode.dart';
import '../../logic/service.dart';
import '../../shared/components/noHaveTasks.dart';
import '../../shared/components/NoteItem.dart';

class SearchNotesResults extends StatelessWidget {

  String searchWorld;
  SearchNotesResults(this.searchWorld);

  Mynode myNode = Mynode();
  DataSavedService dataSavedService;
  DataSavedService dataSavedServiceWrite;

  @override
  Widget build(BuildContext context) {
    if(dataSavedServiceWrite==null){
      dataSavedService = Provider.of<DataSavedService>(context);
      dataSavedServiceWrite = Provider.of<DataSavedService>(context ,listen: false);
    }
    return WillPopScope(
      onWillPop: () async{
        if(dataSavedServiceWrite.selectedItemsCheckBox){
          dataSavedServiceWrite.initSelectedItems();
          dataSavedServiceWrite.setSelectedItemsCheckBox(false);
          return false;
        }
        else{
          dataSavedServiceWrite.setSearchWord('');
            Navigator.pushReplacement(context, CupertinoPageRoute(builder: (_)=> AllNotesScreen()));
            return false;
        }
      },
      child: SafeArea(
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(
                dataSavedServiceWrite.dataSavedSearch.dataSaved.isEmpty ? 0
                    : responsive.responsiveHigh(context, 0.07)),
            child: dataSavedServiceWrite.dataSavedSearch.dataSaved.isEmpty
                ? SizedBox()
                : SelectedActionsAppbar(dataSavedServiceWrite.dataSavedSearch,
              title: 'Results about ($searchWorld)',
              leading: IconButton(icon: Icon(Icons.arrow_back_ios_outlined), onPressed: (){
                if(dataSavedServiceWrite.selectedItemsCheckBox){
                  dataSavedServiceWrite.initSelectedItems();
                  dataSavedServiceWrite.setSelectedItemsCheckBox(false);
                }
                else{
                  dataSavedServiceWrite.setSearchWord('');
                  Navigator.pushReplacement(context, CupertinoPageRoute(builder: (_)=> AllNotesScreen()));
                }
                },
              ),
            )
          ),

            body: dataSavedServiceWrite.dataSavedSearch == null ? Center(child: CupertinoActivityIndicator(),)
                :
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child:
                dataSavedServiceWrite.dataSavedSearch.dataSaved.isEmpty
                    ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                      NoHaveTasks('We can\'t find any notes matches with your search'),
                    TextButton(
                          onPressed: ()=>Navigator.pushReplacement(context, CupertinoPageRoute(builder: (_)=> AllNotesScreen())),
                          child: Text('Browse notes',))
                  ],
                ),
                    )
                    :
                Scrollbar(
                  child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: dataSavedServiceWrite.dataSavedSearch.dataSaved.length,
                      itemBuilder: (context ,index){

                        return Row(
                          children: [
                            Expanded(child: NoteItem(taskSaved: dataSavedService.dataSavedSearch.dataSaved[index])),

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
                                        value: prov.selectedItems[prov.dataSavedSearch.dataSaved[index].id],
                                        onChanged: (val){
                                          prov.setSelectedItems(prov.dataSavedSearch.dataSaved[index].id , val);
                                        },
                                      ),
                                    ))
                          ],
                        );
                      }),
                ),
              ),
            )
        ),
      ),
    );
  }
}
