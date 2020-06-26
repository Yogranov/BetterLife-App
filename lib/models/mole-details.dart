import 'dart:ffi';

class MoleDetails {

  String imgUrl;
  int size;
  String color;
  int benignPred;
  int malignantPred;
  String createTime;
  String doctor;
  String diagnosis;
  String riskLevel;
  String diagnosisCreateTime;


  MoleDetails({this.imgUrl, this.size, this.color, this.benignPred, this.malignantPred, this.createTime, this.doctor, this.diagnosis, this.riskLevel, this.diagnosisCreateTime});
}