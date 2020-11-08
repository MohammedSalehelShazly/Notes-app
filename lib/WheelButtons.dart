import 'package:flutter/material.dart';

class ColorsBtn extends StatefulWidget {

  List<Color> StaticColors ;
  Color clr ;
  int index ;
  ColorsBtn({this.StaticColors, this.clr, this.index});

  double selectedWidth =0;

  changeClr(prov ,List _StaticColors ,_index){
    clr = _StaticColors[_index];
    prov.changeClr(clr);
    ///set clr
  }

  @override
  _ColorsBtnState createState() => _ColorsBtnState();
}
class _ColorsBtnState extends State<ColorsBtn> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5 , horizontal: 20),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          color: widget.StaticColors[widget.index],
        ),
      ),
    );
  }
}
