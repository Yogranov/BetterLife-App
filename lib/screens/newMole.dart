import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class NewMole extends StatefulWidget {
  @override
  _NewMoleState createState() => _NewMoleState();
}

class _NewMoleState extends State<NewMole> {

  File molePic;


  _openCamera (BuildContext context) async {
    File pic = await ImagePicker.pickImage(source: ImageSource.camera);
    this.setState(() {
      molePic = pic;
      });
    // Navigator.of(context).pop();
  }

  Widget _imgOrText (BuildContext context) {
    if(molePic == null)
      _openCamera(context);
    else
    return ClipRRect(
      borderRadius: BorderRadius.circular(16.0),
      child: Image.file(molePic),
    );
  }
  
  @override
  Widget build(BuildContext context) {

    return ListView(
      children: <Widget>[
        SizedBox(height: 10,),
        Container(
          height: 40,
          child: 
            Text("הוספת שומה",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: TextFormField(
            textAlign: TextAlign.right,
            decoration: InputDecoration(
              hintText: "מיקום בגוף",
              contentPadding: EdgeInsets.all(15.0),
              border: InputBorder.none,
              filled: true,
              fillColor: Colors.grey[50],
            ),
            keyboardType: TextInputType.text,
          ),
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: TextFormField(
            textAlign: TextAlign.right,
            decoration: InputDecoration(
              hintText: "גודל (ממ)",
              contentPadding: EdgeInsets.all(15.0),
              border: InputBorder.none,
              filled: true,
              fillColor: Colors.grey[50],
            ),
            keyboardType: TextInputType.text,
          ),
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: TextFormField(
            textAlign: TextAlign.right,
            decoration: InputDecoration(
              hintText: "צבע",
              contentPadding: EdgeInsets.all(15.0),
              border: InputBorder.none,
              filled: true,
              fillColor: Colors.grey[50],
            ),
            keyboardType: TextInputType.text,
          ),
        ),
        SizedBox(height: 20,),
        Container(
          width: MediaQuery.of(context).size.width *0.9,
          height: MediaQuery.of(context).size.height *0.4,
          child:
            _imgOrText(context),
        ),
      ],
    );
  }
}