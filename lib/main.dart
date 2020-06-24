import 'package:betterlife/screens/home.dart';
import 'package:betterlife/screens/login.dart';
import 'package:betterlife/screens/moleList.dart';
import 'package:betterlife/screens/molePage.dart';
import 'package:flutter/material.dart';

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
        primarySwatch: Colors.lightGreen,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        scaffoldBackgroundColor: Colors.grey[50],
        textTheme: TextTheme(
          headline6: TextStyle(color:  Colors.grey[800]),
          bodyText2: TextStyle(color: Colors.grey[800]),
        ),
      ),
      home: SafeArea(child: MoleList()),
    );
  }
}
