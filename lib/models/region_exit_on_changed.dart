import 'package:flutter/material.dart';
import 'package:kupe/constants.dart';

class RegionExitOnChanged extends StatefulWidget {
  @override
  _RegionExitOnChangedState createState() => _RegionExitOnChangedState();
}

class _RegionExitOnChangedState extends State<RegionExitOnChanged> {
  bool regionExitAlarm = false;

  void _regionExitOnChanged(bool newValue) {
    regionExitAlarm = newValue;

    setState(() {
      if (regionExitAlarm) {
        //AlarmReportDescription(regionAlarmValue: regionExitAlarm);
        print(newValue);
      } else {
        //AlarmReportDescription(regionAlarmValue: regionExitAlarm);
        print(newValue);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Switch(
          value: regionExitAlarm,
          onChanged: _regionExitOnChanged,
          activeTrackColor: kMainKupeColor,
          activeColor: Colors.white,
        ),
        Text(
          'Bölge İhlal Alarmı',
          style: TextStyle(color: kLoginDarkBackground, fontSize: 18.0),
        ),
      ],
    );
  }
}
