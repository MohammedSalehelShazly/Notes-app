import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:random_color/random_color.dart';
import 'Mynode.dart';
import 'WheelButtons.dart';
import 'addTask.dart';
import 'provider_lists.dart';



class AllLists extends StatefulWidget {
  @override
  _AllListsState createState() => _AllListsState();
}

class _AllListsState extends State<AllLists> {

  Color clr = Colors.purple;

  Future <String>getData() async{
    return await Future.delayed(Duration(seconds: 3),(){
      return 'sdfsd sd sdfsd  f sdfsdf s  dfsfsdfsdf df sdfsdfsd  sdfsd fdfsdfsd sdfsd sd sdfsdsdfsd sd sdfsd  f sdfsdf s  dfsfsdfsdf df sdfsdfsd  sdfsd fdfsdfsd  f sdfsdf s  dfsfsdfsdf df sdfsdfsd  sdfsd fdfsdfsd';
    });
  }

  List<Map<String,dynamic>> allAtrbutes = [];

  Mynode objCreate = Mynode();


  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<ProviderList>(context);
    objCreate.showOldValues().then((val){
      prov.changeAllAtrbutes(val);
    });
    return Scaffold(

      backgroundColor: Colors.deepPurple,
      body: ListView(
        children: List.generate(prov.allAtrbutes.length==0?1 :prov.allAtrbutes.length , (index){
          return prov.allAtrbutes.length==0? addTaskBox()
              :
          OneNote(prov.allAtrbutes, index) ;
          },
        ),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            prov.allAtrbutes.length==0?SizedBox()
                :
            FloatingActionButton.extended(
              backgroundColor: Colors.black26,
              label: Text('Delete All'),
              icon: Icon(Icons.delete_outline ,color: Colors.red,),
              heroTag: 'del',
              onPressed: (){
                noticePop(context ,title:'If you delete tasks, you won\'t be able to return tasks again.'  , doneActionTitle:'Delete');
              },
            ),

            FloatingActionButton.extended(
              backgroundColor: Colors.black26,
              label: Text('Add Task'),
              icon: Icon(Icons.add ,color: Colors.green,),
              heroTag: 'add',
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(
                    builder: (context)=>AddTask(updatePage: false,))
                );
              },
            ),
          ],
        ),
      ),
    );
  }
  addTaskBox(){
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width*0.8,
        height: MediaQuery.of(context).size.width*0.8,
        alignment: Alignment.center,
        child: Text('not have tasks logo'),
        color: Colors.green,
      ),
    );
  }

}

/// add fav color and make it default color




class OneNote extends StatefulWidget {

  List<Map<String,dynamic>> allAtrbutes ;
  int index ;
  OneNote(this.allAtrbutes, this.index);

  @override
  _OneNoteState createState() => _OneNoteState();
}

class _OneNoteState extends State<OneNote> {


  DateTime date ()=> DateTime.parse(widget.allAtrbutes[widget.index]['date']);
  DateTime lastUpdate ()=> DateTime.parse(widget.allAtrbutes[widget.index]['lastUpdate']);

  int contentMaxLines = 5;
  bool readMore = false ;

