import 'package:flutter/material.dart';
import 'package:kupe/constants.dart';
import 'package:kupe/models/bolge_ihlal_onchanged.dart';
import 'package:kupe/models/isi_alarmi.dart';
import 'package:kupe/widgets/kapat_butonu.dart';
import 'package:kupe/widgets/rounded_button.dart';

class AlarmRaporTanim extends StatelessWidget {
  static const String id = 'alarm_rapor_tanim';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.25),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 0.0),
        child: Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
          elevation: 16.0,
          child: Container(
              height: 350.0,
              //width: 360.0,
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
                  SizedBox(height: 10.0),
                  Expanded(
                    child: Theme(
                      data: Theme.of(context)
                          .copyWith(accentColor: kMainKupeColor),
                      child: ListView(
                        controller: ScrollController(keepScrollOffset: false),
                        children: [
                          BolgeihlalOnChanged(),
                          IsiAlarmi(),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.0),
                            child: RoundedButton(
                              colour: kMainKupeColor,
                              buttonTitle: 'GÜNCELLE',
                              onPressed: () {
                                /*daha sonra veritabanı ile karşılaştırılarak yapılacak*/
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  //SizedBox(height: 20.0),
                  KapatButonu(onPressed: () {
                    Navigator.pop(context);
                  }),
                ],
              )),
        ),
      ),
    );
  }
}
