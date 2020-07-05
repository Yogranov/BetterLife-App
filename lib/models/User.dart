import 'package:betterlife/models/mole-details.dart';
import 'package:betterlife/models/mole.dart';
import 'package:betterlife/shared_ui/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'Address.dart';

class User {

  String id;
  String email;
  String firstName;
  String lastName;
  String token;
  String phoneNumber;
  Address address;
  String personId;
  DateTime birthdate;
  int haveHistory;
  int sex;

  User({this.id, this.email, this.firstName, this.lastName, this.token, this.phoneNumber, this.address, this.birthdate, this.haveHistory, this.personId, this.sex});

  static Future<User> getUserByToken(String token) async {
    String url = 'https://betterlife.845.co.il/api/flutter/getUserData.php';

    Map data = {
      'TOKEN': Constant.apiToken,
      'userToken': token
    };
    var response = await http.post(url, body: data);
    var jsonData ;
    if (response.statusCode == 200)
      jsonData = convert.jsonDecode(response.body);
    else
      print('Request failed with status: ${response.statusCode}.');
    
    Address address = await Address.getCity(jsonData['address'], jsonData['cityId']);

    return User(
      id: jsonData['Id'].toString(),
      email: jsonData['Email'],
      firstName: jsonData['FirstName'],
      lastName: jsonData['LastName'],
      token: token,
      phoneNumber: jsonData["phoneNumber"],
      address: address,
      birthdate: DateTime.parse(jsonData['birthdate']),
      personId: jsonData['personId'],
      haveHistory: jsonData['haveHistory'],
      sex: jsonData['sex']
    );
  }

  Future<List> getMoles() async {
    List<Mole> moles = [];
    String url = 'https://betterlife.845.co.il/api/flutter/getMolesData.php';
    String imgUrl = 'https://betterlife.845.co.il/api/flutter/getImg.php';
    Map data = {
      'TOKEN': Constant.apiToken,
      'userToken': token
    };

    Map imgData = {
      'TOKEN': Constant.apiToken,
      'userToken': token,
      'dir': '',
      'imgUrl': ''
    };

    var response = await http.post(url, body: data);
    List<dynamic> jsonData = [];
    if (response.statusCode == 200)
      jsonData = convert.jsonDecode(response.body);
    else
      print('Request failed with status: ${response.statusCode}.');

    for (var i = 0; i < jsonData.length; i++) {
      List<MoleDetails> moleDetails = [];

      Map<String, dynamic> mole = convert.jsonDecode(jsonData[i]);
      for (var i = 0; i < mole["details"].length; i++) {
        Map<String, dynamic> moleDetailsJson = mole["details"][i];
        imgData['imgUrl'] = moleDetailsJson["imgUrl"];
        
        imgData['dir'] = 'regular';
        http.Response imgRequest = await http.post(imgUrl, body: imgData);
        var imgBytes = imgRequest.bodyBytes;

        imgData['dir'] = 'figure';
        http.Response figureRequest = await http.post(imgUrl, body: imgData);
        var figureBytes = figureRequest.bodyBytes;

        imgData['dir'] = 'surface';
        http.Response surfaceRequest = await http.post(imgUrl, body: imgData);
        var surfaceBytes = surfaceRequest.bodyBytes;
        moleDetails.add(MoleDetails(
          imgUrl: moleDetailsJson["imgUrl"],
          img: Image.memory(imgBytes),
          figure: Image.memory(figureBytes),
          surface: Image.memory(surfaceBytes),
          size: moleDetailsJson["size"],
          color: moleDetailsJson["color"],
          benignPred: moleDetailsJson["benignPred"],
          malignantPred: moleDetailsJson["malignantPred"],
          createTime: DateTime.parse(moleDetailsJson["createTime"]),
          doctor: moleDetailsJson["doctor"] ?? '',
          diagnosis: moleDetailsJson["diagnosis"] ?? 'אין אבחנת רופא',
          riskLevel: moleDetailsJson["riskLevel"] ?? '',
          diagnosisCreateTime: DateTime.parse(moleDetailsJson["diagnosisCreateTime"] ?? '1990-01-01'),
        ));

      }
      moles.add(Mole(id: mole["Id"], location: mole["Location"], createTime: DateTime.parse(mole["CreateTime"]), details: moleDetails));
    }
    return moles;
  }

  Future<dynamic> getStatistics() async {
    String url = 'https://betterlife.845.co.il/api/flutter/getStatistics.php';

    Map data = {
      'TOKEN': Constant.apiToken,
      'userToken': token
    };

    var response = await http.post(url, body: data);
    var jsonData;
    if (response.statusCode == 200)
      jsonData = convert.jsonDecode(response.body);
    else
      print('Request failed with status: ${response.statusCode}.');

    return jsonData;
  }

}