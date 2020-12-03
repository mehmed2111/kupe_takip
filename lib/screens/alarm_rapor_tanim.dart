import 'package:flutter/material.dart';
import 'package:kupe/functions/bolge_ihlal_onchanged.dart';
import 'package:kupe/functions/isi_alarmi.dart';
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
          child: Theme(
            data: Theme.of(context).copyWith(accentColor: Color(0xFF5CB3AB)),
            child: Container(
              height: 355,
              width: 360,
              child: ListView(
                controller: ScrollController(keepScrollOffset: false),
                children: [
                  Text(
                    'Alarm & Rapor Tanımlama',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Color(0xFF1d2136), fontSize: 25.0),
                  ),
                  SizedBox(height: 20.0),
                  BolgeihlalOnChanged(),
                  IsiAlarmi(),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: RoundedButton(
                      colour: Color(0xFF5CB3AB),
                      buttonTitle: 'GÜNCELLE',
                      onPressed: () {
                        /*daha sonra veritabanı ile karşılaştırılarak yapılacak*/
                      },
                    ),
                  ),
                  SizedBox(height: 30.0),
                  KapatButonu(onPressed: () {
                    Navigator.pop(context);
                  })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
