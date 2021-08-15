import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';


class MainProv with ChangeNotifier{

  bool enableEdit = false;
  setEnableEdit(bool _enableEdit){
    enableEdit = _enableEdit;
    notifyListeners();
  }

  bool appearWheel = false ;
  resetAppearWheel(bool _appearWheel){
    appearWheel = _appearWheel;
    notifyListeners();
  }

  Color clr = allClr[0];
  changeClr(Color _clr){
    clr = _clr;
    notifyListeners();
  }
  resetClr(){
    clr = allClr[0];
    notifyListeners();
  }


  Color titleClr = Colors.white ;
  changeFontClr(){
    for(int i = 7 ; i<allClr.length ;i+=9){
      if(clr==allClr[i] || clr==allClr[i+1] || clr==Colors.black54) {
        titleClr = Colors.white ;
        break;
      }
      else titleClr = Colors.black ;
    }
  }

  List<Map<String,dynamic>> allAtrbutes = [];
  changeAllAtrbutes(newAllAtrbutes){
    allAtrbutes = newAllAtrbutes ;
    notifyListeners();
  }

  bool deleted = false ;
  changeDel(bool del){
    deleted=del;
    notifyListeners();
  }


  bool focusOnCopy = false ;
  changeFocus(bol){
    focusOnCopy = bol;
    notifyListeners();
  }


}




List <Color> allClr =[

  Color(0xffE7ED9B),
  Color(0xffF48FB1),
  Color(0xff81DEEA),
  Color(0xffFFAB91),
  Color(0xffCF94DA),
  Color(0xffFFCC80),

];
