import 'package:flutter/material.dart';
import '../../global/responsive.dart';

class NoHaveTasks extends StatelessWidget {

  String title;
  NoHaveTasks(this.title);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: responsive.responsiveWidth(context, 0.6),
            width: responsive.responsiveWidth(context, 0.6),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/empty_cart.png'),
                fit: BoxFit.contain
              )
            ),
          ),
          Text(title ,style: TextStyle(fontSize: responsive.textScale(context)*20),textAlign: TextAlign.center,),
        ],
      ),
    );
  }
}
