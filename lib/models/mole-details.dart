
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
  String doctor = null;
  String diagnosis = null;
  String riskLevel = null;
  DateTime diagnosisCreateTime = null;


  MoleDetails({this.imgUrl, this.img, this.figure, this.surface, this.size, this.color, this.benignPred, this.malignantPred, this.createTime, this.doctor, this.diagnosis, this.riskLevel, this.diagnosisCreateTime});
}