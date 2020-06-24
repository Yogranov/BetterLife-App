import 'package:betterlife/models/mole-details.dart';

class Mole {
  
  int id;
  String location;
  DateTime createTime;
  List<MoleDetails> details;

  Mole({this.id, this.location, this.createTime, this.details});


  
}