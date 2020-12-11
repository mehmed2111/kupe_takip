import 'package:flutter/material.dart';
import 'package:kupe/widgets/kapat_butonu.dart';
import 'package:kupe/widgets/marker_info_window.dart';
import '../constants.dart';

class HayvanMarkerlari extends StatelessWidget {
  static const String id = 'hayvan_marker';

  final String ad;
  final String sagDurumu;
  final String isi;
  final String cinsiyet;
  final String renk;
  final String sonKonT;

  HayvanMarkerlari(
      {this.ad,
      this.sagDurumu,
      this.isi,
      this.cinsiyet,
      this.renk,
      this.sonKonT});

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
                      'Boncuk',
                      style: TextStyle(
                        color: kLoginDarkBackground,
                        fontSize: 25.0,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.0),
                MarkerInfoWindow(
                  ad: 'Boncuk',
                  sagDurumu: 'İyi',
                  isi: '37.5',
                  cinsiyet: 'Erkek',
                  renk: 'Kahverengi',
                  sonKonT: '11.12.2020',
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
