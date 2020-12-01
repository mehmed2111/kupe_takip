import 'package:flutter/material.dart';

class IsiAlarmi extends StatefulWidget {
  @override
  _IsiAlarmiState createState() => _IsiAlarmiState();
}

class _IsiAlarmiState extends State<IsiAlarmi> {
  bool isiAlarm = false;

  void _isiAlarmOnChanged(bool newValue) => setState(() {
        isiAlarm = newValue;

        if (isiAlarm) {
          print(newValue);
          print('if in içinde true donmesi lazım');
        } else {
          print(newValue);
        }
      });

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Text(
        'Isı Alarmı',
        style: TextStyle(color: Color(0xFF1d2136), fontSize: 18.0),
      ),
      value: isiAlarm,
      onChanged: _isiAlarmOnChanged,
      activeColor: Color(0xFF5CB3AB),
      controlAffinity: ListTileControlAffinity.leading,
    );
  }
}
