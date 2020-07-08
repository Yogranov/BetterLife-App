import 'package:betterlife/models/mole.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:betterlife/shared_ui/shared_ui.dart';

class MolePage extends StatelessWidget {
  
  Mole mole;
  MolePage({this.mole});
  ScrollController _scrollController = new ScrollController();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("שומה מספר ${mole.id.toString()}"),
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
              return Container(
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
                // margin: EdgeInsets.symmetric(horizontal: 5.0),
                child: 
                  Column(
                    children: <Widget>[
                      Center(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Container(
                        child: 
                          Text(
                            "${mole.location} - ${DateFormat('d/MM/yy k:mm').format(mole.createTime)}",
                            style: TextStyle(
                              fontSize: 24,
                            ),
                          ),
                      ),
                    ),
                  ),
                  SharedUI.drawLine(40),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "A.I",
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          CircularPercentIndicator(
                            progressColor: moleDetail.malignantPred < 50 ? Colors.greenAccent : Colors.redAccent,
                            percent: moleDetail.malignantPred/100,
                            animation: true,
                            radius: 100.0,
                            lineWidth: 15.0,
                            circularStrokeCap: CircularStrokeCap.round,
                            center: Text(moleDetail.malignantPred.toString() + '%'),
                          ),
                          Text(moleDetail.riskLevel),
                        ],
                      ),
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
                    ],
                  ),
                  SizedBox(height: 15),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
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
                            textAlign: TextAlign.right,),
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
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width*0.45,
                            child:
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: moleDetail.img,
                              ),
                          ),
                          SizedBox(width: 10,),
                          if(moleDetail.surface != null)
                            Container(
                              width: MediaQuery.of(context).size.width*0.45,
                              child:
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: moleDetail.surface,
                                ),
                            ),
                          SizedBox(height: 10,),

                        ],
                      ),
                    ],
                  ),
                  
                  // Container(
                  //   width: MediaQuery.of(context).size.width*0.5,
                  //   child:
                  //     ClipRRect(
                  //       borderRadius: BorderRadius.circular(8.0),
                  //       child: Image.asset('assets/moles/figure.jpg'),
                  //     ),
                  // ),
                    ],
                  ),
              );
            },
          );
        }).toList(),
      )

    );
  }
}