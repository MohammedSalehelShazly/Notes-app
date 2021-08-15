import 'package:flutter/material.dart';

/// to use it..
// TimeFormatter(isEng: true, localTime24: DateTime.parse( date ),).timeFormat(),
// TimeFormatter(isEng: true, localTime24: DateTime.parse( date ),).nameOfDay(),

class TimeFormatter {

  final DateTime localTime24 ;
  final bool isEng;

  TimeFormatter({
    @required this.localTime24,
    @required this.isEng
  });

   String addZero(int num)=>
       '${num<10 ? '0'+'$num' : '$num'}';

   String timeMidday(time24 ,bool isEng) =>
       isEng ?  time24.hour>=12 ? ' pm' : ' am'
           :
       time24.hour>=12 ? ' م' : ' ص';

    DateTime to12Hour(DateTime time){
      return time.hour>12 ? time.subtract(Duration(hours:12) )
          :  time ;
    }

    String nameOfDay(){
      if(isEng){
        switch(localTime24.weekday){
          case 1 : return 'Mon'; break;
          case 2 : return 'Tues'; break;
          case 3 : return 'Wed'; break;
          case 4 : return 'Thurs'; break;
          case 5 : return 'Fri'; break;
          case 6 : return 'Sat'; break;
          case 7 : return 'Sun'; break;
          default : return' ';
        }
      }else{
        switch(localTime24.weekday){
          case 1 : return 'الأثنين'; break;
          case 2 : return 'الثلاثاء'; break;
          case 3 : return 'الأربعاء'; break;
          case 4 : return 'الخميس'; break;
          case 5 : return 'الجمعه'; break;
          case 6 : return 'السبت'; break;
          case 7 : return 'الأحد'; break;
          default : return' ';
        }
      }
    }

    timeFormat({TextStyle textStyle}){
      return RichText(
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        text: TextSpan(
          style: textStyle,
            children: [

              TextSpan(text: dateFormat()),

              if(isEng)
                TextSpan(text: addZero(to12Hour(localTime24).hour) + ':'),
              TextSpan(text: addZero(to12Hour(localTime24).minute) + ' '),

              if(!isEng)
                TextSpan(text: ':'),
              if(!isEng)
                TextSpan(text: addZero(to12Hour(localTime24).hour) + ''),

              TextSpan(text: timeMidday(localTime24 ,isEng) +' '),
            ]
        ),
      );
    }


  String monthName(){
    switch(localTime24.month){
      case 1 : return 'Jan'; break;
      case 2 : return 'Feb'; break;
      case 3 : return 'Mar'; break;
      case 4 : return 'Apr'; break;
      case 5 : return 'May'; break;
      case 6 : return 'Jun'; break;
      case 7 : return 'Jul'; break;
      case 8 : return 'Aug'; break;
      case 9 : return 'Sep'; break;
      case 10: 	return 'Oct'; break;
      case 11:  return 'Nov'; break;
      case 12: 	return 'Dec'; break;
      default: return 'Jul';
    }
  }

  String dateFormat()
    => '${localTime24.day}-' +monthName() +' ,';

}