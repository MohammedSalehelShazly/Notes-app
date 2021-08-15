import 'package:flutter/cupertino.dart';
import '../models/taskSaved.dart';
import '../shared/network/local/Mynode.dart';
import '../models/dataSaved.dart';

class DataSavedService with ChangeNotifier{

  DataSaved dataSaved;

  Future<void> getDataSaved() async{
    print('getData');
    await Mynode().showOldValues().then((value){
      dataSaved = DataSaved.fromDB({"data" : value});
      // to saved new data to map
      initSelectedItems();

      notifyListeners();
    });
  }


  /// select && selectAll

  bool selectedItemsCheckBox = false;
  setSelectedItemsCheckBox(bool _selectedItemsCheckBox){
    selectedItemsCheckBox = _selectedItemsCheckBox;
    notifyListeners();
  }

  Map<int ,bool> selectedItems;

  initSelectedItems(){
      selectedItems = Map.fromIterable(dataSaved.dataSaved,
          key: (e) =>e.id,
          value: (e) => false
      );
      selectedItems.updateAll((key, value) => false);
    notifyListeners();
  }
  setSelectedItems(int id ,bool newValue){
    selectedItems.update(id, (value) => newValue);
    if( !selectedItems.values.toList().contains(false)){ /// all true
      reverseSelectAll();
    }
    else if(selectAll){
      selectAll = !selectAll;
    }
    notifyListeners();
  }

  bool selectAll = false;
  reverseSelectAll(){
    selectAll = !selectAll;
    selectedItems.updateAll((key, value) => selectAll);
    notifyListeners();
  }

  List<int> listOfSelectedID(){
    List<int> list = [];
    selectedItems.forEach((key, value) {
      if(value == true){
        list.add(key);
      }
    });
    return list;
  }

  List<TaskSaved> selectedNotes(List<TaskSaved> data){
    List<TaskSaved> list =[];
    for(int i=0 ; i<listOfSelectedID().length ;i++){
      for( int dataIndex=0 ;dataIndex< data.length ;dataIndex++){
        if(data[dataIndex].id == listOfSelectedID()[i])
          list.add(data[dataIndex]);
      }
    }
    return list;
  }

  //.........................//

/// search

  String searchWord ='';
  setSearchWord(String _searchWord){
    searchWord = _searchWord;
    notifyListeners();
  }

  bool appearSearchField = false;
  setAppearSearchField(){
    appearSearchField = !appearSearchField;
    notifyListeners();
  }

  DataSaved dataSavedSearch;

  searchNotes([String input]){
    input = input ?? searchWord;

    print('input $input');

    dataSavedSearch = dataSaved;
    dataSavedSearch.dataSaved = dataSaved.dataSaved.where((element
        ) => element.name.toLowerCase().contains(input.toLowerCase())
        || element.content.toLowerCase().contains(input.toLowerCase())
    ).toList();
    print(dataSavedSearch.dataSaved);
    notifyListeners();
  }



}