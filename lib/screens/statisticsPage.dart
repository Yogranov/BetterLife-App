import 'dart:convert';
import 'dart:math';

import 'package:betterlife/models/User.dart';
import 'package:betterlife/shared_ui/indicator.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'home.dart';

class StatisticsPage extends StatefulWidget {
  Map statistics;
  Map diagram;
  User user;

  

  StatisticsPage(user) {
    this.user = user;
    diagram = (user.statistics["riskDiagram"]);    
  }

  @override
  _StatisticsPageState createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  int touchedIndex;

  Future<Null> refreshData() async {    
    await widget.user.getStatistics();
    widget.diagram = (widget.user.statistics["riskDiagram"]);
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => refreshData(),
      child: ListView(
        children: <Widget>[
          Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                SizedBox(height: 25.0,),
                Padding(
                padding: EdgeInsets.symmetric(vertical: 1.0, horizontal: 10.0),
                child: Card(
                  child: 
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        "כמות השומות שנבדקו: ${widget.user.statistics["molesCount"]}",
                        textAlign: TextAlign.right,
                        style: TextStyle(fontSize: 18)),
                      SizedBox(height: 10,),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircleAvatar(backgroundImage: AssetImage('assets/moleSymbol.png')),
                      ),
                    ],
                  ),
                ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 10.0),
              child: Card(
                child: 
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    SizedBox(height: 10,),
                    Text(
                      "בדיקה אחרונה בוצע לפני ${widget.user.statistics["lastCheck"]} ימים",
                      textAlign: TextAlign.right,
                      style: TextStyle(fontSize: 18)),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(backgroundImage: AssetImage('assets/moleSymbol.png')),
                    ),
                  ],
                ),
              ),
            ),

            ],
          ),
          SizedBox(height: 100,),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Text("סיכום אבחון רופאים"),
                Row(
                children: <Widget>[
                  Expanded(
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: PieChart(
                        PieChartData(
                          borderData: FlBorderData(
                            show: false,
                          ),
                          sectionsSpace: 0,
                          centerSpaceRadius: 40,
                          sections: buildDiagram()[1]
                        ),
                      ),
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      ...buildDiagram()[0],
                      SizedBox(
                        height: 18,
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 28,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }



  List<dynamic> buildDiagram() {
    List<dynamic> returnList = [];
    List<PieChartSectionData> diagram = [];
    List<Indicator> indicators = [];

    int colorKey = 0;
    List colors = [Colors.red, Colors.yellow, Colors.blue, Colors.accents, Colors.brown];


    widget.diagram.forEach((key, value) {

      double percents = value/widget.user.statistics["molesCount"];
      Color color = colors[colorKey];
      diagram.add(
        PieChartSectionData(
              color: color,
              value: percents,
              title: (percents*100).round().toString() + '%',
              radius: 50,
              titleStyle: TextStyle(
                  fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
            )
      );

      indicators.add(
        Indicator(
          color: colors[colorKey],
          text: key,
          isSquare: true,
        )
      );
      colorKey++;
    });
    returnList.add(indicators);
    returnList.add(diagram);

    return returnList;
  }

}