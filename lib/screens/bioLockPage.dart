import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:betterlife/screens/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:betterlife/screens/login.dart';

class BioLockPage extends StatefulWidget {
  String userToken;
  BioLockPage({this.userToken});

  @override
  _BioLockPageState createState() => _BioLockPageState();
}

class _BioLockPageState extends State<BioLockPage> {
  SharedPreferences pref;

  final LocalAuthentication auth = LocalAuthentication();
  bool _canCheckBiometrics;
  List<BiometricType> _availableBiometrics;


  Future<void> _authenticate() async {
    bool authenticated = false;
    try {
      authenticated = await auth.authenticateWithBiometrics(
          localizedReason: 'סרוק טביעת אצבע על מנת להתחבר למערכת',
          useErrorDialogs: true,
          stickyAuth: true);
    } on PlatformException catch (e) {
      print(e);
    }
    if (!mounted) return;

    if(authenticated) {
      pref = await SharedPreferences.getInstance();
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => Home(token: pref.getString("UserToken"),)), (Route<dynamic> route) => false);  
    } else
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => Login()), (Route<dynamic> route) => false);
    

    return authenticated;
  }


@override
  void initState() {
    _authenticate();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: 
        Center(
          child:
            Text("fingerprint"),
        ),
    );
  }

}