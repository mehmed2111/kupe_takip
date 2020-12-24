import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kupe/constants.dart';
import 'package:kupe/widgets/kapat_butonu.dart';
import 'package:kupe/widgets/kullanici_bilgileri.dart';

class KullaniciProfili extends StatelessWidget {
  static const String id = 'dialog_popup';

  final int kullid;
  final String ad;
  final String adres;
  final String telNo;
  final String email;
  final String kayitliVet;

  KullaniciProfili(
      {this.kullid,
      this.ad,
      this.adres,
      this.telNo,
      this.email,
      this.kayitliVet});

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
            height: 450.0,
            //width: 360.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage('images/logo.jpg'),
                      radius: 40.0,
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Text(
                      'Kullanıcı Profili',
                      style: TextStyle(
                        color: kLoginDarkBackground,
                        fontSize: 25.0,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.0),
                Expanded(
                  child: Theme(
                    data:
                        Theme.of(context).copyWith(accentColor: kMainKupeColor),
                    child: ListView(
                      controller: ScrollController(keepScrollOffset: false),
                      children: [
                        KullaniciBilgileri(
                            kullaniciBilg: 'Kullanıcı ID:',
                            kullaniciIcerik: kullid.toString()),
                        KullaniciBilgileri(
                            kullaniciBilg: 'Adınız:', kullaniciIcerik: ad),
                        KullaniciBilgileri(
                            kullaniciBilg: 'Adresiniz:',
                            kullaniciIcerik: adres),
                        KullaniciBilgileri(
                            kullaniciBilg: 'Telefon numaranız:',
                            kullaniciIcerik: telNo),
                        KullaniciBilgileri(
                            kullaniciBilg: 'Mail adresiniz:',
                            kullaniciIcerik: email),
                        KullaniciBilgileri(
                            kullaniciBilg: 'Kayıtlı veterineriniz:',
                            kullaniciIcerik: kayitliVet),
                      ],
                    ),
                  ),
                ),
                KapatButonu(onPressed: () {
                  Navigator.pop(context);
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
