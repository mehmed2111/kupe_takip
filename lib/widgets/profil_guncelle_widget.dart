import 'package:flutter/material.dart';
import 'package:kupe/constants.dart';

class ProfilGuncelleWidget extends StatelessWidget {
  final String title;
  final String hintText;
  final controllerText;
  final Function onChanged;

  ProfilGuncelleWidget(
      {this.title, this.controllerText, this.hintText, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
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
            controller: controllerText,
            keyboardType: TextInputType.text,
            textAlign: TextAlign.center,
            cursorColor: kMainKupeColor,
            decoration: kTextFieldDecoration.copyWith(hintText: hintText),
            onChanged: onChanged,
          ),
        ),
        SizedBox(height: 10.0),
      ],
    );
  }
}
