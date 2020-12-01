import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
        style: TextStyle(color: Color(0xFF1d2136), fontSize: 18.0),
      ),
      value: beniHatirla,
      onChanged: _beniHatirlaOnChanged,
      activeColor: Color(0xFF1d2136),
      controlAffinity: ListTileControlAffinity.leading,
    );
  }
}
