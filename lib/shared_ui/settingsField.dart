import 'package:flutter/material.dart';

const textInputDecoration = InputDecoration(
  fillColor: Color(0xffe9e9e9),
  filled: true,
  contentPadding: EdgeInsets.symmetric(horizontal: 20),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xffd9d9d9), width: 2.0)
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.pink, width: 2.0)
  ),
);












/*
class SettingsField extends StatelessWidget {
  Icon fieldIcon;
  String hintText;
  String initialValue;

  SettingsField(this.fieldIcon, this.hintText, this.initialValue, [String emailOrPassword = 'email']);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: EdgeInsets.only(top: 10.0),
      child: Container(
        width: MediaQuery.of(context).size.width*0.9,
        child: Material(
            elevation: 5.0,
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            color: Colors.deepOrange,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10.0),
                        bottomLeft: Radius.circular(10.0)),
                  ),
                  width: MediaQuery.of(context).size.width*0.9-50,
                  height: 40,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: TextFormField(
                      initialValue: initialValue,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: hintText,
                          fillColor: Colors.white,
                          filled: true),
                      style: TextStyle(fontSize: 16.0, color: Colors.black),
                      textAlign: TextAlign.right,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: fieldIcon,
                ),
              ],
            )),
      ),
    );
  }
}
*/