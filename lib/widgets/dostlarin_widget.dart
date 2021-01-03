import 'package:flutter/material.dart';
import 'package:kupe/constants.dart';

class DostlarinWidget extends StatelessWidget {
  final String textTitle;
  final String hintText;
  final Function onChanged;

  DostlarinWidget({this.textTitle, this.hintText, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text(
        textTitle,
        textAlign: TextAlign.center,
        style: TextStyle(
            color: kLoginDarkBackground,
            fontSize: 18.0,
            fontWeight: FontWeight.bold),
      ),
      SizedBox(height: 10.0),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: TextField(
          keyboardType: TextInputType.name,
          textAlign: TextAlign.center,
          cursorColor: kMainKupeColor,
          decoration: kTextFieldDecoration.copyWith(hintText: hintText),
          onChanged: onChanged,
        ),
      ),
    ]);
  }
}
