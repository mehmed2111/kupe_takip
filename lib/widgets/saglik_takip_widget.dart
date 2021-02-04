import 'package:flutter/material.dart';
import 'package:kupe/constants.dart';

import 'kapat_button.dart';

class SaglikTakipWidget extends StatelessWidget {
  final int hayvanID;
  final String name;
  final String parazitler;
  final String karma;
  final String kuduz;
  final String mantar;
  final String lyme;

  SaglikTakipWidget(
      {this.hayvanID,
      this.name,
      this.parazitler,
      this.karma,
      this.kuduz,
      this.mantar,
      this.lyme});

  @override
  Widget build(BuildContext context) {
    DateTime selectParazitDate = DateTime.now();
    DateTime selectKarmaDate = DateTime.now();
    DateTime selectKuduzDate = DateTime.now();
    DateTime selectMantarDate = DateTime.now();
    DateTime selectLymeDate = DateTime.now();

    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.25),
      body: Dialog(
        insetPadding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        elevation: 16.0,
        child: Theme(
          data: Theme.of(context).copyWith(accentColor: kMainKupeColor),
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
                    SizedBox(width: 10.0),
                    Text(
                      name,
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
                      padding: EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 10.0),
                      //controller: ScrollController(keepScrollOffset: false),
                      children: [
                        Row(
                          children: [
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
                        SizedBox(height: 10.0),
                        Row(
                          children: [
                            Text(
                              'Adı:',
                              style: TextStyle(
                                  color: kLoginDarkBackground,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(width: 5.0),
                            Flexible(
                              child: Text(
                                name,
                                style: TextStyle(
                                    color: kLoginDarkBackground,
                                    fontSize: 18.0),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10.0),
                        Text(
                          'Parazit aşı bilgileri',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: kLoginDarkBackground,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Flexible(
                                child: Text(
                                  parazitler,
                                  style: TextStyle(
                                    color: kLoginDarkBackground,
                                    fontSize: 18.0,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: RaisedButton(
                                color: Colors.white,
                                child: Stack(
                                  children: [
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: Icon(
                                        Icons.calendar_today,
                                        color: kLoginDarkBackground,
                                        size: 20,
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        'Aşı Bilgisi Girin',
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: kLoginDarkBackground),
                                      ),
                                    ),
                                  ],
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(32.0),
                                  side: BorderSide(
                                    width: 1.0,
                                    color: kMainKupeColor,
                                  ),
                                ),
                                onPressed: () {
                                  //controls here
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10.0),
                        Row(
                          children: [
                            Text(
                              'Karma:',
                              style: TextStyle(
                                  color: kLoginDarkBackground,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(width: 5.0),
                            Flexible(
                              child: Text(
                                karma,
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
                            Text(
                              'Kuduz:',
                              style: TextStyle(
                                  color: kLoginDarkBackground,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(width: 5.0),
                            Flexible(
                              child: Text(
                                kuduz,
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
                            Text(
                              'Mantar:',
                              style: TextStyle(
                                  color: kLoginDarkBackground,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(width: 5.0),
                            Flexible(
                              child: Text(
                                mantar,
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
                            Text(
                              'Lyme:',
                              style: TextStyle(
                                  color: kLoginDarkBackground,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(width: 5.0),
                            Flexible(
                              child: Text(
                                lyme,
                                style: TextStyle(
                                  color: kLoginDarkBackground,
                                  fontSize: 18.0,
                                ),
                              ),
                            ),
                          ],
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
