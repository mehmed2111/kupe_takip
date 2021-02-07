import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kupe/screens/animal_history_tracking.dart';
import 'package:kupe/widgets/kapat_button.dart';
import 'package:kupe/constants.dart';
import 'package:kupe/widgets/rounded_button_with_icon.dart';

class HayvanMarker extends StatelessWidget {
  static const String id = 'hayvan_marker';

  final String ad;
  final String sagDurumu;
  final String isi;
  final String cinsiyet;
  final String renk;
  final String sonKonT;

  HayvanMarker(
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
            height: 395.0,
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
                      padding: EdgeInsets.symmetric(vertical: 10.0),
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
                                cinsiyet.toString(),
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
                      ],
                    ),
                  ),
                ),
                //SizedBox(height: 10.0),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Container(
                          height: 42.0,
                          child: RoundedButtonWithIcon(
                            btnTitle: 'Geçmiş izleme',
                            icon: Icons.slideshow,
                            onPressed: () {
                              Navigator.pop(context);
                              Navigator.of(context).push(PageRouteBuilder(
                                opaque: false,
                                pageBuilder: (BuildContext context, _, __) {
                                  return AnimalHistoryTracking();
                                },
                              ));
                            },
                          ),
                        ),
                      ),
                      SizedBox(width: 10.0),
                      Expanded(
                        flex: 1,
                        child: KapatButton(onPressed: () {
                          Navigator.pop(context);
                        }),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
