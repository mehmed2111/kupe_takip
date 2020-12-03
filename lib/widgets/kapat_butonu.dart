import 'package:flutter/material.dart';

class KapatButonu extends StatelessWidget {
  final Function onPressed;

  KapatButonu({@required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 110),
      child: MaterialButton(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        color: Color(0xFF1d2136),
        elevation: 5.0,
        height: 42.0,
        child: Text(
          'Kapat',
          style: TextStyle(color: Colors.white),
        ),
        onPressed: onPressed,
      ),
    );
  }
}
