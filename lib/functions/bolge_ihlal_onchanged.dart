import 'package:flutter/material.dart';

class BolgeihlalOnChanged extends StatefulWidget {
  @override
  _BolgeihlalOnChangedState createState() => _BolgeihlalOnChangedState();
}

class _BolgeihlalOnChangedState extends State<BolgeihlalOnChanged> {
  bool bolgeihlalAlarm = false;

  void _bolgeihlalOnChanged(bool newValue) => setState(() {
        bolgeihlalAlarm = newValue;

        if (bolgeihlalAlarm) {
          //bolge ihlali varsa..
          print(newValue);
          print('if in içinde true donmesi lazım');
        } else {
          //bolge ihlali yoksa..
          print(newValue);
        }
      });

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Text(
        'Bölge İhlal Alarmı',
        style: TextStyle(color: Color(0xFF1d2136), fontSize: 18.0),
      ),
      value: bolgeihlalAlarm,
      onChanged: _bolgeihlalOnChanged,
      controlAffinity: ListTileControlAffinity.leading,
      activeColor: Color(0xFF5CB3AB),
    );
  }
}
