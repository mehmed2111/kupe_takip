import 'package:flutter/material.dart';
import 'package:kupe/constants.dart';
import 'package:kupe/widgets/rounded_button.dart';

class RegionName extends StatefulWidget {
  static const String id = 'draw_region';
  @override
  _RegionNameState createState() => _RegionNameState();
}

class _RegionNameState extends State<RegionName> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      child: Container(
        height: 250,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.edit_location_outlined, color: kLoginDarkBackground),
                SizedBox(width: 10),
                Text('Bölge Oluştur',
                    style:
                        TextStyle(color: kLoginDarkBackground, fontSize: 25)),
              ],
            ),
            SizedBox(height: 16),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: TextField(
                keyboardType: TextInputType.text,
                textAlign: TextAlign.center,
                cursorColor: kMainKupeColor,
                decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Bölge adı giriniz..',
                ),
                onChanged: (value) {
                  setState(() {});
                },
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: RoundedButton(
                  colour: kMainKupeColor,
                  buttonTitle: 'Kaydet',
                  onPressed: () {
                    //controls here..
                  }),
            ),
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: RoundedButton(
                  colour: kLoginDarkBackground,
                  buttonTitle: 'İptal',
                  onPressed: () => Navigator.pop(context)),
            ),
          ],
        ),
      ),
    );
  }
}
