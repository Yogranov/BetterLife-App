import 'dart:convert';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:betterlife/models/City.dart';
import 'package:betterlife/models/User.dart';
import 'package:betterlife/screens/errorAlert.dart';
import 'package:betterlife/shared_ui/constant.dart';
import 'package:betterlife/shared_ui/settingsField.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:rflutter_alert/rflutter_alert.dart';

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
  
  DateTime selectedDate = DateTime.now();
  AutoCompleteTextField searchTextField;
  GlobalKey<AutoCompleteTextFieldState<City>> key = new GlobalKey();
  static List<City> cities = new List<City>();
  bool loading = true;
  bool error = true;

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

  @override
  void initState() {
    // TODO: implement initState
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

    getCities(); 
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      height: 700,
      child:
        Directionality(
          textDirection: TextDirection.rtl,
            child: ListView(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(
                    child: Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Text('עריכת פרופיל', style: TextStyle(fontSize: 18),),
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.only(right: 12, top: 20, bottom: 5),
                    child: Text('שם פרטי'),
                  ),
                  Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.95,
                      child: TextFormField(
                        textAlign: TextAlign.right,
                        initialValue: widget.user.firstName,
                        decoration: textInputDecoration.copyWith(hintText: 'שם פרטי'),
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
                        decoration: textInputDecoration.copyWith(hintText: 'שם משפחה'),
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
                        decoration: textInputDecoration.copyWith(hintText: 'מספר טלפון'),
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
                        decoration: textInputDecoration.copyWith(hintText: 'דואר אלקטרוני'),
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
                        decoration: textInputDecoration.copyWith(hintText: 'תעודת זהות'),
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
                        decoration: textInputDecoration.copyWith(hintText: 'כתובת'),
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
                              decoration: textInputDecoration.copyWith(hintText: widget.user.address.cityName),
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
                        width: MediaQuery.of(context).size.width *0.9,
                        child: DropdownButton<String>(
                          value: sex == 0 ? 'זכר' : 'נקבה',
                          icon: Icon(Icons.arrow_downward),
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

                
                  SizedBox(height: 30,),
                  Center(
                    child: RaisedButton(
                      color: Colors.pink[400],
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 20),
                        child: Text(
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
            ],
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
    
    final url = "https://betterlife.845.co.il/api/flutter/updateProfile.php";

    var response = await http.post(url, body: data);
    List<dynamic> jsonData;
    if (response.statusCode == 200) {
      jsonData = convert.jsonDecode(response.body);
    } else {
      print("Error getting data.");
    }
    

    if(jsonData == 0) {
      print("ok");
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