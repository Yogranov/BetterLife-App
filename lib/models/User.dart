import 'package:betterlife/models/mole-details.dart';
import 'package:betterlife/models/mole.dart';
import 'package:betterlife/shared_ui/constant.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class User {

  String id;
  String email;
  String firstName;
  String lastName;
  String token;


  User({this.id, this.email, this.firstName, this.lastName, this.token});

  static Future<User> getUserByToken(String token) async {
    String url = 'https://betterlife.845.co.il/api/flutter/getUserData.php';

    Map data = {
      'TOKEN': Constant.apiToken,
      'userToken': token
    };

    var response = await http.post(url, body: data);
    var jsonData = null;
    if (response.statusCode == 200)
      jsonData = convert.jsonDecode(response.body);
    else
      print('Request failed with status: ${response.statusCode}.');
    
    return User(id: jsonData['Id'].toString(), email: jsonData['Email'], firstName: jsonData['FirstName'], lastName: jsonData['LastName'], token: token);
  }

  Future<List> getMoles() async {


    List<Mole> moles = [];
    String url = 'https://betterlife.845.co.il/api/flutter/getMolesData.php';

    Map data = {
      'TOKEN': Constant.apiToken,
      'userToken': token
    };

    var response = await http.post(url, body: data);
    List<dynamic> jsonData = null;
    if (response.statusCode == 200)
      jsonData = convert.jsonDecode(response.body);
    else
      print('Request failed with status: ${response.statusCode}.');

    for (var i = 0; i < jsonData.length; i++) {
      List<MoleDetails> moleDetails = [];

      Map<String, dynamic> mole = convert.jsonDecode(jsonData[i]);
      for (var i = 0; i < mole["details"].length; i++) {

        Map<String, dynamic> moleDetailsJson = mole["details"][i];
        moleDetails.add(MoleDetails(
          imgUrl: moleDetailsJson["imgUrl"],
          size: moleDetailsJson["size"],
          color: moleDetailsJson["color"],
          benignPred: moleDetailsJson["benignPred"],
          malignantPred: moleDetailsJson["malignantPred"],
          createTime: moleDetailsJson["createTime"],
          doctor: moleDetailsJson["doctor"] ?? '',
          diagnosis: moleDetailsJson["diagnosis"] ?? '',
          riskLevel: moleDetailsJson["riskLevel"] ?? '',
          diagnosisCreateTime: moleDetailsJson["diagnosisCreateTime"] ?? '',
        ));

      }
      moles.add(Mole(id: mole["Id"], location: mole["Location"], createTime: mole["CreateTime"], details: moleDetails));
    }

    return moles;
  }

}