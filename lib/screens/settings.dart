import 'dart:convert';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:betterlife/models/City.dart';
import 'package:betterlife/models/User.dart';
import 'package:betterlife/shared_ui/constant.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login.dart';

Widget row(City city) {
   return Row(
     mainAxisAlignment: MainAxisAlignment.spaceBetween,
     children: <Widget>[
       Text(
         city.hebrewName,
         style: TextStyle(fontSize: 16.0),
       ),
       SizedBox(
         width: 10.0,
       ),
       Text(
         city.englishName,
       ),
     ],
   );
 }


class Settings extends StatefulWidget {
  User user;
  Settings({this.user});

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  SharedPreferences pref;
  
  DateTime selectedDate = DateTime.now();
  AutoCompleteTextField searchTextField;
  GlobalKey<AutoCompleteTextFieldState<City>> key = new GlobalKey();
  static List<City> cities = new List<City>();
  bool loading = true;
  bool submitLoading = false;

  bool changePassword;
  String oldPassword = '';
  String newPassword = '';
  String repeatPassword = '';

  String firstName;
  String lastName;
  String phoneNumber;
  String email;
  String personId;
  DateTime birthdate;
  String street;
  int cityId;
  int sex;
  bool haveHistory;

  void preperePref() async {
    pref = await SharedPreferences.getInstance();
  }

  void getCities() async {
    Map data = {
      'TOKEN': Constant.apiToken,
    };
    final url = "https://betterlife.845.co.il/api/flutter/getCities.php";

    var response = await http.post(url, body: data);
    if (response.statusCode == 200) {
      cities = loadCities(response.body);
      setState(() {
        loading = false;
      });
    } else {
      print("Error getting cities.");
    }
  }
    
  static List<City> loadCities(String jsonString) {
    final parsed = json.decode(jsonString).cast<Map<String, dynamic>>();
    return parsed.map<City>((json) => City.fromJson(json)).toList();
  }

  void bioLock(bool lockOrNot) {
    if(lockOrNot)
      pref.setBool('bioLock', true);
    else
      if(pref.getBool('bioLock') != null)
        pref.remove('bioLock');
  }


