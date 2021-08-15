import 'package:flutter/material.dart';
import '../styles/appClrs.dart';

class RoundedButton extends StatelessWidget {

  final Widget child;
  final String tooltip;
  final Function onPressed;
  RoundedButton({
    @required this.child,
    @required this.tooltip,
    @required this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: appClrs.darkMainColor,
      ),
      padding: EdgeInsets.zero,
      margin: EdgeInsets.symmetric(horizontal: 5),
      child: IconButton(
        icon: child,
        onPressed: onPressed,
        padding: EdgeInsets.zero,
        visualDensity: VisualDensity.compact,
        tooltip: tooltip,
        splashRadius: 5,
      ),

    );
  }
}
