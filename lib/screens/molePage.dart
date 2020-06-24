import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:betterlife/shared_ui/shared_ui.dart';

class MolePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("asd"),
      ),
      body: ListView(
          children: <Widget>[
            Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  child: 
                    Text(
                      "יד ימין עליונה - 27/02/20",
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
                      progressColor: Colors.redAccent,
                      percent: 0.5,
                      animation: true,
                      radius: 100.0,
                      lineWidth: 15.0,
                      circularStrokeCap: CircularStrokeCap.round,
                      center: Text("50%"),
                    ),
                    Text("קיים חשש"),
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
                          child: Text("תאריך: 27/02/20 12:52",),
                        ),
                        Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Text("גודל: 20 ממ"),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Text("צבע: חום אדמדם"),
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
                          'ד"ר מיכאל 27/02/20',
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
                      child: Text('שדכגשדג שדגכשדג שדג כדש לנל חילךח ילךחי לח ךלחי לחי לךחי לחי לח ילח ילח יל חילח מל מ לח מ',
                      textAlign: TextAlign.right,),
                    ),
                    
                    Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 8.0),
                        child: Text(
                          'רמת סכנה: קיימת סכנה',
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
                          child: Image.asset('assets/moles/mole.jpg'),
                        ),
                    ),
                    SizedBox(width: 10,),
                    Container(
                      width: MediaQuery.of(context).size.width*0.45,
                      child:
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.asset('assets/moles/surf.jpg'),
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
  }
}