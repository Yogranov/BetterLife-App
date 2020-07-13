import 'dart:convert';

import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:betterlife/models/City.dart';
import 'package:betterlife/screens/login.dart';
import 'package:betterlife/shared_ui/constant.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:rflutter_alert/rflutter_alert.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController mailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();


  AutoCompleteTextField searchTextField;
  GlobalKey<AutoCompleteTextFieldState<City>> key = new GlobalKey();
  static List<City> cities = new List<City>();
  bool loading = true;
  bool submitLoading = false;

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

  DateTime selectedDate = DateTime.now();
  DateTime birthdate = DateTime.now();

  int sex = 0;
  bool haveHistory = false;

  String firstName;
  String lastName;
  String phoneNumber;
  String email;
  String password;
  String repeatPassword;
  String personId;
  int cityId = 320;
  String street;

  final _formKey = GlobalKey<FormState>();

@override
  void initState() {
    getCities();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red[400],
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: ListView(
          children: <Widget>[
            Form(
              key: _formKey,
              child: Container(
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
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
                                    /////////////// name////////////
                                    TextFormField(
                                      validator: (val) => val.length < 1 ? 'שדה חובה' : null,
                                      style: TextStyle(color: Color(0xFF000000)),
                                      cursorColor: Color(0xFF9b9b9b),
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                        prefixIcon: Icon(
                                          Icons.account_circle,
                                          color: Colors.grey,
                                        ),
                                        hintText: "שם פרטי",
                                        hintStyle: TextStyle(
                                            color: Color(0xFF9b9b9b),
                                            fontSize: 15,
                                            fontWeight: FontWeight.normal),
                                      ),
                                      onChanged: (val) {
                                        setState(() => firstName = val);
                                      }
                                    ),
                                    TextFormField(
                                      validator: (val) => val.length < 1 ? 'שדה חובה' : null,
                                      style: TextStyle(color: Color(0xFF000000)),
                                      cursorColor: Color(0xFF9b9b9b),
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                        prefixIcon: Icon(
                                          Icons.account_circle,
                                          color: Colors.grey,
                                        ),
                                        hintText: "שם משפחה",
                                        hintStyle: TextStyle(
                                            color: Color(0xFF9b9b9b),
                                            fontSize: 15,
                                            fontWeight: FontWeight.normal),
                                      ),
                                      onChanged: (val) {
                                        setState(() => lastName = val);
                                      }
                                    ),
                                    TextFormField(
                                      validator: (val) => val.length < 9 ? 'חייב להכיל לפחות 10 מספרים' : null,
                                      style: TextStyle(color: Color(0xFF000000)),
                                      cursorColor: Color(0xFF9b9b9b),
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                        prefixIcon: Icon(
                                          Icons.mobile_screen_share,
                                          color: Colors.grey,
                                        ),
                                        hintText: "מספר טלפון",
                                        hintStyle: TextStyle(
                                            color: Color(0xFF9b9b9b),
                                            fontSize: 15,
                                            fontWeight: FontWeight.normal),
                                      ),
                                      onChanged: (val) {
                                        setState(() => phoneNumber = val);
                                      }
                                    ),
                                    /////////////// Email ////////////
                                    TextFormField(
                                      validator: (val) => val.length < 1 ? 'שדה חובה' : null,
                                      style: TextStyle(color: Color(0xFF000000)),
                                      cursorColor: Color(0xFF9b9b9b),
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                        prefixIcon: Icon(
                                          Icons.mail,
                                          color: Colors.grey,
                                        ),
                                        hintText: "דואר אלקטרוני",
                                        hintStyle: TextStyle(
                                            color: Color(0xFF9b9b9b),
                                            fontSize: 15,
                                            fontWeight: FontWeight.normal),
                                      ),
                                      onChanged: (val) {
                                        setState(() => email = val);
                                      }
                                    ),
                                    TextFormField(
                                      validator: (val) => val.length < 7 ? '8 תווים ומעלה' : null,
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
                                      onChanged: (val) {
                                        setState(() => password = val);
                                      }
                                    ),
                                    TextFormField(
                                      validator: (val) => val.length < 7 ? '8 תווים ומעלה' : null,
                                      style: TextStyle(color: Color(0xFF000000)),
                                      cursorColor: Color(0xFF9b9b9b),
                                      keyboardType: TextInputType.text,
                                      obscureText: true,
                                      decoration: InputDecoration(
                                        prefixIcon: Icon(
                                          Icons.vpn_key,
                                          color: Colors.grey,
                                        ),
                                        hintText: "אימות סיסמה",
                                        hintStyle: TextStyle(
                                            color: Color(0xFF9b9b9b),
                                            fontSize: 15,
                                            fontWeight: FontWeight.normal),
                                      ),
                                      onChanged: (val) {
                                        setState(() => repeatPassword = val);
                                      }
                                    ),
                                    TextFormField(
                                      validator: (val) => val.length < 7 ? 'יש להכניס מספר מלא' : null,
                                      style: TextStyle(color: Color(0xFF000000)),
                                      cursorColor: Color(0xFF9b9b9b),
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                        prefixIcon: Icon(
                                          Icons.assignment_ind,
                                          color: Colors.grey,
                                        ),
                                        hintText: "תעודת זהות",
                                        hintStyle: TextStyle(
                                            color: Color(0xFF9b9b9b),
                                            fontSize: 15,
                                            fontWeight: FontWeight.normal),
                                      ),
                                      onChanged: (val) {
                                        setState(() => personId = val);
                                      }
                                    ),
                                    TextFormField(
                                      validator: (val) => val.length < 1 ? 'שדה חובה' : null,
                                      style: TextStyle(color: Color(0xFF000000)),
                                      cursorColor: Color(0xFF9b9b9b),
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                        prefixIcon: Icon(
                                          Icons.location_on,
                                          color: Colors.grey,
                                        ),
                                        hintText: "כתובת",
                                        hintStyle: TextStyle(
                                            color: Color(0xFF9b9b9b),
                                            fontSize: 15,
                                            fontWeight: FontWeight.normal),
                                      ),
                                      onChanged: (val) {
                                        setState(() => street = val);
                                      }
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
                                                decoration: InputDecoration(hintText: 'בחר עיר', prefixIcon: Icon(Icons.location_city)),
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
                                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                                      child: Row(
                                        children: <Widget>[
                                          SizedBox(width: 10),
                                          Icon(Icons.person, color: Colors.grey[500],),
                                          SizedBox(width: 10),
                                          Container(
                                            width: MediaQuery.of(context).size.width *0.7,
                                            child: DropdownButton<String>(
                                              value: sex == 0 ? 'זכר' : 'נקבה',
                                              icon: Icon(Icons.arrow_downward, color: Colors.grey[500],),
                                              iconSize: 24,
                                              elevation: 16,
                                              style: TextStyle(color: Colors.grey[500]),
                                              underline: Container(
                                                height: 2,
                                                color: Colors.grey[500],
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

                                    CheckboxListTile(
                                      title: Text("בעל היסטוריה משפחתית של סרטן העור", style: TextStyle(color: Colors.grey[500], fontSize: 14),),
                                      value: haveHistory,
                                      onChanged: (newValue) { 
                                        setState(() {
                                          haveHistory = newValue; 
                                        }); 
                                      },
                                      controlAffinity: ListTileControlAffinity.leading,  //  <-- leading Checkbox
                                    ),

                                    /////////////// SignUp Button ////////////
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: FlatButton(
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              top: 8, bottom: 8, left: 10, right: 10),
                                          child: Text(
                                           submitLoading ? '...יוצר' : 'צור חשבון',
                                            textDirection: TextDirection.ltr,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15.0,
                                              decoration: TextDecoration.none,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        ),
                                        color: Colors.red,
                                        disabledColor: Colors.grey,
                                        shape: new RoundedRectangleBorder(
                                            borderRadius:
                                                new BorderRadius.circular(20.0)),
                                        onPressed: () {
                                          if(_formKey.currentState.validate())
                                            signUp();
                                        },
                                      ),
                                    ),

                            

                                  ],
                                ),
                              ),
                            ),

                            /////////////// already have an account ////////////
                            Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      new MaterialPageRoute(
                                          builder: (context) => Login()));
                                },
                                child: Text(
                                  'כבר יש לי חשבון',
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
          ],
        ),
      ),
    );
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      helpText: 'בחירת תאריך',
      errorFormatText: 'פורמט לא חוקי',
      fieldLabelText: 'הזן תאריך',
      // locale: Locale('he', 'IL'),
      textDirection: TextDirection.rtl,
      cancelText: 'ביטול',
      confirmText: 'אישור',
      initialDate: selectedDate,
      firstDate: DateTime(1940, 1),
      lastDate: DateTime(2021));
    if (picked != null && picked != selectedDate)
      setState(() {
        birthdate = picked;
      });
  }

  void signUp() async {
    Map data = {
      'TOKEN': Constant.apiToken,
      'firstName': firstName,
      'lastName': lastName,
      'phoneNumber': phoneNumber,
      'email': email,
      'personId': personId,
      'address': street,
      'cityId': cityId.toString(),
      'sex': sex.toString(),
      'birthdate': birthdate.toString(),
      'haveHistory': haveHistory ? '1' : '0',
      'password': password,
      'repeatPassword': repeatPassword,
    };

    
    final url = "https://betterlife.845.co.il/api/flutter/signUp.php";
    setState(() {
      submitLoading = true;
    });

    var response = await http.post(url, body: data);
    var jsonData;
    if (response.statusCode == 200) {
      jsonData = convert.jsonDecode(response.body);
    } else {
      print("Error getting data.");
    }

    setState(() {
      submitLoading = false;
    });    

    if(jsonData == null || jsonData.isEmpty) {
      Alert(
        context: context,
        type: AlertType.success,
        title: "ההרשמה בוצעה בהצלחה!",
        buttons: [
        DialogButton(
          child: Text(
            "אישור",
            style: TextStyle(color: Colors.white, fontSize: 14),
          ),
          onPressed: () {
            Navigator.pop(context);
            Navigator.pop(context);
          } ,
          width: 120,
          height: 40,
        )
      ],
        desc: "יש לאמת את הדואר האלקטרוני לפני השימוש"
      ).show();
      
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