import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'WheelButtons.dart';
import '../../global/responsive.dart';
import '../../logic/mainProv.dart';

class SelectClrWheel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('build');
    return Container(
      alignment: Alignment.bottomLeft,
      width: responsive.sWidth(context)*0.25,
      height: responsive.sHeight(context)*0.5,
      child: Consumer<MainProv>(
        builder:(_,prov,__)=> ListWheelScrollView(
          physics: BouncingScrollPhysics(),
          offAxisFraction: 20,
          children: List.generate(allClr.length, (_index)=> ColorsBtn(_index)),
          itemExtent: 40,
          useMagnifier: true,
          overAndUnderCenterOpacity: 0.7,
          onSelectedItemChanged: (indexWheel){
            prov.changeClr(allClr[indexWheel]);
          },
        ),
      ),
    );
  }
}
