import 'package:flutter/material.dart';
import 'package:kupe/constants.dart';

class KullaniciBilgileri extends StatelessWidget {
  final String kullaniciBilg;
  final String kullaniciIcerik;

  KullaniciBilgileri({this.kullaniciBilg, this.kullaniciIcerik});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              width: 10.0,
            ),
            Text(
              kullaniciBilg,
              style: TextStyle(
                  color: kLoginDarkBackground,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              width: 5.0,
            ),
            Flexible(
              child: Text(
                kullaniciIcerik,
                style: TextStyle(color: kLoginDarkBackground, fontSize: 18.0),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10.0,
        ),
      ],
    );
  }
}
