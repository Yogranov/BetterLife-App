import 'package:betterlife/screens/bioLockPage.dart';
import 'package:betterlife/screens/home.dart';
import 'package:betterlife/screens/login.dart';
import 'package:flare_loading/flare_loading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {

  SharedPreferences pref;

  checkLoginStatus() async {
    pref = await SharedPreferences.getInstance();
    if(pref.getString('UserToken') == null)
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => Login()), (Route<dynamic> route) => false);
    else if(pref.getBool('bioLock') != null)
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => BioLockPage(userToken: pref.getString("UserToken"),)), (Route<dynamic> route) => false);  
    else
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => Home(token: pref.getString("UserToken"),)), (Route<dynamic> route) => false);  
  }

  @override
  Widget build(BuildContext context) {
    // print(pref.getString("UserToken") == null);
    checkLoginStatus();
    return Scaffold(
      body: 
        Center(
          child: FlareLoading(
            width: MediaQuery.of(context).size.width *0.5,
            name: 'assets/flare/loading-animation-sun-flare.flr', 
            loopAnimation: 'active',
            onError: null,
            onSuccess: null,
        ),
      ),
    );
  }
}