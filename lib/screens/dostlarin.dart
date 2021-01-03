import 'package:flutter/material.dart';
import 'package:kupe/constants.dart';
import 'package:kupe/widgets/dostlarin_widget.dart';
import 'package:kupe/widgets/kapat_button.dart';
import 'package:kupe/widgets/rounded_button.dart';

class Dostlarin extends StatelessWidget {
  static const String id = 'dostlarin';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.25),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.0),
        child: Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
          child: Container(
            height: 500,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 20.0),
                Text(
                  'Dostların',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 25.0, color: kLoginDarkBackground),
                ),
                SizedBox(height: 10.0),
                Expanded(
                  child: Theme(
                    data: Theme.of(context).copyWith(
                      accentColor: kMainKupeColor,
                    ),
                    child: ListView(
                      children: [
                        DostlarinWidget(
                          textTitle: 'Adı:',
                          hintText: 'Dostunuzun adını giriniz..',
                          onChanged: (newValue) {},
                        ),
                        SizedBox(height: 10.0),
                        //BURAYA IMAGE GELECEK
                        DostlarinWidget(
                          textTitle: 'Cinsiyeti:',
                          hintText: 'Dostunuzun cinsiyeti (E/D)..',
                          onChanged: (newValue) {},
                        ),
                        SizedBox(height: 10.0),
                        DostlarinWidget(
                          textTitle: 'Rengi:',
                          hintText: 'Dostunuzun rengini giriniz..',
                          onChanged: (newValue) {},
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 16.0),
                          child: RoundedButton(
                            colour: kMainKupeColor,
                            buttonTitle: 'Tümünü Kaydet',
                            onPressed: () {
                              /*daha sonra veritabanı ile karşılaştırılarak yapılacak*/
                            },
                          ),
                        ),
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
