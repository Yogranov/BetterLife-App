import 'package:betterlife/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BetterLife',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.grey[200]  ,
        primarySwatch: Colors.lightGreen,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: TextTheme(
          headline4: TextStyle(color:  Colors.grey[50]),
          bodyText2: TextStyle(color: Colors.grey[800]),
        ),
      ),
      home: SafeArea(child:
        Wrapper()
      ),
    );
  }
}