import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kupe/constants.dart';
import 'package:kupe/widgets/alert_dialog_messages.dart';
import 'package:kupe/widgets/health_vaccine_info_widget.dart';
import 'package:kupe/widgets/kapat_button.dart';

class SaglikTakipWidget extends StatefulWidget {
  final int hayvanID;
  final String name;
  final String parazitler;
  final String karma;
  final String kuduz;
  final String mantar;
  final String lyme;

  SaglikTakipWidget({
    this.hayvanID,
    this.name,
    this.parazitler,
    this.karma,
    this.kuduz,
    this.mantar,
    this.lyme,
  });

  @override
  _SaglikTakipWidgetState createState() => _SaglikTakipWidgetState();
}

class _SaglikTakipWidgetState extends State<SaglikTakipWidget> {
  DateTime selectParasiteDate = DateTime.now();
  String parasiteDate = 'Aşı bilgisi yok';
  DateTime selectKarmaDate = DateTime.now();
  String karmaDate = 'Aşı bilgisi yok';
  DateTime selectKuduzDate = DateTime.now();
  String kuduzDate = 'Aşı bilgisi yok';
  DateTime selectMantarDate = DateTime.now();
  String mantarDate = 'Aşı bilgisi yok';
  DateTime selectLymeDate = DateTime.now();
  String lymeDate = 'Aşı bilgisi yok';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.25),
      body: SafeArea(
        child: Dialog(
          insetPadding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
          elevation: 16.0,
          child: Container(
            //height: 2650.0,
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
                      widget.name,
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
                        Divider(color: kLoginLightDarkBackground),
                        SizedBox(height: 5.0),
                        Text(
                          'PARAZİT AŞI BİLGİLERİ',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: kLoginDarkBackground,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        HealthVaccineInfo(
                          iconDate: Icon(Icons.info_outline),
                          vaccineDate: parasiteDate,
                          vaccineEndDate: widget.parazitler,
                          iconEndDate: Icon(Icons.alarm),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (_) => AgreeOrNotAgreeVaccineDate(
                                agreeOnPressed: () {
                                  setState(() {
                                    parasiteDate =
                                        '${selectParasiteDate.toLocal()}'
                                            .split(' ')[0];
                                    Navigator.pop(_);
                                  });
                                },
                                notAgreeOnPressed: () => Navigator.pop(_),
                              ),
                            );
                          },
                        ),
                        SizedBox(height: 5.0),
                        Divider(color: kLoginLightDarkBackground),
                        SizedBox(height: 5.0),
                        Text(
                          'KARMA AŞI BİLGİLERİ',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: kLoginDarkBackground,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        HealthVaccineInfo(
                          iconDate: Icon(Icons.info_outline),
                          vaccineDate: karmaDate,
                          vaccineEndDate: widget.karma,
                          iconEndDate: Icon(Icons.alarm),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (_) => AgreeOrNotAgreeVaccineDate(
                                agreeOnPressed: () {
                                  setState(() {
                                    karmaDate = '${selectKarmaDate.toLocal()}'
                                        .split(' ')[0];
                                    Navigator.pop(_);
                                  });
                                },
                                notAgreeOnPressed: () => Navigator.pop(_),
                              ),
                            );
                          },
                        ),
                        SizedBox(height: 5.0),
                        Divider(color: kLoginLightDarkBackground),
                        SizedBox(height: 5.0),
                        Text(
                          'KUDUZ AŞI BİLGİLERİ',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: kLoginDarkBackground,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        HealthVaccineInfo(
                          iconDate: Icon(Icons.info_outline),
                          vaccineDate: kuduzDate,
                          vaccineEndDate: widget.kuduz,
                          iconEndDate: Icon(Icons.alarm),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (_) => AgreeOrNotAgreeVaccineDate(
                                agreeOnPressed: () {
                                  setState(() {
                                    kuduzDate = '${selectKuduzDate.toLocal()}'
                                        .split(' ')[0];
                                    Navigator.pop(_);
                                  });
                                },
                                notAgreeOnPressed: () => Navigator.pop(_),
                              ),
                            );
                          },
                        ),
                        SizedBox(height: 5.0),
                        Divider(color: kLoginLightDarkBackground),
                        SizedBox(height: 5.0),
                        Text(
                          'MANTAR AŞI BİLGİLERİ',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: kLoginDarkBackground,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        HealthVaccineInfo(
                          iconDate: Icon(Icons.info_outline),
                          vaccineDate: mantarDate,
                          vaccineEndDate: widget.mantar,
                          iconEndDate: Icon(Icons.alarm),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (_) => AgreeOrNotAgreeVaccineDate(
                                agreeOnPressed: () {
                                  setState(() {
                                    mantarDate = '${selectMantarDate.toLocal()}'
                                        .split(' ')[0];
                                    Navigator.pop(_);
                                  });
                                },
                                notAgreeOnPressed: () => Navigator.pop(_),
                              ),
                            );
                          },
                        ),
                        SizedBox(height: 5.0),
                        Divider(color: kLoginLightDarkBackground),
                        SizedBox(height: 5.0),
                        Text(
                          'LYME AŞI BİLGİLERİ',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: kLoginDarkBackground,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        HealthVaccineInfo(
                          iconDate: Icon(Icons.info_outline),
                          vaccineDate: lymeDate,
                          vaccineEndDate: widget.lyme,
                          iconEndDate: Icon(Icons.alarm),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (_) => AgreeOrNotAgreeVaccineDate(
                                agreeOnPressed: () {
                                  setState(() {
                                    lymeDate = '${selectLymeDate.toLocal()}'
                                        .split(' ')[0];
                                    Navigator.pop(_);
                                  });
                                },
                                notAgreeOnPressed: () => Navigator.pop(_),
                              ),
                            );
                          },
                        ),
                        SizedBox(height: 5.0),
                        Divider(color: kLoginLightDarkBackground),
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
