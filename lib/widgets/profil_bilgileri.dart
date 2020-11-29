import 'package:flutter/material.dart';
import 'package:kupe/constants.dart';

class ProfilBilgileri extends StatelessWidget {
  final String titleBilg;
  final String hintText;

  ProfilBilgileri({this.titleBilg, this.hintText});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          titleBilg,
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Color(0xFF1d2136),
              fontSize: 18.0,
              fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10.0),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            keyboardType: TextInputType.text,
            textAlign: TextAlign.center,
            cursorColor: Color(0xFF5CB3AB),
            decoration: kTextFieldDecoration.copyWith(hintText: hintText),
          ),
        ),
        SizedBox(height: 10.0),
      ],
    );
  }
}
