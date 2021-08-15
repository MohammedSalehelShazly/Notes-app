
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../global/responsive.dart';
import '../../global/staticVariables.dart';
import '../../shared/components/selectClrWheel.dart';
import '../../logic/mainProv.dart';

class NoteFildesStruc extends StatefulWidget {

  final TextEditingController titleCtrl ;
  final TextEditingController contextCtrl;
  final Color titleFillColor;
  final bool editState;
  final Function savedFunction;
  final bool addNewNote;
  final Widget appDialog;
  String nameSaved;
  String contentSaved;
  String clrSaved;


  NoteFildesStruc({
    @required this.titleCtrl,
    @required this.contextCtrl,
    @required this.titleFillColor,
    @required this.editState,
    @required this.savedFunction,
    @required this.addNewNote,
    @required this.appDialog,
    this.nameSaved,
    this.contentSaved,
    this.clrSaved,
  });

  @override
  _NoteFildesStrucState createState() => _NoteFildesStrucState();
}

class _NoteFildesStrucState extends State<NoteFildesStruc> {
  StaticVars staticVars = StaticVars();

  MainProv mainProvWrite = MainProv();

  bool conditional;

  bool isEmptyInput()
    => widget.titleCtrl.text.trim().isEmpty && widget.contextCtrl.text.trim().isEmpty;

  bool isInputChanged()
    => widget.nameSaved !=widget.titleCtrl.text || widget.contentSaved !=widget.contextCtrl.text || widget.clrSaved !=widget.titleFillColor.value.toString();

  bool getConditional(){
    if(widget.addNewNote){
      conditional = isEmptyInput();
    }else{
      conditional = !isInputChanged() ;//&& isEmptyInput();
    }
    return conditional;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: WillPopScope(
      onWillPop: () async{
        return getConditional() ? await true
            : showCupertinoDialog(context: context, builder: (_) => widget.appDialog);
      },
      child: Hero(
        tag: 'add',
        child: Scaffold(
          body: Container(
            height: responsive.sHeight(context)-responsive.topPadding(context),
            margin: EdgeInsets.all(5),
            child: Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.symmetric(vertical: 5),
                      child: Selector<MainProv ,Color>(
                        selector: (_,prov)=> prov.clr,
                        builder:(_,clrProv,__)=> TextFormField(
                          enabled: widget.editState,
                          controller: widget.titleCtrl,
                          textDirection: staticVars.textStartWithEnglish(widget.titleCtrl.text) ?TextDirection.ltr :TextDirection.rtl,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(10),
                            filled: true,
                            fillColor: widget.addNewNote ? clrProv :widget.titleFillColor,
                            hintText: 'Enter Title',
                          ),
                          style: TextStyle(fontWeight: FontWeight.bold ,fontSize: responsive.textScale(context)*20 ,color: Colors.black),
                          validator: (valid){
                            if(isEmptyInput()){
                              return 'Note must have title or content';
                            }
                            return null ;
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        child: Selector<MainProv ,Color>(
                          selector: (_,prov)=> prov.clr,
                          builder:(_,clrProv,__)=>  TextFormField(
                            enabled: widget.editState,
                            maxLines: 40,
                            controller: widget.contextCtrl,
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(20),
                              filled: true,
                              fillColor: widget.addNewNote ? clrProv.withOpacity(0.7) :widget.titleFillColor.withOpacity(0.7),
                              hintText: 'Enter Note',
                            ),
                            ),
                        ),
                      ),
                    ),

                    if(widget.editState)
                      Container(
                        child: Stack(
                          children: <Widget>[
                            Align(
                              alignment: Alignment.centerRight,
                              child: ButtonTheme(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.horizontal(left: Radius.circular(20)),
                                    side: BorderSide(width: 2)
                                ),
                                child: MaterialButton(
                                  child: Text('Save' ,style: TextStyle(color: Colors.white),),
                                  color: Colors.black26,
                                  onPressed: getConditional() ? (){
                                    Navigator.pop(context);
                                    staticVars.showAppToast(context ,'Nothing to ${widget.addNewNote ?"save" :"edit"}');
                                  }
                                  : widget.savedFunction,
                                ),
                              ),
                            ),

                            Consumer<MainProv>(
                                builder: (_,prov ,__)=> Align(
                                  alignment: Alignment.center,
                                  child: RawMaterialButton(
                                    constraints: BoxConstraints.expand(width: 50 ,height: 50),
                                    fillColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        side: BorderSide(color: Colors.black )
                                    ),
                                    onPressed: (){
                                      prov.resetAppearWheel(!prov.appearWheel);
                                    },
                                    child: ShaderMask(
                                        shaderCallback: (rect){
                                          List<Color> subClr =[];
                                          for(int i=8 ;i<allClr.length ;i+=9){
                                            subClr.add(allClr[i]);
                                          }
                                          return LinearGradient(
                                            colors:allClr,
                                          ).createShader(rect);
                                        },
                                        child: Icon(Icons.color_lens ,size: MediaQuery.textScaleFactorOf(context)*35,color: Colors.white,)),
                                  ),
                                ),
                              )

                          ],
                        ),
                    ),
                  ],
                ),

                Selector<MainProv ,bool>(
                  selector:(_,prov) => prov.appearWheel,
                  builder:(_,provAppearWheel,__)=> AnimatedSwitcher(
                    duration: Duration(milliseconds: 300),
                    switchOutCurve: Curves.easeInOut,
                    switchInCurve: Curves.easeInOut,
                    transitionBuilder: (Widget child, Animation<double> animation) {
                      return ScaleTransition(scale: animation, child: child);
                    },
                    child: !provAppearWheel ?SizedBox()
                        :Align(
                        alignment: Alignment.bottomLeft,
                        child: SelectClrWheel()
                    ),
                  ),
                ),

                Align(
                    alignment: Alignment.bottomRight,
                    child: Transform.translate(
                      offset: Offset(5,5),
                      child: Consumer<MainProv>(
                        builder:(_,prov ,__)=>
                        widget.addNewNote || prov.enableEdit ? SizedBox()
                            :
                            ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: MaterialButton(
                                height: 60,
                                minWidth: 60,
                                color: Colors.black.withOpacity(0.05),
                                child: Icon(Icons.edit_outlined),
                                onPressed: (){
                                  prov.setEnableEdit(true);
                                  },
                                ),
                              ),
                      ),
                    ),
                  )
                ],
            ),
          ),
        ),
      ),
    ),);
  }
}
