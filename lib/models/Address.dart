import 'package:betterlife/shared_ui/constant.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class Address {
  String street;
  String cityName;
  int cityId;


  Address({this.street, this.cityId, this.cityName});

  static Future<Address> getCity(String street, String cityId) async {
    String url = 'https://betterlife.845.co.il/api/flutter/getCity.php';

    Map data = {
      'TOKEN': Constant.apiToken,
      'cityId': cityId
    };

    var response = await http.post(url, body: data);
    var jsonData ;
    if (response.statusCode == 200)
      jsonData = convert.jsonDecode(response.body);
    else
      print('Request failed with status: ${response.statusCode}.');

    return Address(street: street,cityId: int.parse(cityId), cityName: jsonData["HebrewName"]);
  }
  
}