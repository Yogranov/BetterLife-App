import 'package:barcode_scan/barcode_scan.dart';
import 'package:betterlife/models/User.dart';
import 'package:betterlife/screens/moleList.dart';
import 'package:betterlife/screens/newMole.dart';
import 'package:betterlife/screens/settings.dart';
import 'package:betterlife/screens/statisticsPage.dart';
import 'package:betterlife/shared_ui/constant.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flare_loading/flare_loading.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'login.dart';

class Home extends StatefulWidget {
  String token;

  Home({this.token});
  static int currentPage = 0;
  static String pageName = 'שומות';
  static BoxDecoration backgroundColor = BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        colors: [Colors.red, Colors.blue],
      ),
    );

  @override
  _Home createState() => _Home();
}


class _Home extends State<Home> {
  static User user;
  List<Widget> tabs;


  refresh() {
    setState(() {});
  }

  void loadData() async {
    user = await User.getUserByToken(widget.token);
    if(!user.enable) {
      SharedPreferences pref = await SharedPreferences.getInstance();
      pref.clear();
      pref.commit();
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => Login()), (Route<dynamic> route) => false);
    }


    setState(() {});
  }

  List<String> tabName = [
    'שומות',
    'הוספת שומה',
    'סטטיסטיקה'
  ];

  List<BoxDecoration> tabsBackground = [
    BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        colors: [Colors.red, Colors.blue],
      ),
    ),

    BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        colors: [Colors.blue, Colors.red],
      ),
    ),

    BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        colors: [Colors.blueGrey[400], Colors.purple],
      ),
    ),
  ];


  changeTabs() {
    if(user != null)
      tabs = [
        user.moles == null ? Center(child: Text('loading...')) : MoleList(user: user),
        NewMole(user: user, notifyParent: refresh,),
        user.statistics == null ? Center(child: Text('לא קיימת סטטיסטיקה', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32.0),)) : StatisticsPage(user),
      ];
    else
      tabs = [
        FlareLoading(
          width: MediaQuery.of(context).size.width *0.5,
          name: 'assets/flare/loading-animation-sun-flare.flr', 
          loopAnimation: 'active',
          onError: null,
          onSuccess: null,
        ),

        FlareLoading(
          width: MediaQuery.of(context).size.width *0.5,
          name: 'assets/flare/loading-animation-sun-flare.flr', 
          loopAnimation: 'active',
          onError: null,
          onSuccess: null,
        ),

        FlareLoading(
          width: MediaQuery.of(context).size.width *0.5,
          name: 'assets/flare/loading-animation-sun-flare.flr', 
          loopAnimation: 'active',
          onError: null,
          onSuccess: null,
        ),
      ];
  }

  @override
  void initState() {
    loadData();
    // super.initState();
  }

  @override
  Widget build(BuildContext context) {
    changeTabs();
    return new Scaffold(
      body: 
      Container(
        height: MediaQuery.of(context).size.height,
        decoration: Home.backgroundColor,
        child: ListView(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 15.0, left: 20.0, right: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Image.asset('assets/BetterLifeLogoWhite.png', scale: 1.5,),
                  SizedBox(width: 100,),
                  IconButton(
                    icon: Icon(Icons.dashboard),
                    iconSize: 28,
                    color: Colors.white,
                    onPressed: () async {
                      Map<String, String> lang = {
                        'cancel': 'יציאה',
                        'flash_on': 'הפעל פנס',
                        'flash_off': 'כבה פנס',
                      };
                      var result = await BarcodeScanner.scan(options: ScanOptions(strings: lang));
                      Map data = {
                        'TOKEN': Constant.apiToken,
                        'userToken': user.token,
                        'qrCode': result.rawContent
                      };

                      final url = "https://betterlife.845.co.il/api/flutter/qrCodeStore.php";
                      if(result.rawContent.length >= 128)
                        await http.post(url, body: data);

                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.settings),
                    iconSize: 28,
                    color: Colors.white,
                    onPressed: () => showModalBottomSheet(context: context,isScrollControlled: true , builder: (context) {
                      return Settings(user: user);
                    }),
                  ),
                ],
              ),
            ),
            SizedBox(height: 15.0),
            Padding(
              padding: EdgeInsets.only(right: 60.0),
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: Text(
                  Home.pageName,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 32.0
                  ),
                ),
              ),
            ),
            SizedBox(height:20.0),
            Container(
              height: MediaQuery.of(context).size.height - 241.0,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.only(topRight: Radius.circular(65.0)),
              ),
              child: 
              ClipRRect(
                borderRadius: BorderRadius.only(topRight: Radius.circular(65.0)),
                child:
                  tabs[Home.currentPage],
              ),
            )
          ],
        ),
      ),
  
      
      
      
      
      bottomNavigationBar: 
      
        CurvedNavigationBar(
          index: Home.currentPage,
          buttonBackgroundColor: Colors.redAccent,
          color: Colors.grey[50],
          backgroundColor: Colors.grey[200],
          height: 75,
          animationDuration: Duration(milliseconds: 300),
          // animationCurve: Curves.bounceInOut,
          items: <Widget>[
            Icon(Icons.dns, size: 30, color: Colors.grey[800]),
            Icon(Icons.camera, size: 30, color: Colors.grey[800]),
            Icon(Icons.insert_chart, size: 30, color: Colors.grey[800]),
          ],
          onTap: (index) {
            setState(() {
              Home.backgroundColor = tabsBackground[index];
              Home.pageName = tabName[index];
              Home.currentPage = index;
            });
          },
        ),
      

    );
  }

}
