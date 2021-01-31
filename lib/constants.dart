import 'package:flutter/material.dart';

//fetched id's
int loggedUserID = 0;
var animalID = 0;

//for progress indicator control
bool showSpinner = false;

//for pass toggle icons
bool obscurePassword = true;
bool obscurePassword2 = true;
bool obscurePassword3 = true;
bool obscurePassword4 = true;
bool obscurePassword5 = true;
bool obscurePassword6 = true;

//App const colors
const kMainKupeColor = Color(0xFF5CB3AB);
const kLoginDarkBackground = Color(0xFF1d2136);
const kLoginLightDarkBackground = Color(0xFF323244);

//Login, update, save buttons style
const kSendButtonTextStyle = TextStyle(
  color: Color(0xFF5CB3AB),
  fontWeight: FontWeight.bold,
  fontSize: 18.0,
);

Widget icon;
//TextFields decorations
const kTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xFF5CB3AB), width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xFF5CB3AB), width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);
