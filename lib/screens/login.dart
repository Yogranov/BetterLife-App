import 'package:betterlife/shared_ui/constant.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'home.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  String email = '';
  String password = '';

  bool _isLoading = false;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

 @override
  Widget build(BuildContext context) {

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: Form(
          key: _formKey,
          child: Container(
            child: Stack(
              children: <Widget>[
                ///////////  background///////////
                new Container(
                  decoration: new BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      stops: [0.0, 0.4, 0.9],
                      colors: [
                        Color(0xFFFF835F),
                        Color(0xFFFC663C),
                        Color(0xFFFF3F1A),
                      ],
                    ),
                  ),
                ),
                
                Positioned(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(
                            'assets/logo.png',
                            width: 100,
                            height: 100,
                          ),
                        ),
                        SizedBox(height: 20),
                        Card(
                          elevation: 4.0,
                          color: Colors.white,
                          margin: EdgeInsets.only(left: 20, right: 20),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                /////////////  Email//////////////
                                TextFormField(
                                  style: TextStyle(color: Color(0xFF000000)),
                                  cursorColor: Color(0xFF9b9b9b),
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.account_circle,
                                      color: Colors.grey,
                                    ),
                                    hintText: "דואר אלקטרוני",
                                    hintStyle: TextStyle(
                                        color: Color(0xFF9b9b9b),
                                        fontSize: 15,
                                        fontWeight: FontWeight.normal),
                                  ),
                                  onChanged: (val) => email = val,
                                  validator: (val) => val.isEmpty ? 'שדה חובה' : null,
                                ),

                                /////////////// password////////////////////
                                TextFormField(
                                  style: TextStyle(color: Color(0xFF000000)),
                                  cursorColor: Color(0xFF9b9b9b),
                                  keyboardType: TextInputType.text,
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.vpn_key,
                                      color: Colors.grey,
                                    ),
                                    hintText: "סיסמה",
                                    hintStyle: TextStyle(
                                        color: Color(0xFF9b9b9b),
                                        fontSize: 15,
                                        fontWeight: FontWeight.normal),
                                  ),
                                  onChanged: (val) => password = val,
                                  validator: (val) => val.isEmpty ? 'שדה חובה' : null,
                                ),
                                /////////////  LogIn Botton///////////////////
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: FlatButton(
                                    child: Padding(
                                      padding: EdgeInsets.only(top: 8, bottom: 8, left: 10, right: 10),
                                      child: Text(
                                        _isLoading? '...טוען' : 'התחבר',
                                        textDirection: TextDirection.ltr,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15.0,
                                          decoration: TextDecoration.none,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ),
                                    color: Color(0xFFFF835F),
                                    disabledColor: Colors.grey,
                                    shape: new RoundedRectangleBorder(
                                        borderRadius:
                                            new BorderRadius.circular(20.0)),
                                    onPressed: () {
                                      if(_formKey.currentState.validate()){
                                        setState(() {
                                          _isLoading = true;
                                        });
                                        _login();
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        ////////////   new account///////////////
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: InkWell(
                            onTap: () {
                              // Navigator.push(
                              //     context,
                              //     new MaterialPageRoute(
                              //         builder: (context) => SignUp()));
                            },
                            child: Text(
                              'צור משתמש חדש',
                              textDirection: TextDirection.ltr,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15.0,
                                decoration: TextDecoration.none,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _login() async {
      Map data = {
        'TOKEN': Constant.apiToken,
        'email': email,
        'password': password
      };

      
      final url = "https://betterlife.845.co.il/api/flutter/login.php";
      // setState(() {
      //   submitLoading = true;
      // });
      var response = await http.post(url, body: data);
      var jsonData;
      if (response.statusCode == 200)
        jsonData = convert.jsonDecode(response.body);
      else
        print("Error getting data.");
      
      
      if(jsonData['Token'] != null) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('UserToken', jsonData['Token']);
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => Home(token: jsonData['Token'],)), (Route<dynamic> route) => false);
      }
      else {
        setState(() {
          _isLoading = false;
        });

        String error = '';
        jsonData['Errors'].forEach((er) {
          error += er + ' -' + '\n';
        });

        Alert(
          context: context,
          type: AlertType.warning,
          title: "שגיאה",
          buttons: [
          DialogButton(
            child: Text(
              "סגור",
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
            onPressed: () => Navigator.pop(context),
            width: 120,
            height: 40,
          )
        ],
          desc: error
        ).show();


      }
        
      
    }
  
}