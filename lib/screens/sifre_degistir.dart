import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kupe/constants.dart';
import 'package:kupe/widgets/kapat_butonu.dart';
import 'package:kupe/widgets/rounded_button.dart';

class SifreDegistir extends StatelessWidget {
  static const String id = 'sifre_degistir';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.25),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.0),
        child: Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
          elevation: 16.0,
          child: Container(
              height: 290,
              //width: 360,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 20.0),
                  Text(
                    'Şifre Değiştir',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Color(0xFF1d2136), fontSize: 25),
                  ),
                  SizedBox(height: 10.0),
                  Expanded(
                      child: Theme(
                    data: Theme.of(context)
                        .copyWith(accentColor: Color(0xFF5CB3AB)),
                    child: ListView(
                      controller: ScrollController(keepScrollOffset: false),
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.0),
                          child: TextField(
                            keyboardType: TextInputType.text,
                            textAlign: TextAlign.center,
                            cursorColor: Color(0xFF5CB3AB),
                            decoration: kTextFieldDecoration.copyWith(
                                hintText: 'Lütfen yeni şifrenizi giriniz..'),
                          ),
                        ),
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
                      ],
                    ),
                  )),
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
