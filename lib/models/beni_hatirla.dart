import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kupe/constants.dart';
import 'package:kupe/widgets/nav_menu.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RememberMe extends StatefulWidget {
  final String username;
  RememberMe({this.username});
  @override
  _RememberMeState createState() => _RememberMeState();
}

class _RememberMeState extends State<RememberMe> {
  bool rememberMe = false;

  void rememberMeOnChanged(bool newValue) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    rememberMe = newValue;
    setState(() {
      if (rememberMe) {
        prefs.setString('username', widget.username);
        NavMenu(rememberMeValue: rememberMe);
      } else {
        prefs.setString('username', null);
        NavMenu(rememberMeValue: rememberMe);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Switch(
          value: rememberMe,
          onChanged: rememberMeOnChanged,
          activeTrackColor: kMainKupeColor,
          activeColor: Colors.white,
        ),
        Text('Beni Hatırla',
            style: TextStyle(color: kLoginDarkBackground, fontSize: 18.0)),
      ],
    );

    /*CheckboxListTile(
      title: Text(
        'Beni Hatırla',
        style: TextStyle(color: kLoginDarkBackground, fontSize: 18.0),
      ),
      value: beniHatirla,
      onChanged: _beniHatirlaOnChanged,
      activeColor: kMainKupeColor,
      controlAffinity: ListTileControlAffinity.leading,
    );*/
  }
}
