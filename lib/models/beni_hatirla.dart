import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kupe/constants.dart';

class BeniHatirla extends StatefulWidget {
  @override
  _BeniHatirlaState createState() => _BeniHatirlaState();
}

class _BeniHatirlaState extends State<BeniHatirla> {
  bool beniHatirla = false;

  void _beniHatirlaOnChanged(bool newValue) => setState(() {
        beniHatirla = newValue;

        if (beniHatirla) {
          print(beniHatirla);
          print('if in içinde');
        } else {
          print(beniHatirla);
          print('else in içinde');
        }
      });

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Text(
        'Beni Hatırla',
        style: TextStyle(color: kLoginDarkBackground, fontSize: 18.0),
      ),
      value: beniHatirla,
      onChanged: _beniHatirlaOnChanged,
      activeColor: kMainKupeColor,
      controlAffinity: ListTileControlAffinity.leading,
    );

    /*Row(
      children: [
        Switch(
          value: beniHatirla,
          onChanged: _beniHatirlaOnChanged,
          activeTrackColor: kMainKupeColor,
          activeColor: Colors.white,
        ),
        Text('Beni Hatırla',
            style: TextStyle(color: kLoginDarkBackground, fontSize: 18.0)),
      ],
    );*/
  }
}
