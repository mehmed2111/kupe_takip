import 'package:flutter/material.dart';
import 'package:kupe/constants.dart';

class RoundedButtonWithIcon extends StatelessWidget {
  final String btnTitle;
  final IconData icon;
  final Function onPressed;

  RoundedButtonWithIcon({this.btnTitle, this.icon, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      color: Colors.white,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: Icon(
              icon,
              color: kLoginDarkBackground,
              size: 20,
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              btnTitle,
              style: TextStyle(fontSize: 15, color: kLoginDarkBackground),
            ),
          ),
        ],
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(32.0),
        side: BorderSide(
          width: 1.0,
          color: kMainKupeColor,
        ),
      ),
      onPressed: onPressed,
    );
  }
}
