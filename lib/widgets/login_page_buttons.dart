import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginPageButtons extends StatelessWidget {
  final Function onPressed;
  final Icon icon;
  final String btnTitle;
  final Color color;

  LoginPageButtons(
      {@required this.onPressed, this.btnTitle, this.color, this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48.0,
      child: RaisedButton(
        elevation: 5.0,
        color: color,
        onPressed: onPressed,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: icon,
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                btnTitle,
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
