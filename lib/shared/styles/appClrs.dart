import 'package:flutter/material.dart';


AppClrs appClrs = AppClrs();

class AppClrs{

  Color mainColor = Color(0xffe7ed9b);
  Color darkMainColor = Color(0xffd5dc7b);
  Color secondColor = Colors.deepPurpleAccent;

  MaterialColor colorPrimarySwatch = const MaterialColor(
    0xffE7ED9B,
    const <int, Color>{
      50:Color.fromRGBO(231,237,155, 1),
      100:Color.fromRGBO(231,237,155, 1),
      200:Color.fromRGBO(231,237,155, 1),
      300:Color.fromRGBO(231,237,155, 1),
      400:Color.fromRGBO(231,237,155, 1),
      500:Color.fromRGBO(231,237,155, 1),
      600:Color.fromRGBO(231,237,155, 1),
      700:Color.fromRGBO(231,237,155, 1),
      800:Color.fromRGBO(231,237,155, 1),
      900:Color.fromRGBO(231,237,155, 1),
    },
  );


  String mainFontFamily = 'Cairo';

  ThemeData appThem(bool isDark)=> ThemeData(
    brightness: isDark ?Brightness.dark :Brightness.light,
    fontFamily: mainFontFamily,
    primaryColor: mainColor,
    appBarTheme: AppBarTheme(
      textTheme: TextTheme(
        headline6: TextStyle(fontSize: 20 ,fontWeight: FontWeight.bold ,fontFamily: mainFontFamily)
      ),
    ),
    dialogTheme: DialogTheme(
      titleTextStyle: TextStyle(color: mainColor ),
    ),
  );


}