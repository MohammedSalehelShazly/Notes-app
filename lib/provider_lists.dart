import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'Mynode.dart';
import 'all_Lists.dart';

class ProviderList with ChangeNotifier{
  Color clr = Colors.black54;
  changeClr(_clr){
    clr = _clr;
    changeFontClr();

    notifyListeners();
  }

  Color titleClr = Colors.black ;
  changeFontClr(){
    for(int i = 7 ; i<allClr.length ;i+=9){
      if(clr==allClr[i] || clr==allClr[i+1]) {
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

}


noticePop(_context ,{String title ,String doneActionTitle}){
  return showCupertinoDialog(
      context: _context,
      builder: (context)=>CupertinoAlertDialog(
        content: Text(title),
        actions: [
          CupertinoButton(
            child: Text('Cancel'),
            onPressed: (){
              Navigator.pop(context);
            },
          ),
          CupertinoButton(
            child: Text(doneActionTitle ,style: TextStyle(color: Colors.red),),
            onPressed: (){
              Mynode obj = Mynode();

              if(doneActionTitle =='Back'){
                Navigator.pushAndRemoveUntil(context, CupertinoPageRoute(builder: (context)=>AllLists()), (route) => false);
              }else{
                obj.deleteAll();
                Navigator.pop(context);
              }
            },
          ),
        ],
      )
  );
}


List <Color> allClr =[
  Color(0xffffcdd2),
  Color(0xffef9a9a),
  Color(0xffe57373),
  Color(0xffef5350),
  Color(0xfff44336),
  Color(0xffe53935),
  Color(0xffd32f2f),
  Color(0xffc62828),
  Color(0xffb71c1c),
  Color(0xffffe0b2),
  Color(0xffffcc80),
  Color(0xffffb74d),
  Color(0xffffa726),
  Color(0xffff9800),
  Color(0xfffb8c00),
  Color(0xfff57c00),
  Color(0xffef6c00),
  Color(0xffe65100),
  Color(0xfffff9c4),
  Color(0xfffff59d),
  Color(0xfffff176),
  Color(0xffffee58),
  Color(0xffffeb3b),
  Color(0xfffdd835),
  Color(0xfffbc02d),
  Color(0xfff9a825),
  Color(0xfff57f17),
  Color(0xffc8e6c9),
  Color(0xffa5d6a7),
  Color(0xff81c784),
  Color(0xff66bb6a),
  Color(0xff4caf50),
  Color(0xff43a047),
  Color(0xff388e3c),
  Color(0xff2e7d32),
  Color(0xff1b5e20),
  Color(0xffbbdefb),
  Color(0xff90caf9),
  Color(0xff64b5f6),
  Color(0xff42a5f5),
  Color(0xff2196f3),
  Color(0xff1e88e5),
  Color(0xff1976d2),
  Color(0xff1565c0),
  Color(0xff0d47a1),
  Color(0xffe1bee7),
  Color(0xffce93d8),
  Color(0xffba68c8),
  Color(0xffab47bc),
  Color(0xff9c27b0),
  Color(0xff8e24aa),
  Color(0xff7b1fa2),
  Color(0xff6a1b9a),
  Color(0xff4a148c),
  Color(0xfff8bbd0),
  Color(0xfff48fb1),
  Color(0xfff06292),
  Color(0xffec407a),
  Color(0xffe91e63),
  Color(0xffd81b60),
  Color(0xffc2185b),
  Color(0xffad1457),
  Color(0xff880e4f),
  Color(0xffd7ccc8),
  Color(0xffbcaaa4),
  Color(0xffa1887f),
  Color(0xff8d6e63),
  Color(0xff795548),
  Color(0xff6d4c41),
  Color(0xff5d4037),
  Color(0xff4e342e),
  Color(0xff3e2723),
  Color(0xff448aff),
  Color(0xffb2ff59),
  Color(0xff69f0ae),
];

/*List <Color> allClr =[
  Colors.red[100] ,
  Colors.red[200] ,
  Colors.red[300] ,
  Colors.red[400] ,
  Colors.red[500] ,
  Colors.red[600] ,
  Colors.red[700] ,
  Colors.red[800] ,
  Colors.red[900] ,
  Colors.orange[100] ,
  Colors.orange[200] ,
  Colors.orange[300] ,
  Colors.orange[400] ,
  Colors.orange[500] ,
  Colors.orange[600] ,
  Colors.orange[700] ,
  Colors.orange[800] ,
  Colors.orange[900] ,
  Colors.yellow[100] ,
  Colors.yellow[200] ,
  Colors.yellow[300] ,
  Colors.yellow[400] ,
  Colors.yellow[500] ,
  Colors.yellow[600] ,
  Colors.yellow[700] ,
  Colors.yellow[800] ,
  Colors.yellow[900] ,
  Colors.green[100] ,
  Colors.green[200] ,
  Colors.green[300] ,
  Colors.green[400] ,
  Colors.green[500] ,
  Colors.green[600] ,
  Colors.green[700] ,
  Colors.green[800] ,
  Colors.green[900] ,
  Colors.blue[100] ,
  Colors.blue[200] ,
  Colors.blue[300] ,
  Colors.blue[400] ,
  Colors.blue[500] ,
  Colors.blue[600] ,
  Colors.blue[700] ,
  Colors.blue[800] ,
  Colors.blue[900] ,
  Colors.purple[100] ,
  Colors.purple[200] ,
  Colors.purple[300] ,
  Colors.purple[400] ,
  Colors.purple[500] ,
  Colors.purple[600] ,
  Colors.purple[700] ,
  Colors.purple[800] ,
  Colors.purple[900] ,
  Colors.pink[100] ,
  Colors.pink[200] ,
  Colors.pink[300] ,
  Colors.pink[400] ,
  Colors.pink[500] ,
  Colors.pink[600] ,
  Colors.pink[700] ,
  Colors.pink[800] ,
  Colors.pink[900] ,
  Colors.brown[100] ,
  Colors.brown[200] ,
  Colors.brown[300] ,
  Colors.brown[400] ,
  Colors.brown[500] ,
  Colors.brown[600] ,
  Colors.brown[700] ,
  Colors.brown[800] ,
  Colors.brown[900] ,
  Colors.blueAccent ,
  Colors.greenAccent ,
  Colors.lightGreenAccent ,
];
*/