  @override
  Widget build(BuildContext context) {
    return SwipeTest(
      Container(
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(
            color: Color(int.parse(widget.allAtrbutes[widget.index]['color'])) ,
            borderRadius: BorderRadius.circular(20)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[

            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(10),
              child: Text(widget.allAtrbutes[widget.index]['name'] ,
                style: TextStyle(
                  color: Color(int.parse(widget.allAtrbutes[widget.index]['fontColor'])) ,
                  fontWeight: FontWeight.bold ,
                  fontSize: MediaQuery.textScaleFactorOf(context)*20 ,
                  fontFamily: 'Sacramento',
                ),
              ),
            ),

            InkWell(
              onTap: (){
                setState(() {
                  readMore = readMore? false : true ;
                });
              },
              child: Container(
                padding: EdgeInsets.all(10),
                child: Text(widget.allAtrbutes[widget.index]['content'].toString() ,
                  maxLines: readMore ? null : contentMaxLines,
                  overflow: TextOverflow.fade,
                  style: TextStyle(
                    color: Color(int.parse(widget.allAtrbutes[widget.index]['fontColor'])) ,
                    fontSize: MediaQuery.textScaleFactorOf(context)*15 ,
                    fontFamily: 'Sacramento',
                  ),
                ),
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                // because milliseconds not equals
                '${lastUpdate().day}/${lastUpdate().hour}:${lastUpdate().minute}:${lastUpdate().second}'=='${date().day}/${date().hour}:${date().minute}:${date().second}'?SizedBox()
                    :Container(
                  alignment: Alignment.bottomLeft,
                  margin: EdgeInsets.all(10),
                  child: Text(
                    'Last Update: ${lastUpdate().year}-${lastUpdate().month}-${lastUpdate().day}   ${lastUpdate().hour}:${lastUpdate().minute}' ,
                    style: TextStyle(
                      color: Color(int.parse(widget.allAtrbutes[widget.index]['fontColor'])) ,
                      fontSize: MediaQuery.textScaleFactorOf(context)*15 ,
                      fontFamily: 'Sacramento',
                    ),),
                ),

                Container(
                  alignment: Alignment.bottomRight,
                  margin: EdgeInsets.all(10),
                  child: Text(
                    '${date().year}-${date().month}-${date().day}   ${date().hour}:${date().minute}' ,
                    style: TextStyle(
                      color: Color(int.parse(widget.allAtrbutes[widget.index]['fontColor'])) ,
                      fontSize: MediaQuery.textScaleFactorOf(context)*15 ,
                      fontFamily: 'Sacramento',
                    ),),
                ),
              ],
            ),



          ],
        ),
      ),
      widget.allAtrbutes[widget.index]['date'],
      widget.index ,
    );
  }
}


class SwipeTest extends StatefulWidget {
  Widget childSwipe ;
  String currentDate;
  int index;
  SwipeTest(this.childSwipe ,this.currentDate ,this.index);

  @override
  _SwipeTestState createState() => _SwipeTestState();
}

class _SwipeTestState extends State<SwipeTest> {

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<ProviderList>(context);
    return prov.deleted==true?SizedBox() :Dismissible(
      key: Key(widget.currentDate),
      child: widget.childSwipe,
      background: swipeBack(title: 'Delete' ,clr: Colors.red ,align: Alignment.centerLeft),
      secondaryBackground: swipeBack(title: 'Edite' ,clr: Colors.blueGrey[300] ,align: Alignment.centerRight),

      onDismissed: (Diriction){
        ChangedAfterSwipeDel obj = ChangedAfterSwipeDel(prov);
        ChangedAfterSwipeEdit objEd = ChangedAfterSwipeEdit(prov ,context);


        if(Diriction==DismissDirection.startToEnd){
          obj.changed(widget.currentDate);
        }else {
          objEd.changed(widget.index);
        }
      },
      crossAxisEndOffset: 2,
    );
  }

  swipeBack({title ,clr ,align ,}){
    return Container(
      color: clr,
      child: Text(title ,style: TextStyle(color:Colors.white),) ,
      alignment: align,
      width: MediaQuery.of(context).size.width*0.25,
      padding: EdgeInsets.all(8),
    );
  }

}

class ChangedAfterSwipeDel{
  Mynode obj = Mynode();
  var prov ;
  ChangedAfterSwipeDel(this.prov);
  changed(currentDate){
    prov.changeDel(true);
    obj.deleteOneTask(currentDate);

    Future.delayed(Duration.zero,(){
      prov.changeDel(false);
    });
  }
}

class ChangedAfterSwipeEdit{
  Mynode obj = Mynode();
  var prov ;
  BuildContext context ;
  ChangedAfterSwipeEdit(this.prov ,this.context);
  changed(index){
    prov.changeDel(true);


    Navigator.push(context, MaterialPageRoute(
      builder: (context)=>AddTask(updatePage: true ,index:index)
    ));


    Future.delayed(Duration.zero,(){
      prov.changeDel(false);
    });
  }
}

