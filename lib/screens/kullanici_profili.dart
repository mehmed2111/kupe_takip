import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kupe/widgets/kapat_butonu.dart';
import 'package:kupe/widgets/kullanici_bilgileri.dart';

class KullaniciProfili extends StatelessWidget {
  static const String id = 'dialog_popup';

  final String kullid;
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
        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 0.0),
        child: Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(32.0)),
          elevation: 16.0,
          child: Theme(
            data: Theme.of(context).copyWith(accentColor: Color(0xFF5CB3AB)),
            child: Container(
              height: 400.0,
              width: 360.0,
              child: ListView(
                controller: ScrollController(keepScrollOffset: false),
                children: [
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
                          color: Color(0xFF1d2136),
                          fontSize: 25.0,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  KullaniciBilgileri(
                      kullaniciBilg: 'Kullanıcı ID:',
                      kullaniciIcerik: 'icerik gelecek..'),
                  KullaniciBilgileri(
                      kullaniciBilg: 'Adınız:',
                      kullaniciIcerik: 'icerik gelecek..'),
                  KullaniciBilgileri(
                      kullaniciBilg: 'Adresiniz:',
                      kullaniciIcerik: 'icerik gelecek..'),
                  KullaniciBilgileri(
                      kullaniciBilg: 'Telefon numaranız:',
                      kullaniciIcerik: 'icerik gelecek..'),
                  KullaniciBilgileri(
                      kullaniciBilg: 'Mail adresiniz:',
                      kullaniciIcerik: 'icerik gelecek..'),
                  KullaniciBilgileri(
                      kullaniciBilg: 'Kayıtlı veterineriniz:',
                      kullaniciIcerik: 'icerik gelecek..'),
                  SizedBox(
                    height: 30.0,
                  ),
                  /* Align(
                    alignment: Alignment.bottomCenter,
                    child: RaisedButton(
                      color: Color(0xFF5CB3AB),
                      child: Text(
                        'Kapat',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),*/
                  KapatButonu(onPressed: () {
                    Navigator.pop(context);
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
