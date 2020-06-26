import 'package:betterlife/models/mole-details.dart';

class Mole {
  
  int id;
  String location;
  String createTime;
  List<MoleDetails> details;

  Mole({this.id, this.location, this.createTime, this.details});

  factory Mole.fromJson(Map<String, dynamic> json) 
  {
    // List<MoleDetails> details;
    
    // for(Map i in json["details"]){
    //   details.add(MoleDetails.fromJson(i));
    // }


    Mole(
        id: json["Id"],
        location: json["Location"],
        createTime: json["CreateTime"],
    );

    } 
  

  
}