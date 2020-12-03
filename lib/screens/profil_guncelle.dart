import 'package:flutter/material.dart';
import 'package:kupe/widgets/kapat_butonu.dart';
import 'package:kupe/widgets/profil_bilgileri.dart';
import 'package:kupe/widgets/rounded_button.dart';

class ProfilGuncelle extends StatelessWidget {
  static const String id = 'profil_guncelle';

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
              height: 600,
              width: 360,
              child: ListView(
                controller: ScrollController(keepScrollOffset: false),
                children: [
                  Text(
                    'Profil Güncelle',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Color(0xFF1d2136), fontSize: 25),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  ProfilBilgileri(
                    titleBilg: 'Mail adresi:',
                    hintText: 'Mail adresinizi giriniz..',
                  ),
                  ProfilBilgileri(
                    titleBilg: 'Telefon numarası:',
                    hintText: 'Telefon numaranızı giriniz..',
                  ),
                  ProfilBilgileri(
                    titleBilg: 'Adres bilgisi:',
                    hintText: 'Adresinizi giriniz..',
                  ),
                  ProfilBilgileri(
                    titleBilg: 'Veteriner:',
                    hintText: 'Yeni veteriner adını giriniz..',
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
                  SizedBox(height: 30.0),
                  KapatButonu(onPressed: () {
                    Navigator.pop(context);
                  }),
                  SizedBox(height: 10.0),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
