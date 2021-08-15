import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppDialog extends StatelessWidget {

  BuildContext screenCtx;
  String content;
  String doneActionTitle;
  Function doneAction;

  AppDialog({
    @required this.screenCtx,
    @required this.content,
    @required this.doneActionTitle,
    @required this.doneAction
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      content: Text(content),
      actions: [
        CupertinoButton(
          child: Text('Cancel'),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        CupertinoButton(
          child: Text(doneActionTitle ,style: TextStyle(color: Colors.red),),
          onPressed: doneAction
        ),
      ],
    );
  }
}
