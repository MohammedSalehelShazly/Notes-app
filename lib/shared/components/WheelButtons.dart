import 'package:flutter/material.dart';
import '../../logic/mainProv.dart';

class ColorsBtn extends StatelessWidget {
  int index ;
  ColorsBtn(this.index);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5 , horizontal: 20),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        color: allClr[index],
      ),
    );
  }
}
