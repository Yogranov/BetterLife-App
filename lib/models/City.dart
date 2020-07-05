import 'package:betterlife/shared_ui/constant.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;


class City {
  int cityId;
  String hebrewName;
  String englishName;

  City({this.cityId, this.hebrewName, this.englishName});

  factory City.fromJson(Map<String, dynamic> parsedJson) {
    return City(
      cityId: parsedJson["Id"],
      hebrewName: parsedJson["HebrewName"] as String,
      englishName: parsedJson["EnglishName"] as String,
    );
  }
  
  // static Future<List<City>> getAll() async {
  //   List<City> list = [];
  //   String url = 'https://betterlife.845.co.il/api/flutter/getCities.php';

  //   Map data = {
  //     'TOKEN': Constant.apiToken,
  //   };

  //   var response = await http.post(url, body: data);
  //   List<dynamic> jsonData ;
  //   if (response.statusCode == 200)
  //     jsonData = convert.jsonDecode(response.body);
  //   else
  //     print('Request failed with status: ${response.statusCode}.');

  //   jsonData.map((city) {
  //     list.add(City(cityId: city["Id"], hebrewName: city["HebrewName"], englishName: city["EnglishName"]));
  //   });

  //   return list;


  // }



}
