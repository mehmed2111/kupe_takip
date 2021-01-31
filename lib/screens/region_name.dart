import 'package:flutter/material.dart';
import 'package:kupe/constants.dart';
import 'package:kupe/dbtables/user_region.dart';
import 'package:kupe/network/network_check.dart';
import 'package:kupe/screens/home_page.dart';
import 'package:kupe/widgets/alert_dialog_messages.dart';
import 'package:kupe/widgets/alert_dialog_widget.dart';
import 'package:kupe/widgets/rounded_button.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class RegionName extends StatefulWidget {
  static const String id = 'draw_region';
  final String polygonLatLngs;

  RegionName({this.polygonLatLngs});

  @override
  _RegionNameState createState() => _RegionNameState();
}

class _RegionNameState extends State<RegionName> {
  NetworkCheck _networkCheck = NetworkCheck();
  String regionName;
  UserRegion _userRegion = UserRegion();

  void addUserRegion(int userID, String regionName, String polygonPoints) {
    _userRegion.addRegionToUser(userID, regionName, polygonPoints);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      child: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Container(
          height: 250,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.edit_location_outlined,
                      color: kLoginDarkBackground),
                  SizedBox(width: 10),
                  Text('Bölgeyi Kaydet',
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
                      hintText: 'Bölge adı giriniz..'),
                  onChanged: (value) {
                    setState(() {
                      regionName = value;
                    });
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
                      setState(() {
                        showSpinner = true;
                      });
                      try {
                        _networkCheck.check().then((internet) {
                          if (internet != null && internet) {
                            if (regionName != null) {
                              setState(() {
                                //add region to the database
                                addUserRegion(
                                  loggedUserID,
                                  regionName,
                                  widget.polygonLatLngs,
                                );
                                showDialog(
                                  context: context,
                                  builder: (_) => AlertDialogWidget(
                                    dialogTitle: 'Kayıt Başarılı!',
                                    dialogContent:
                                        'Bölge başarılı bir şekilde kaydedildi.',
                                    btnTitle: 'Kapat',
                                    onPressed: () {
                                      Navigator.pop(_);
                                      Navigator.pop(context, RegionName.id);
                                      Navigator.pushNamed(context, HomePage.id);
                                    },
                                  ),
                                );
                              });
                            } else {
                              showDialog(
                                context: context,
                                builder: (_) => EmptyAreaError(),
                              );
                            }
                          } else {
                            showDialog(
                              context: context,
                              builder: (_) => InternetError(),
                            );
                          }
                        });
                        setState(() {
                          showSpinner = false;
                        });
                      } catch (e) {
                        throw Exception('Failed to save region to an user');
                      }
                      //print('Gelen Polygon points: ${widget.polygonLatLngs}');
                    }),
              ),
              SizedBox(height: 10),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: RoundedButton(
                    colour: kLoginDarkBackground,
                    buttonTitle: 'İptal',
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  HomePage(isPolygon: false)));
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
