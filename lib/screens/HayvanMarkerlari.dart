import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kupe/widgets/kapat_butonu.dart';
import '../constants.dart';

class HayvanMarkerlari extends StatelessWidget {
  static const String id = 'hayvan_marker';

  final String ad;
  final String sagDurumu;
  final String isi;
  final String cinsiyet;
  final String renk;
  final String sonKonT;
  final MarkerId deger;

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
                      ad,
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
                        Row(
                          children: [
                            SizedBox(width: 10.0),
                            Text(
                              'Adı:',
                              style: TextStyle(
                                  color: kLoginDarkBackground,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(width: 5.0),
                            Text(
                              ad,
                              style: TextStyle(
                                  color: kLoginDarkBackground, fontSize: 18.0),
                            ),
                          ],
                        ),
                        SizedBox(height: 10.0),
                        Row(
                          children: [
                            SizedBox(width: 10.0),
                            Text(
                              'Sağlık Durumu:',
                              style: TextStyle(
                                  color: kLoginDarkBackground,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(width: 5.0),
                            Flexible(
                              child: Text(
                                sagDurumu,
                                style: TextStyle(
                                    color: kLoginDarkBackground,
                                    fontSize: 18.0),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10.0),
                        Row(
                          children: [
                            SizedBox(width: 10.0),
                            Text(
                              'Isı:',
                              style: TextStyle(
                                  color: kLoginDarkBackground,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(width: 10.0),
                            Flexible(
                              child: Text(
                                isi,
                                style: TextStyle(
                                    color: kLoginDarkBackground,
                                    fontSize: 18.0),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10.0),
                        Row(
                          children: [
                            SizedBox(width: 10.0),
                            Text(
                              'Cinsiyet:',
                              style: TextStyle(
                                  color: kLoginDarkBackground,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(width: 5.0),
                            Flexible(
                              child: Text(
                                cinsiyet,
                                style: TextStyle(
                                    color: kLoginDarkBackground,
                                    fontSize: 18.0),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10.0),
                        Row(
                          children: [
                            SizedBox(width: 10.0),
                            Text(
                              'Rengi:',
                              style: TextStyle(
                                  color: kLoginDarkBackground,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(width: 5.0),
                            Flexible(
                              child: Text(
                                renk,
                                style: TextStyle(
                                    color: kLoginDarkBackground,
                                    fontSize: 18.0),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10.0),
                        Row(
                          children: [
                            SizedBox(width: 10.0),
                            Text(
                              'Son Konum Tarihi:',
                              style: TextStyle(
                                  color: kLoginDarkBackground,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(width: 5.0),
                            Flexible(
                              child: Text(
                                sonKonT,
                                style: TextStyle(
                                    color: kLoginDarkBackground,
                                    fontSize: 18.0),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10.0),
                        Row(
                          children: [
                            SizedBox(width: 10.0),
                            Text(
                              'Gelen Değer:',
                              style: TextStyle(
                                  color: kLoginDarkBackground,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(width: 5.0),
                            Flexible(
                              child: Text(
                                deger.toString(),
                                style: TextStyle(
                                    color: kLoginDarkBackground,
                                    fontSize: 18.0),
                              ),
                            ),
                          ],
                        ),
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
