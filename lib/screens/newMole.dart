import 'dart:convert';
import 'dart:io';
import 'package:betterlife/models/User.dart';
import 'package:betterlife/shared_ui/constant.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:path/path.dart' as path;
import 'package:rflutter_alert/rflutter_alert.dart';




class NewMole extends StatefulWidget {
  User user;

  NewMole({this.user});

  @override
  _NewMoleState createState() => _NewMoleState();
}

class _NewMoleState extends State<NewMole> {

  File molePic;
  int size;
  String color;
  String location;
  bool submitLoading = false;


  Future<File> file;
  String status = '';
  String base64Image;
  File tmpFile;
  String errMessage = 'Error Uploading Image';


  _openCamera (BuildContext context) async {
    File pic = await ImagePicker.pickImage(source: ImageSource.camera);

    if(pic != null) {
      File cropped = await ImageCropper.cropImage(
        sourcePath: pic.path,
        aspectRatio: CropAspectRatio(ratioX: 4, ratioY: 3),
        compressQuality: 100,
        maxWidth: 600,
        maxHeight: 450,
        compressFormat: ImageCompressFormat.jpg,
        androidUiSettings: AndroidUiSettings(
          toolbarColor: Colors.green,
          toolbarTitle: "נא לסמן את השומה",
          statusBarColor: Colors.deepOrange.shade900,
          backgroundColor: Colors.white
        ),

      );

    this.setState(() {
      molePic = cropped;
      });

    }
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
            onChanged: (val) {
              setState(() => location = val);
            }
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
            onChanged: (val) {
              setState(() => size = int.parse(val));
            }
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
            onChanged: (val) {
              setState(() => color = val);
            }
          ),
        ),
        SizedBox(height: 20,),
        Container(
          width: MediaQuery.of(context).size.width *0.9,
          height: MediaQuery.of(context).size.height *0.4,
          child:
            _imgOrText(context),
        ),
        SizedBox(height: 30,),
        Center(
          child: RaisedButton(
            color: Colors.pink[400],
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 20),
              child: submitLoading ? CircularProgressIndicator() : Text(
                'עדכון פרטים',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            onPressed: () async {
              uploadData();
              //Navigator.pop(context);
            }
          ),
        ),
        SizedBox(height: 30,),
      ],
    );
  }

  void uploadData() async {
    base64Image = base64Encode(molePic.readAsBytesSync());
 
    Map data = {
      'TOKEN': Constant.apiToken,
      'userToken': widget.user.token,

      'size': size.toString(),
      'location': location,
      'color': color,
      'image': base64Image,
      //'name': molePic.path.split('/').last
    };

    print(data);

    final url = "https://betterlife.845.co.il/api/flutter/uploadImg.php";
    setState(() {
      submitLoading = true;
    });


    var response = await http.post(url, body: data);

    print(response.statusCode);

    // var jsonData;
    // if (response.statusCode == 200) {
    //   jsonData = convert.jsonDecode(response.body);
    // } else {
    //   print("Error getting data.");
    // }

    setState(() {
      submitLoading = false;
    });    







    // print(jsonData);


    
    // if(jsonData.isEmpty) {
    //   print('ok');
    //   // Navigator.pop(context);
    // }
    // else {
    //   String error = '';
    //   jsonData.forEach((er) {
    //     error += er + ' -' + '\n';
    //   });

    //   Alert(
    //     context: context,
    //     type: AlertType.warning,
    //     title: "שגיאה",
    //     buttons: [
    //     DialogButton(
    //       child: Text(
    //         "סגור",
    //         style: TextStyle(color: Colors.white, fontSize: 14),
    //       ),
    //       onPressed: () => Navigator.pop(context),
    //       width: 120,
    //       height: 40,
    //     )
    //   ],
    //     desc: error
    //   ).show();
    // }
  }
}