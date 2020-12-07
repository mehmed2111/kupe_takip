import 'package:flutter/material.dart';
import 'package:kupe/constants.dart';

import 'kapat_butonu.dart';

class SaglikTakipWidget extends StatelessWidget {
  final int hayvanID;
  final String name;
  final String parazitler;
  final String karma;
  final String kuduz;
  final String mantar;
  final String lyme;

  SaglikTakipWidget(
      {@required this.hayvanID,
      @required this.name,
      @required this.parazitler,
      @required this.karma,
      @required this.kuduz,
      @required this.mantar,
      @required this.lyme});

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
          child: Theme(
            data: Theme.of(context).copyWith(accentColor: kMainKupeColor),
            child: Container(
              height: 440.0,
              //width: 360.0,
              child: ListView(
                controller: ScrollController(keepScrollOffset: false),
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 10.0,
                      ),
                      Text(
                        'Sağlık takibi',
                        style: TextStyle(
                          color: kLoginDarkBackground,
                          fontSize: 25.0,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.0),
                  Row(
                    children: [
                      SizedBox(width: 10.0),
                      Text(
                        'Hayvan ID:',
                        style: TextStyle(
                            color: kLoginDarkBackground,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 5.0),
                      Text(
                        hayvanID.toString(),
                        style: TextStyle(
                            color: kLoginDarkBackground, fontSize: 18.0),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.0),
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
                        name,
                        style: TextStyle(
                            color: kLoginDarkBackground, fontSize: 18.0),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.0),
                  Row(
                    children: [
                      SizedBox(width: 10.0),
                      Text(
                        'Parazitler:',
                        style: TextStyle(
                            color: kLoginDarkBackground,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 10.0),
                      Text(
                        parazitler,
                        style: TextStyle(
                            color: kLoginDarkBackground, fontSize: 18.0),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.0),
                  Row(
                    children: [
                      SizedBox(width: 10.0),
                      Text(
                        'Karma:',
                        style: TextStyle(
                            color: kLoginDarkBackground,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 5.0),
                      Text(
                        karma,
                        style: TextStyle(
                            color: kLoginDarkBackground, fontSize: 18.0),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.0),
                  Row(
                    children: [
                      SizedBox(width: 10.0),
                      Text(
                        'Kuduz:',
                        style: TextStyle(
                            color: kLoginDarkBackground,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 5.0),
                      Text(
                        kuduz,
                        style: TextStyle(
                            color: kLoginDarkBackground, fontSize: 18.0),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.0),
                  Row(
                    children: [
                      SizedBox(width: 10.0),
                      Text(
                        'Mantar:',
                        style: TextStyle(
                            color: kLoginDarkBackground,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 5.0),
                      Text(
                        mantar,
                        style: TextStyle(
                            color: kLoginDarkBackground, fontSize: 18.0),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.0),
                  Row(
                    children: [
                      SizedBox(width: 10.0),
                      Text(
                        'Lyme:',
                        style: TextStyle(
                            color: kLoginDarkBackground,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 5.0),
                      Text(
                        lyme,
                        style: TextStyle(
                          color: kLoginDarkBackground,
                          fontSize: 18.0,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  KapatButonu(onPressed: () {
                    Navigator.pop(context);
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
