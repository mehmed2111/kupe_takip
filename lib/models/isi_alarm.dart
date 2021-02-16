import 'package:flutter/material.dart';
import 'package:kupe/constants.dart';

class IsiAlarm extends StatefulWidget {
  @override
  _IsiAlarmState createState() => _IsiAlarmState();
}

class _IsiAlarmState extends State<IsiAlarm> {
  bool isiAlarm = false;

  void _isiAlarmOnChanged(bool newValue) => setState(() {
        isiAlarm = newValue;

        if (isiAlarm) {
          print(newValue);
        } else {
          print(newValue);
        }
      });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Switch(
          value: isiAlarm,
          onChanged: _isiAlarmOnChanged,
          activeTrackColor: kMainKupeColor,
          activeColor: Colors.white,
        ),
        Text(
          'Isı Alarmı',
          style: TextStyle(color: kLoginDarkBackground, fontSize: 18.0),
        ),
      ],
    );
  }
}
