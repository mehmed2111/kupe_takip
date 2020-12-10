import 'package:flutter/material.dart';
import 'package:kupe/bildirim_deneme.dart';
import 'package:kupe/screens/alarm_rapor_tanim.dart';
import 'package:kupe/screens/dostlarin.dart';
import 'package:kupe/screens/kullanici_profili.dart';
import 'package:kupe/screens/google_maps_page.dart';
import 'package:kupe/screens/home_page.dart';
import 'package:kupe/screens/login_page.dart';
import 'package:kupe/screens/profil_guncelle.dart';
import 'package:kupe/screens/saglik_takip.dart';
import 'package:kupe/screens/sifre_degistir.dart';
import 'package:kupe/screens/sifremi_unuttum.dart';

void main() => runApp(Kupe());

class Kupe extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: LoginPage.id,
      routes: {
        LoginPage.id: (context) => LoginPage(),
        HomePage.id: (context) => HomePage(),
        GoogleMapsPage.id: (context) => GoogleMapsPage(),
        KullaniciProfili.id: (context) => KullaniciProfili(),
        SifreDegistir.id: (context) => SifreDegistir(),
        ProfilGuncelle.id: (context) => ProfilGuncelle(),
        AlarmRaporTanim.id: (context) => AlarmRaporTanim(),
        SifremiUnuttum.id: (context) => SifremiUnuttum(),
        SaglikTakip.id: (context) => SaglikTakip(),
        Dostlarin.id: (context) => Dostlarin(),
        BildirimDeneme.id: (context) => BildirimDeneme(),
      },
    );
  }
}
