import 'package:betterlife/models/User.dart';
import 'package:betterlife/screens/molePage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

class MoleList extends StatefulWidget {
  User user;

  MoleList({this.user});

  @override
  _MoleListState createState() => _MoleListState();
}

class _MoleListState extends State<MoleList> {
  
  List<Widget> moleList = [];
  
  void molesWidget() {
    moleList = [];
    if(widget.user.moles.isEmpty)
      moleList.add(
        Text(
          "אין שומות",
          style: TextStyle (
            fontWeight: FontWeight.bold,
            fontSize: 48.0
          ),
        ),
      );
    else
      widget.user.moles.forEach((mole) {

        var tmp = 
        InkWell(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => MolePage(mole: mole, user: widget.user)));
          },
          child:Container(
              margin: EdgeInsets.all(10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child:
                      Stack(
                        children: <Widget>[
                          Container(
                            width: 125,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20.0),
                              child: Hero(tag: mole.details[0], child: mole.details[0].img),
                            ),
                          ),
                          mole.details[0].doctor == '' ? Container() :
                          Padding(
                            padding: EdgeInsets.only(right: 5.0, top: 55),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(Radius.circular(20)),
                                border: Border.all(color: Colors.grey[400])
                              ),
                              child: Icon(
                                Icons.check_circle,
                                color: Colors.green,
                                size: 34,
                              ),
                            ),
                          ),
                        ],
                      ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  
                  Directionality(
                    textDirection: TextDirection.ltr,
                    child: Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(top: 10, right: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              mole.location,
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 5.0),
                              child: Text(mole.details[0].riskLevel),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 10.0),
                              child: Text(
                                "עודכן לאחרונה ${intl.DateFormat('dd/MM/yy').format(mole.details[0].createTime)}",
                                style: TextStyle(fontSize: 10),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 15.0, left: 8.0),
                        child: Text(
                          intl.DateFormat('dd/MM/yy').format(mole.createTime),
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 14.0),
                        child: Icon(
                          Icons.arrow_forward_ios, color: Colors.blueGrey,
                          size: 34,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
        );

        moleList.add(tmp);
      });
  }
  
  Future<Null> refreshData() async {
    await widget.user.getMoles();
    setState(() {
    });
  }


  @override
  Widget build(BuildContext context) {
    molesWidget();
    return RefreshIndicator(
      onRefresh: () => refreshData(),
      child: ListView(
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          Directionality(
            textDirection: TextDirection.rtl,
                      child: Column(
              children: <Widget>[
                ...moleList,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
