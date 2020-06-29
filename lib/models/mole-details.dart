import 'dart:ffi';

import 'package:flutter/cupertino.dart';

class MoleDetails {

  String imgUrl;
  Image img;
  Image figure;
  Image surface;
  int size;
  String color;
  int benignPred;
  int malignantPred;
  DateTime createTime;
  String doctor;
  String diagnosis;
  String riskLevel;
  DateTime diagnosisCreateTime;


  MoleDetails({this.imgUrl, this.img, this.figure, this.surface, this.size, this.color, this.benignPred, this.malignantPred, this.createTime, this.doctor, this.diagnosis, this.riskLevel, this.diagnosisCreateTime});
}