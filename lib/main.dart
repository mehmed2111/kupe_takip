import 'package:flutter/material.dart';
import 'package:kupe/bildirim_deneme.dart';
import 'package:kupe/screens/HayvanMarkerlari.dart';
import 'package:kupe/screens/alarm_rapor_tanim.dart';
import 'package:kupe/screens/dostlarin.dart';
import 'package:kupe/screens/dostlarin_guncelle.dart';
import 'package:kupe/screens/kullanici_profili.dart';
import 'package:kupe/screens/google_maps_page.dart';
import 'package:kupe/screens/home_page.dart';
import 'package:kupe/screens/login_page.dart';
import 'package:kupe/screens/profil_guncelle.dart';
import 'package:kupe/screens/saglik_takip.dart';
import 'package:kupe/screens/sifre_degistir.dart';
import 'package:kupe/screens/sifremi_unuttum.dart';
import 'package:flutter/services.dart';

void main() => runApp(Kupe());

class Kupe extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //use the app only in portrait mode. Disables device orientation
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
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
        HayvanMarkerlari.id: (context) => HayvanMarkerlari(),
        LoadingScreen.id: (context) => LoadingScreen(),
        DostlariniGuncelle.id: (context) => DostlariniGuncelle(),
      },
    );
  }
}
