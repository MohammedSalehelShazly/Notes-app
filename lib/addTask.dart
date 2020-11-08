import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sqliteapp/Mynode.dart';
import 'package:sqliteapp/all_Lists.dart';
import 'package:sqliteapp/provider_lists.dart';

import 'WheelButtons.dart';

class AddTask extends StatefulWidget {
  bool updatePage ;
  String currentDate;
  int index ;
  AddTask({this.updatePage ,this.currentDate ,this.index});
  @override
  _AddTaskState createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {

  final List<Color> StaticColors = allClr;
  bool appearWheel = false ;

  bool isEmptyInput()=> (inputController.text.isEmpty || inputController.text.trim().isEmpty) && (inputController2.text.isEmpty || inputController2.text.trim().isEmpty) ;
  
  var scaffoldKey = GlobalKey<ScaffoldState>();

  Mynode objEdit = Mynode();

  var atrbutesWillUpdate ;


  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<ProviderList>(context);
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async{
          return isEmptyInput() ? await true : noticePop(context ,title:'If you back your task will lose'  , doneActionTitle:'Back');
        },
        child: Hero(
          tag: 'add',
          child: Scaffold(
            key: scaffoldKey,
            body: SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height*0.96,
                child: Stack(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(5),
                          child: TextFormField(
                            controller: inputController,
                            textDirection: inputDirection,
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(10),
                                filled: true,
                                fillColor: prov.clr,
                                hintText: 'Enter Title',
                            ),
                            style: TextStyle(color: prov.titleClr ,fontWeight: FontWeight.bold ,fontSize: 17),
                            onChanged: (val){
                              selectDirection(inputController.text[0] ,true);
                              Mynode obj = Mynode();
                              obj.externalName = inputController.text.toString();
                            },
                            validator: (valid){
                              if(valid.isEmpty){
                                return 'Task must have title or content';
                              }
                              return null ;
                            },
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(5),
                          child: TextField(
                            maxLines: 30,
                            controller: inputController2,
                            textDirection: inputDirection2,
                            onChanged: (val){
                              selectDirection(inputController2.text[0] ,false);
                            },
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(20),
                              filled: true,
                              fillColor: prov.clr.withOpacity(0.7),
                              hintText: 'Enter Task',
                              hintStyle: TextStyle(fontSize: 16),
                            ),
                            style: TextStyle(color: Colors.black),
                          ),
                        ),

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
                                  child: RaisedButton(
                                    child: Text('Save' ,style: TextStyle(color: Colors.white),),
                                    color: Colors.black26,
                                    onPressed: isEmptyInput() ? null :
                                        (){
                                      if(widget.updatePage){
                                        objEdit.updateNote(
                                            {'name':inputController.text , 'content':inputController2.text , 'color':'${prov.clr.value}' , 'lastUpdate':DateTime.now().toString()},

                                            prov.allAtrbutes[widget.index]['date']).then((val){
                                          objEdit.showOldValues().then((val){   // update old lists ,to add new to them
                                            prov.changeAllAtrbutes(val);
                                          });
                                          Navigator.pop(context);
                                        });

                                      }else{
                                        Mynode objCreate = Mynode();
                                        objCreate.insertRow({'name':inputController.text , 'content':inputController2.text , 'color':'${prov.clr.value}' , 'fontColor':'${prov.titleClr.value}', 'date':DateTime.now().toString() , 'lastUpdate':DateTime.now().toString()}).then((val){
                                          objCreate.showOldValues().then((val){   // update old lists ,to add new to them
                                            prov.changeAllAtrbutes(val);
                                          });

                                          Navigator.pop(context);
                                        });
                                      }

                                    },
                                  ),
                                ),
                              ),

                              Align(
                                alignment: Alignment.center,
                                child: RawMaterialButton(
                                  constraints: BoxConstraints.expand(width: 50 ,height: 50),
                                  fillColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      side: BorderSide(color: Colors.black )
                                  ),
                                  onPressed: (){
                                    setState(() {
                                      appearWheel = appearWheel? false : true;
                                    });
                                  },
                                  child: ShaderMask(
                                      shaderCallback: (rect){
                                        List<Color> subClr =[];
                                        for(int i=8 ;i<allClr.length ;i+=9){
                                          subClr.add(allClr[i]);
                                        }
                                        return LinearGradient(
                                            colors: allClr
                                        ).createShader(rect);
                                      },
                                      child: Icon(Icons.color_lens ,size: MediaQuery.textScaleFactorOf(context)*35,color: Colors.white,)),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),

                    AnimatedSwitcher(
                      duration: Duration(milliseconds: 300),
                      switchOutCurve: Curves.easeInOut,
                      switchInCurve: Curves.easeInOut,
                      child: appearWheel==false?SizedBox()
                          :Align(
                          alignment: Alignment.bottomLeft,
                          child: wheel(prov)
                      ),
                    )

                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  
  wheel(prov){
    return Container(
      alignment: Alignment.bottomLeft,
      width: MediaQuery.of(context).size.width*0.25,
      height: MediaQuery.of(context).size.height*0.5,
      child: ListWheelScrollView(
        offAxisFraction: 20,
        children: List.generate(allClr.length, (_index)=> ColorsBtn(StaticColors:StaticColors, clr:prov.clr, index:_index) ),
        itemExtent: 40,
        useMagnifier: true,
        overAndUnderCenterOpacity: 0.7,
        onSelectedItemChanged: (indexWheel){
          ColorsBtn obj = ColorsBtn();
          setState(() {
            obj.changeClr(prov ,StaticColors ,indexWheel);
          });
        },
      ),
    );
  }

  TextEditingController inputController = TextEditingController(/*text: widget.updatePage?''*/);
  TextEditingController inputController2 = TextEditingController();
  List<String> lettersAR = ['ذ','ض','ص','ث','ق','ف','غ','ع','ه','خ','ح','ج','د','ش','س','ي','ب','ل','ا','ت','ن','م','ك','ط','ئ','ء','ؤ','ر','أ','إ','ظ','ز','و','ة','ى','آ',];
  TextDirection inputDirection = TextDirection.ltr;
  TextDirection inputDirection2 = TextDirection.ltr;

  selectDirection(String input ,bool isTitle) {
    for (int i = 0; i < lettersAR.length; i++) {
      if (input == lettersAR[i]) {
        setState(() {
          isTitle ? inputDirection = TextDirection.rtl
              : inputDirection2 = TextDirection.rtl;
        });
        break;
      }
      else {
        setState(() {
          isTitle ? inputDirection = TextDirection.ltr
              : inputDirection2 = TextDirection.ltr;
        });
      }
    }
  }



}

