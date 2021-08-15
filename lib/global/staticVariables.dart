import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:toast/toast.dart';


class StaticVars{

  bool textStartWithEnglish(String txt)=>
      txt.isEmpty ? true
          :(txt.codeUnitAt(0) >=65 && txt.codeUnitAt(0) <=122);

  showAppToast(BuildContext context ,String txt){
    Toast.show(
        txt,
        context,
        duration: Toast.LENGTH_LONG,
        gravity:  Toast.BOTTOM);
  }

}

