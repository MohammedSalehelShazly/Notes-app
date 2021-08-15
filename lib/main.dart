
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'shared/styles/appClrs.dart';
import './logic/service.dart';
import './modules/allNotesScreen/allNotesScreen.dart';
import 'logic/mainProv.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers:[
        ChangeNotifierProvider(create: (_)=> MainProv(),),
        ChangeNotifierProvider(create: (_)=> DataSavedService(),),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        darkTheme: appClrs.appThem(true),
        themeMode: ThemeMode.dark,
        home: AllNotesScreen(),
      ),
    );
  }
}