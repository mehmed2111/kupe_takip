import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:kupe/bildirim_deneme.dart';
import 'package:kupe/screens/animal_history_tracking.dart';
import 'package:kupe/screens/region_delete_name.dart';
import 'package:kupe/screens/region_name.dart';
import 'package:kupe/widgets/hayvan_marker_widget.dart';
import 'package:kupe/screens/alarm_report_description.dart';
import 'package:kupe/screens/dostlarin_guncelle_pop_up.dart';
import 'package:kupe/screens/dostlarin_guncelle.dart';
import 'package:kupe/screens/kullanici_profili.dart';
import 'package:kupe/screens/google_maps_page.dart';
import 'package:kupe/screens/home_page.dart';
import 'package:kupe/screens/login_page.dart';
import 'package:kupe/screens/profil_guncelle.dart';
import 'package:kupe/screens/saglik_takip.dart';
import 'package:kupe/screens/password_change.dart';
import 'package:kupe/screens/password_forgot.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  //used shared_preference package in order to auto-login user
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var username = prefs.getString('username');
  print(username);
  runApp(
    MaterialApp(
      home: username == null ? Kupe(username: null) : Kupe(username: username),
    ),
  );
}

class Kupe extends StatelessWidget {
  final String username;
  Kupe({this.username});

  @override
  Widget build(BuildContext context) {
    //use the app only in portrait mode. Disables device orientation
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MaterialApp(
      //for tr lang support in calendar
      localizationsDelegates: [GlobalMaterialLocalizations.delegate],
      supportedLocales: [const Locale('en'), const Locale('tr')],
      home: LoginPage(username: username),
      routes: {
        LoginPage.id: (context) => LoginPage(),
        HomePage.id: (context) => HomePage(),
        GoogleMapsPage.id: (context) => GoogleMapsPage(),
        KullaniciProfili.id: (context) => KullaniciProfili(),
        PasswordChange.id: (context) => PasswordChange(),
        ProfilGuncelle.id: (context) => ProfilGuncelle(),
        AlarmReportDescription.id: (context) => AlarmReportDescription(),
        PasswordForgot.id: (context) => PasswordForgot(),
        SaglikTakip.id: (context) => SaglikTakip(),
        DostlarinGuncellePopUp.id: (context) => DostlarinGuncellePopUp(),
        BildirimDeneme.id: (context) => BildirimDeneme(),
        HayvanMarker.id: (context) => HayvanMarker(),
        DostlariniGuncelle.id: (context) => DostlariniGuncelle(),
        RegionName.id: (context) => RegionName(),
        RegionDeleteName.id: (context) => RegionDeleteName(),
        AnimalHistoryTracking.id: (context) => AnimalHistoryTracking(),
      },
    );
  }
}
