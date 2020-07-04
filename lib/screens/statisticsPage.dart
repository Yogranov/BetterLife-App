import 'dart:convert';
import 'dart:math';

import 'package:betterlife/shared_ui/indicator.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StatisticsPage extends StatefulWidget {
  Map statistics;
  Map diagram;

  StatisticsPage(statistics) {
    diagram = (statistics["riskDiagram"]);
    this.statistics = statistics;
    
  }

  @override
  _StatisticsPageState createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  int touchedIndex;


  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 20.0,),
              Padding(
              padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 4.0),
              child: Card(
                child: 
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    SizedBox(height: 10,),
                    Text(
                      "כמות השומות שנבדקו: ${widget.statistics["molesCount"]}",
                      textAlign: TextAlign.right,
                      style: TextStyle(fontSize: 18)),
                    SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(backgroundImage: AssetImage('assets/moleSymbol.png')),
                    ),
                    SizedBox(height: 10,),
                  ],
                ),
              ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 4.0),
            child: Card(
              child: 
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  SizedBox(height: 10,),
                  Text(
                    "בדיקה אחרונה בוצע לפני ${widget.statistics["lastCheck"]} ימים",
                    textAlign: TextAlign.right,
                    style: TextStyle(fontSize: 18)),
                  SizedBox(height: 10,),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(backgroundImage: AssetImage('assets/moleSymbol.png')),
                  ),
                  SizedBox(height: 10,),
                ],
              ),
            ),
          ),

          ],
        ),

        Column(
          mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Text("סיכום אבחון רופאים"),
              Row(
              children: <Widget>[
                SizedBox(
                  height: 18,
                ),
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
                const SizedBox(
                  width: 28,
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }



  List<dynamic> buildDiagram() {
    List<dynamic> returnList = [];
    List<PieChartSectionData> diagram = [];
    List<Indicator> indicators = [];

    int colorKey = 0;
    List colors = [Colors.red, Colors.yellow, Colors.black, Colors.blue];


    widget.diagram.forEach((key, value) {

      double percents = value/widget.statistics["molesCount"];
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