import 'package:flutter/material.dart';
import 'package:kupe/constants.dart';

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
        style: TextStyle(color: kLoginDarkBackground, fontSize: 18.0),
      ),
      value: isiAlarm,
      onChanged: _isiAlarmOnChanged,
      activeColor: kMainKupeColor,
      controlAffinity: ListTileControlAffinity.leading,
    );
  }
}
