import 'package:betterlife/models/User.dart';
import 'package:betterlife/models/mole.dart';
import 'package:betterlife/screens/addDetailsToMole.dart';
import 'package:betterlife/screens/home.dart';
import 'package:betterlife/shared_ui/constant.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:betterlife/shared_ui/shared_ui.dart';

class MolePage extends StatelessWidget {
  
  User user;
  Mole mole;
  
  MolePage({this.mole, this.user});
  ScrollController _scrollController = new ScrollController();
  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Home.backgroundColor,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "${mole.location} - ${DateFormat('d/MM/yy k:mm').format(mole.createTime)}",
                style: TextStyle(
                  color: Colors.grey[200],
                  fontSize: 18
                ),
              ),
              IconButton(
                icon: Icon(Icons.add_a_photo, color: Colors.white, size: 28.0,),
                onPressed: () => showModalBottomSheet(context: context,isScrollControlled: true , builder: (context) {
                  return AddDetailsToMole(user: user, moleId: mole.id,);
                }),
              ),
            ],
          ),
          centerTitle: true,
        ),
        body:    
        CarouselSlider(
          options: CarouselOptions(
            height: MediaQuery.of(context).size.height,
            viewportFraction: 1.0,
            enlargeCenterPage: true,
            //autoPlay: true,
            enableInfiniteScroll: false,
          ),
          items: mole.details.map((moleDetail) {
            return Builder(
              builder: (BuildContext context) {
                return ListView(
                  children: <Widget>[
                    SizedBox(height: 10,),
                    Container(
                      margin: EdgeInsets.all(5),
                      // color: Colors.white,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[300]),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(.3),
                            blurRadius: 3,
                            offset: Offset(2, 7),
                          ),
                        ],
                      ),
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: <Widget>[
                          SizedBox(height: 20,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    "פרטים",
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                      fontSize: 18
                                    ),
                                  ),
                                  SizedBox(height: 10,),
                                  Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 5),
                                          child: Text("תאריך: ${DateFormat('d/MM/yy k:mm').format(moleDetail.createTime)}",),
                                        ),
                                        Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 5),
                                      child: Text("גודל: ${moleDetail.size} ממ"),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 5),
                                      child: Text("צבע: ${moleDetail.color}"),
                                    ),
                                      ],
                                  ),
                                ],
                              ),

                              Container(
                                width: MediaQuery.of(context).size.width*0.4,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: Hero(tag: moleDetail, child: moleDetail.img),
                                ),
                              ),
                              SizedBox(height: 20,),

                            ],
                          ),
                          SizedBox(height: 15),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.all(16.0),
                                child: Text(
                                  "אבחנת מחשב",
                                  style: TextStyle(
                                    fontSize: 22,
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  LinearPercentIndicator(
                                    width: MediaQuery.of(context).size.width *0.9,
                                    animation: true,
                                    lineHeight: 20.0,
                                    animationDuration: 1000,
                                    percent: moleDetail.malignantPred/100,
                                    center: Text(moleDetail.malignantPred.toString() + '%'),
                                    linearStrokeCap: LinearStrokeCap.roundAll,
                                    progressColor: moleDetail.malignantPred < 50 ? Colors.greenAccent : Colors.redAccent,
                                  ),
                                ],
                              ),
                              SizedBox(height: 5,),
                              Center(child: Text('סיכון מחושב: ' + Constant.calculateRiskLevel(moleDetail.malignantPred))),
                              SizedBox(height: 15,),
                            ],
                          ),

                          Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      Text( moleDetail.doctor == '' ? '' :
                                        '\n' + 
                                        'ד"ר ${moleDetail.doctor} ${DateFormat('d/MM/yy k:m').format(moleDetail.diagnosisCreateTime)}',
                                        style: TextStyle(fontSize: 10),
                                      ),
                                      SizedBox(width: 10,),
                                      Text(
                                        "אבחנה",
                                        style: TextStyle(fontSize: 22),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(moleDetail.diagnosis,
                                      textAlign: TextAlign.right,
                                    ),
                                  ),
                                  
                                ],
                              ),
                            ),
                          ),
                          Center(
                            child: Padding(
                              padding: EdgeInsets.only(top: 8.0),
                              child: Text( moleDetail.doctor == '' ? '' :
                                'רמת סכנה: ${moleDetail.riskLevel}',
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                            ),
                          ),
                          SizedBox(height: 25),
                          Column(
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  SizedBox(width: 10,),
                                  if(moleDetail.surface != null)
                                    Container(
                                      width: MediaQuery.of(context).size.width*0.38,
                                      child:
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(8.0),
                                          child: moleDetail.surface,
                                        ),
                                    ),
                                  SizedBox(height: 10,),

                                  if(moleDetail.surface != null)
                                    Container(
                                      width: MediaQuery.of(context).size.width*0.55,
                                      child:
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(8.0),
                                          child: moleDetail.figure,
                                        ),
                                    ),
                                  SizedBox(height: 10,),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            );
          }).toList(),
        )
      ),
    );
  }
}