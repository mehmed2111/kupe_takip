import 'package:flutter/material.dart';
import 'package:kupe/constants.dart';
import 'package:kupe/models/region_exit_on_changed.dart';
import 'package:kupe/models/isi_alarm.dart';
import 'package:kupe/widgets/kapat_button.dart';
import 'package:kupe/widgets/rounded_button.dart';

class AlarmReportDescription extends StatefulWidget {
  static const String id = 'alarm_report_description';
  /*final bool regionAlarmValue;

  AlarmReportDescription({this.regionAlarmValue});*/

  @override
  _AlarmReportDescriptionState createState() => _AlarmReportDescriptionState();
}

class _AlarmReportDescriptionState extends State<AlarmReportDescription> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.25),
      body: SafeArea(
        child: Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
          elevation: 16.0,
          child: Container(
              height: 350.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 20.0),
                  Text(
                    'Alarm & Rapor Tanımlama',
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(color: kLoginDarkBackground, fontSize: 25.0),
                  ),
                  SizedBox(height: 20.0),
                  Expanded(
                    child: Theme(
                      data: Theme.of(context)
                          .copyWith(accentColor: kMainKupeColor),
                      child: ListView(
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        controller: ScrollController(keepScrollOffset: false),
                        children: [
                          RegionExitOnChanged(),
                          IsiAlarm(),
                          SizedBox(height: 20.0),
                          RoundedButton(
                            colour: kMainKupeColor,
                            buttonTitle: 'Kaydet',
                            onPressed: () {
                              /*daha sonra veritabanı ile karşılaştırılarak yapılacak*/
                              /*setState(() {
                                print(widget.regionAlarmValue);
                              });*/
                            },
                          ),
                          SizedBox(height: 20.0),
                        ],
                      ),
                    ),
                  ),
                  //SizedBox(height: 20.0),
                  KapatButton(onPressed: () {
                    Navigator.pop(context);
                  }),
                ],
              )),
        ),
      ),
    );
  }
}
