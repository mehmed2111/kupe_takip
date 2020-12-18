import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
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
  final int deger;

  HayvanMarkerlari(
      {this.ad,
      this.sagDurumu,
      this.isi,
      this.cinsiyet,
      this.renk,
      this.sonKonT,
      this.deger});

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
                MarkerInfoWindow(
                  ad: 'Boncuk',
                  sagDurumu: 'İyi',
                  isi: '37.5',
                  cinsiyet: 'Erkek',
                  renk: 'Kahverengi',
                  sonKonT: '11.12.2020',
                  deger: deger,
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
