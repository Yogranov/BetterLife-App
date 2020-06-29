import 'package:betterlife/models/mole-details.dart';
import 'package:betterlife/models/mole.dart';
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
      body: PageView.builder(
        
        scrollDirection: Axis.horizontal,
        itemCount: mole.details.length,
        itemBuilder: (context, index) {
          return Column(
            children: <Widget>[
              Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                child: 
                  Text(
                    
                    "${mole.location} - ${DateFormat('d/MM/yy k:m').format(mole.createTime)}",
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
                    progressColor: mole.details[index].malignantPred < 50 ? Colors.greenAccent : Colors.redAccent,
                    percent: mole.details[index].malignantPred/100,
                    animation: true,
                    radius: 100.0,
                    lineWidth: 15.0,
                    circularStrokeCap: CircularStrokeCap.round,
                    center: Text(mole.details[index].malignantPred.toString() + '%'),
                  ),
                  Text(mole.details[index].riskLevel),
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
                        child: Text("תאריך: ${DateFormat('d/MM/yy k:m').format(mole.details[index].createTime)}",),
                      ),
                      Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Text("גודל: ${mole.details[index].size} ממ"),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Text("צבע: ${mole.details[index].color}"),
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
                      Text(
                        '\n' + 
                        'ד"ר ${mole.details[index].doctor} ${DateFormat('d/MM/yy k:m').format(mole.details[index].diagnosisCreateTime)}',
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
                    child: Text(mole.details[index].diagnosis,
                    textAlign: TextAlign.right,),
                  ),
                  
                  Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 8.0),
                      child: Text(
                        'רמת סכנה: ${mole.details[index].riskLevel}',
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
                        child: mole.details[index].img,
                      ),
                  ),
                  SizedBox(width: 10,),
                  Container(
                    width: MediaQuery.of(context).size.width*0.45,
                    child:
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: mole.details[index].surface,
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
          );
        }
      ),
    );
  }
}