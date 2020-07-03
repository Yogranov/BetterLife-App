import 'dart:convert';

import 'package:betterlife/models/mole-details.dart';
import 'package:intl/intl.dart';

class Mole {
  
  int id;
  String location;
  DateTime createTime;
  List<MoleDetails> details;

  Mole({this.id, this.location, this.createTime, this.details});

  Mole.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        location = json['location'],
        createTime = json['createTime'],
        details = json['details'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'location': location,
        'createTime': DateFormat('y-MM-d H:m:ss').format(createTime),
        'details': this.detailsToJsonList()
      };

  List<Map<String, dynamic>> detailsToJsonList() {
    List<Map<String, dynamic>> allDetails = [];
    this.details.map((detail) {
      print(detail.color);
      allDetails.add(detail.toJson());
    });
    return allDetails;
  }
}