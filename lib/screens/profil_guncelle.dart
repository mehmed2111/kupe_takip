import 'package:flutter/material.dart';
import 'package:kupe/constants.dart';
import 'package:kupe/widgets/kapat_button.dart';
import 'package:kupe/widgets/profil_guncelle_widget.dart';
import 'package:kupe/widgets/rounded_button.dart';

class ProfilGuncelle extends StatelessWidget {
  static const String id = 'profil_guncelle';

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
            height: 700,
            //width: 360,
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
                      'Profil Güncelle',
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
                        ProfilGuncelleWidget(
                          titleBilg: 'Mail adresi:',
                          hintText: 'Mail adresinizi giriniz..',
                          //onChanged: (newValue) {},
                        ),
                        ProfilGuncelleWidget(
                          titleBilg: 'Telefon numarası:',
                          hintText: 'Telefon numaranızı giriniz..',
                          //onChanged: (newValue) {},
                        ),
                        ProfilGuncelleWidget(
                          titleBilg: 'Adres bilgisi:',
                          hintText: 'Adresinizi giriniz..',
                          //onChanged: (newValue) {},
                        ),
                        ProfilGuncelleWidget(
                          titleBilg: 'Veteriner:',
                          hintText: 'Yeni veteriner adını giriniz..',
                          //onChanged: (newValue) {},
                        ),
                        SizedBox(height: 6.0),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.0),
                          child: RoundedButton(
                            colour: kMainKupeColor,
                            buttonTitle: 'Güncelle',
                            onPressed: () {
                              /*daha sonra veritabanı ile karşılaştırılarak yapılacak*/
                            },
                          ),
                        ),
                        SizedBox(height: 16.0),
                      ],
                    ),
                  ),
                ),
                KapatButton(onPressed: () {
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
