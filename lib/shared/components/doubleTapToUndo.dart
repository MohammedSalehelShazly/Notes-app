import 'dart:io';
import 'package:flutter/material.dart';

// notice..
/// if create more than constructor its not work ,because the list (_tapCont) initialized every time you create constructor
/// so, im not pass (context) to constructor
// usage
/// DoubleTapToExit doubleTapToExit = DoubleTapToExit();
/// onWillPop:()async()=> doubleTapToExit.action(context);

class DoubleTapToExit {

  _showSnackBar(BuildContext context){
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('double tab to exit' ,style: TextStyle(color: Colors.white),),
      backgroundColor: Color(0xff303030),
      duration: Duration(seconds: 2),
    ));
  }

  List<int> _tapCont =[]; // [ 1 ,1 ] => exit

  action(BuildContext context){
    _tapCont.add(1);

    if(_tapCont.length==1) {
      _showSnackBar(context);
      Future.delayed(Duration(seconds: 2), () {
        _tapCont = [];
      });
    }
    else if(_tapCont.length == 2){
      exit(0);
    }
    print(_tapCont);
  }
}