import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SifremiUnuttumButonu extends StatelessWidget {
  final Function onPressed;

  SifremiUnuttumButonu({@required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48.0,
      child: RaisedButton(
        elevation: 5.0,
        color: Color(0xFF1d2136),
        onPressed: onPressed,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.vpn_key_rounded,
              color: Colors.white,
            ),
            SizedBox(width: 10.0),
            Text(
              'Şifremi Unuttum',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
