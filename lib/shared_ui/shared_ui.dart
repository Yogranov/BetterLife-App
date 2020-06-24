import 'package:flutter/material.dart';

class SharedUI {

  static Padding drawLine(double length) {
    return 
      Padding(
        padding:EdgeInsets.symmetric(horizontal: length),
        child:Container(
          height:1.0,
          color:Colors.grey[400],
        ),
      );
  }

}