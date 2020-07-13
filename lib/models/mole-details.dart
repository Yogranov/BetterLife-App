import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

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

  MoleDetails.fromJson(Map<String, dynamic> json)
      : imgUrl = json['imgUrl'],
        img = json['img'],
        figure = json['figure'],
        surface = json['surface'],
        size = json['size'],
        color = json['color'],
        benignPred = json['benignPred'],
        malignantPred = json['malignantPred'],
        createTime = json['createTime'],
        doctor = json['doctor'],
        diagnosis = json['diagnosis'],
        riskLevel = json['figure'],
        diagnosisCreateTime = json['diagnosisCreateTime'];

  Map<String, dynamic> toJson() => {
        'imgUrl': imgUrl,
        'img': img.toString(),
        'figure': figure.toString(),
        'surface': surface.toString(),
        'size': size,
        'color': color,
        'benignPred': benignPred,
        'malignantPred': malignantPred,
        'createTime':  DateFormat('y-MM-d H:m:ss').format(createTime),
        'doctor': doctor,
        'diagnosis': diagnosis,
        'riskLevel': riskLevel,
        'diagnosisCreateTime': DateFormat('y-MM-d H:m:ss').format(diagnosisCreateTime),
      };



}