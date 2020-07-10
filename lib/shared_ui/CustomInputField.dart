import 'package:flutter/material.dart';

class CustomInputField extends StatelessWidget {
  Icon fieldIcon;
  String hintText;
  dynamic returnValue;

  CustomInputField(this.fieldIcon, this.hintText, this.returnValue,
      [String emailOrPassword = 'email']);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: 250,
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
                width: 200,
                height: 60,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: hintText,
                        fillColor: Colors.white,
                        filled: true),
                    style: TextStyle(fontSize: 20.0, color: Colors.black),
                    textAlign: TextAlign.right,
                    onChanged: (val) {
                        returnValue = val;
                    }
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: fieldIcon,
              ),
            ],
          )),
    );
  }
}
