
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqliteapp/provider_lists.dart';
import 'all_Lists.dart';

import 'Mynode.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers:[
        ChangeNotifierProvider(
          create: (_)=> ProviderList(),
        ),
      ],
      child: MaterialApp(
        home: AllLists(),
      ),
    );
  }

}
