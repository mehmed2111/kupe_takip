import 'package:flutter/material.dart';
import 'package:kupe/constants.dart';

class MarkerInfoWindow extends StatelessWidget {
  final String ad;
  final String sagDurumu;
  final String isi;
  final String cinsiyet;
  final String renk;
  final String sonKonT;

  MarkerInfoWindow(
      {@required this.ad,
      @required this.sagDurumu,
      @required this.isi,
      @required this.cinsiyet,
      @required this.renk,
      @required this.sonKonT});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Theme(
        data: Theme.of(context).copyWith(accentColor: kMainKupeColor),
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
                  style: TextStyle(color: kLoginDarkBackground, fontSize: 18.0),
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
                    style:
                        TextStyle(color: kLoginDarkBackground, fontSize: 18.0),
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
                    style:
                        TextStyle(color: kLoginDarkBackground, fontSize: 18.0),
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
                    style:
                        TextStyle(color: kLoginDarkBackground, fontSize: 18.0),
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
                    style:
                        TextStyle(color: kLoginDarkBackground, fontSize: 18.0),
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
                    style:
                        TextStyle(color: kLoginDarkBackground, fontSize: 18.0),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