  @override
  void initState() {
    preperePref();
    if(widget.user == null)
      Navigator.pop(context);

    sex = widget.user.sex;
    haveHistory = widget.user.haveHistory == 1 ? true : false;
    firstName = widget.user.firstName;
    lastName = widget.user.lastName;
    phoneNumber = widget.user.phoneNumber;
    email = widget.user.email;
    personId = widget.user.personId;
    birthdate = widget.user.birthdate;
    street = widget.user.address.street;
    cityId = widget.user.address.cityId;

    changePassword = false;

    getCities(); 
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return widget.user == null ? Text('Loading') : Container(
      height: 700,
      color: Colors.transparent,
      child:
        Directionality(
          textDirection: TextDirection.rtl,
            child: Card(
              elevation: 4.0,
              color: Colors.grey[50],
              margin: EdgeInsets.symmetric(horizontal: 5),
              shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(topRight: Radius.circular(15), topLeft: Radius.circular(15))),
              child: ListView(
                children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(right: 20.0),
                            child: Text('הגדרות', style: TextStyle(fontSize: 22),),
                          ),
                          Row(
                            children: <Widget>[
                              Text("יציאה"),
                              IconButton(
                                icon: Icon(Icons.exit_to_app, size: 32,),
                                onPressed: () async {
                                  pref.clear();
                                  pref.commit();
                                  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => Login()), (Route<dynamic> route) => false);
                                },
                              ),
                            ],
                          ),
                        ],
                      ),

                      Card(
                        color: Colors.grey[50],
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    "נעילה ביומטרית",
                                    style: TextStyle(
                                      fontWeight:FontWeight.bold,
                                      color: Colors.grey[800],
                                      fontSize: 18
                                    ),
                                  ),
                                  Switch(
                                    value: pref.getBool('bioLock') ?? false,
                                    onChanged: (value){
                                      setState(() {
                                        bioLock(value); 
                                      });
                                    },
                                    activeTrackColor: Colors.red[300],
                                    activeColor: Colors.red,
                                  ),
                                ],
                              ),
                              Text("אופציה זו תנעל את האפליקציה ותאפשר כניסה על ידי זיהוי ביומטרי בלבד.", style: TextStyle(color: Colors.grey[600]),),
                            ],
                          ),
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: Center(child: Text('עריכת פרופיל', style: TextStyle(fontSize: 18),)),
                      ),

                      Padding(
                        padding: EdgeInsets.only(right: 12, top: 20, bottom: 5),
                        child: Text('שם פרטי'),
                      ),
                      Center(
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.95,
                          child: TextFormField(
                            keyboardType: TextInputType.text,
                            cursorColor: Color(0xFF9b9b9b),
                            textAlign: TextAlign.right,
                            initialValue: widget.user.firstName,
                            decoration: InputDecoration(hintText: 'שם פרטי', prefixIcon: Icon(Icons.account_circle)),
                            validator: (val) => val.isEmpty ? 'אנא הכנס שם פרטי' : null,
                            onChanged: (val) {
                              setState(() => firstName = val);
                              }
                          ),
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.only(right: 12, top: 20, bottom: 5),
                        child: Text('שם משפחה'),
                      ),
                      Center(
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.95,
                          child: TextFormField(
                            textAlign: TextAlign.right,
                            initialValue: widget.user.lastName,
                            decoration: InputDecoration(hintText: 'שם משפחה', prefixIcon: Icon(Icons.account_circle)),
                            validator: (val) => val.isEmpty ? 'אנא הכנס שם משפחה' : null,
                            onChanged: (val) {
                              setState(() => lastName = val);
                              }
                          ),
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.only(right: 12, top: 20, bottom: 5),
                        child: Text('מספר טלפון'),
                      ),
                      Center(
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.95,
                          child: TextFormField(
                            textAlign: TextAlign.right,
                            initialValue: widget.user.phoneNumber,
                            decoration: InputDecoration(hintText: 'מספר טלפון', prefixIcon: Icon(Icons.phone)),
                            validator: (val) => val.isEmpty ? 'אנא הכנס טלפון טלפון' : null,
                            onChanged: (val) {
                              setState(() => phoneNumber = val);
                            }
                          ),
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.only(right: 12, top: 20, bottom: 5),
                        child: Text('דואר אלקטרוני'),
                      ),
                      Center(
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.95,
                          child: TextFormField(
                            textAlign: TextAlign.right,
                            initialValue: widget.user.email,
                            decoration: InputDecoration(hintText: 'דואר אלקטרוני', prefixIcon: Icon(Icons.email)),
                            validator: (val) => val.isEmpty ? 'אנא הכנס דואר אלקטרוני' : null,
                            onChanged: (val) {
                              setState(() => email = val);
                              }
                          ),
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.only(right: 12, top: 20, bottom: 5),
                        child: Text('תעודת זהות'),
                      ),
                      Center(
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.95,
                          child: TextFormField(
                            textAlign: TextAlign.right,
                            initialValue: widget.user.personId,
                            decoration: InputDecoration(hintText: 'תעודת זהות', prefixIcon: Icon(Icons.assignment_ind)),
                            validator: (val) => val.isEmpty ? 'אנא הכנס תעודת זהות' : null,
                            onChanged: (val) {
                              setState(() => personId = val);
                              }
                          ),
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.only(right: 12, top: 20, bottom: 5),
                        child: Text('כתובת'),
                      ),
                      Center(
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.95,
                          child: TextFormField(
                            textAlign: TextAlign.right,
                            initialValue: widget.user.address.street,
                            decoration: InputDecoration(hintText: 'כתובת', prefixIcon: Icon(Icons.location_on)),
                            validator: (val) => val.isEmpty ? 'אנא הכנס כתובת' : null,
                            onChanged: (val) {
                              setState(() => street = val);
                              }
                          ),
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.only(right: 12, top: 20, bottom: 5),
                        child: Text('עיר'),
                      ),
                      Center(
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.95,
                          child: Directionality(
                           textDirection: TextDirection.rtl,
                              child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                loading ? CircularProgressIndicator() :
                                 searchTextField = AutoCompleteTextField<City>(
                                  minLength: 2,
                                  key: key,
                                  clearOnSubmit: false,
                                  suggestions: cities,
                                  style: TextStyle(color: Colors.black, fontSize: 16.0),
                                  decoration: InputDecoration(hintText: widget.user.address.cityName, prefixIcon: Icon(Icons.location_city)),
                                  itemFilter: (item, query) {
                                    return item.hebrewName.startsWith(query.toLowerCase());
                                  },
                                  itemSorter: (a, b) {
                                    return a.hebrewName.compareTo(b.hebrewName);
                                  },
                                  itemSubmitted: (item) {
                                    cityId = item.cityId;
                                    setState(() {
                                      searchTextField.textField.controller.text = item.hebrewName;
                                    });
                                  },
                                  itemBuilder: (context, item) {
                                    // ui for the autocomplete row
                                    return row(item);
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.only(right: 12, top: 20, bottom: 5),
                        child: Text('תאריך לידה'),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 12.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "${intl.DateFormat('d/MM/yy').format(birthdate)}".split(' ')[0],
                              style: TextStyle(fontSize: 18),
                            ),
                            SizedBox(width: 20,),
                            RaisedButton(
                              onPressed: (){
                                _selectDate(context);
                              },
                              child: Text('שנה תאריך'),
                            ),
                          ],
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.only(right: 12, top: 20, bottom: 5),
                        child: Text('מין'),
                      ),
                      Row(
                        children: <Widget>[
                          SizedBox(width: 20),
                          Container(
                            width: MediaQuery.of(context).size.width *0.8,
                            child: DropdownButton<String>(
                              value: sex == 0 ? 'זכר' : 'נקבה',
                              icon: Icon(Icons.person),
                              iconSize: 24,
                              elevation: 16,
                              style: TextStyle(color: Colors.deepPurple),
                              underline: Container(
                                height: 2,
                                color: Colors.deepPurpleAccent,
                              ),
                              onChanged: (String newValue) {
                                setState(() {
                                  sex = newValue == 'זכר' ? 0 : 1;
                                });
                              },
                              items: <String>['זכר', 'נקבה']
                                  .map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),

                      CheckboxListTile(
                        title: Text("בעל היסטוריה משפחתית של סרטן העור"),
                        value: haveHistory,
                        onChanged: (newValue) { 
                          setState(() {
                            haveHistory = newValue; 
                          }); 
                        },
                        controlAffinity: ListTileControlAffinity.leading,  //  <-- leading Checkbox
                      ),

                      CheckboxListTile(
                        title: Text("שינוי סיסמה"),
                        value: changePassword,
                        onChanged: (newValue) { 
                          setState(() {
                            changePassword = newValue; 
                          }); 
                        },
                        controlAffinity: ListTileControlAffinity.leading,  //  <-- leading Checkbox
                      ),

                      !changePassword ? Column() :
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[


                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 12.0),
                            child: Center(
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.95,
                                child: TextFormField(
                                  textAlign: TextAlign.right,
                                  decoration: InputDecoration(hintText: 'סיסמה ישנה', prefixIcon: Icon(Icons.vpn_key)),
                                  validator: (val) => val.isEmpty ? 'אנא הכנס סיסמה' : null,
                                  obscureText: true,
                                  onChanged: (val) {
                                    setState(() => oldPassword = val);
                                    }
                                ),
                              ),
                            ),
                          ),

                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 12.0),
                            child: Center(
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.95,
                                child: TextFormField(
                                  textAlign: TextAlign.right,
                                  decoration: InputDecoration(hintText: 'סיסמה חדשה', prefixIcon: Icon(Icons.vpn_key)),
                                  validator: (val) => val.isEmpty ? 'אנא הכנס סיסמה' : null,
                                  obscureText: true,
                                  onChanged: (val) {
                                    setState(() => newPassword = val);
                                    }
                                ),
                              ),
                            ),
                          ),

                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 12.0),
                            child: Center(
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.95,
                                child: TextFormField(
                                  
                                  textAlign: TextAlign.right,
                                  decoration: InputDecoration(hintText: 'אימות סיסמה', prefixIcon: Icon(Icons.vpn_key)),
                                  validator: (val) => val.isEmpty ? 'אנא הכנס סיסמה' : null,
                                  obscureText: true,
                                  onChanged: (val) {
                                    setState(() => repeatPassword = val);
                                    }
                                ),
                              ),
                            ),
                          ),


                        ],
                      ),
                    
                      SizedBox(height: 30,),
                      Center(
                        child: RaisedButton(
                          color: Colors.blueGrey[400],
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 20),
                            child: submitLoading ? CircularProgressIndicator() : Text(
                              'עדכון פרטים',
                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                            ),
                          ),
                          onPressed: () async {
                            updateDetails();
                            //Navigator.pop(context);
                          }
                        ),
                      ),
                      SizedBox(height: 30,),
                    ],
                  ),
                ),
              ],
          ),
            ),
        ),
    );
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1940, 1),
        lastDate: DateTime(2021));
    if (picked != null && picked != selectedDate)
      setState(() {
        birthdate = picked;
      });
  }

  void updateDetails() async {
    Map data = {
      'TOKEN': Constant.apiToken,
      'userToken': widget.user.token,

      'firstName': firstName,
      'lastName': lastName,
      'phoneNumber': phoneNumber,
      'email': email,
      'personId': personId,
      'address': street,
      'cityId': cityId.toString(),
      'sex': sex.toString(),
      'birthdate': birthdate.toString(),
      'haveHistory': haveHistory ? '1' : '0'
    };

    if(changePassword) {
      data['changePassword'] = changePassword ? '1' : '0';
      data['oldPassword'] = oldPassword;
      data['newPassword'] = newPassword;
      data['repeatPassword'] = repeatPassword;
    }
    
    final url = "https://betterlife.845.co.il/api/flutter/updateProfile.php";
    setState(() {
      submitLoading = true;
    });

    var response = await http.post(url, body: data);
    List<dynamic> jsonData;
    if (response.statusCode == 200) {
      jsonData = convert.jsonDecode(response.body);
    } else {
      print("Error getting data.");
    }

    setState(() {
      submitLoading = false;
    });    

    if(jsonData.isEmpty) {
      Navigator.pop(context);
    }
    else {
      String error = '';
      jsonData.forEach((er) {
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