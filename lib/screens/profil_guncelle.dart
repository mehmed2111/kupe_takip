import 'package:flutter/material.dart';
import 'package:kupe/constants.dart';
import 'package:kupe/widgets/alert_dialog_messages.dart';
import 'package:kupe/widgets/alert_dialog_widget.dart';
import 'package:kupe/widgets/kapat_button.dart';
import 'package:kupe/widgets/profil_guncelle_widget.dart';
import 'package:kupe/widgets/rounded_button.dart';
import 'package:kupe/dbtables/users_table.dart';
import 'package:kupe/network/network_check.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class ProfilGuncelle extends StatefulWidget {
  static const String id = 'profil_guncelle';

  @override
  _ProfilGuncelleState createState() => _ProfilGuncelleState();
}

class _ProfilGuncelleState extends State<ProfilGuncelle> {
  final textEmail = TextEditingController();
  final textTelNo = TextEditingController();
  final textAddress = TextEditingController();
  final textVet = TextEditingController();

  NetworkCheck _networkCheck = NetworkCheck();
  //added in order to fetch user data
  User _user = User();
  List<User> _userData;
  //List<User> updateUserProf;

  void _getUserData(int id) async {
    var dataList = await _user.fetchUserProfile(id);
    _userData = dataList;

    User user;
    //should be assigned here in order to show them in TextField controller
    for (user in _userData) {
      if (loggedUserID == user.id) {
        textEmail.text = user.eMail;
        textTelNo.text = user.telno;
        textAddress.text = user.adress;
        textVet.text = user.veteriner;
      }
    }
  }

  void _updateUserProfile(int userId, String email, String address,
      String telNo, String vet) async {
    //var userData =
    await _user.updateUserProfile(userId, email, address, telNo, vet);
    //updateUserProf = userData;
  }

  @override
  void initState() {
    super.initState();
    _getUserData(loggedUserID);
  }

  @override
  void dispose() {
    super.dispose();
    textEmail.dispose();
    textTelNo.dispose();
    textAddress.dispose();
    textVet.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.25),
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10.0),
          child: Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0)),
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
                      data: Theme.of(context)
                          .copyWith(accentColor: kMainKupeColor),
                      child: ListView(
                        controller: ScrollController(keepScrollOffset: false),
                        children: [
                          ProfilGuncelleWidget(
                            title: 'Mail adresiniz:',
                            hintText: 'Mail adresinizi giriniz.',
                            controllerText: textEmail,
                          ),
                          ProfilGuncelleWidget(
                            title: 'Telefon numarası:',
                            hintText: 'Telefon numaranızı giriniz..',
                            controllerText: textTelNo,
                          ),
                          ProfilGuncelleWidget(
                            title: 'Adres bilgisi:',
                            hintText: 'Adresinizi giriniz..',
                            controllerText: textAddress,
                          ),
                          ProfilGuncelleWidget(
                            title: 'Veteriner:',
                            hintText: 'Yeni veteriner adını giriniz..',
                            controllerText: textVet,
                          ),
                          SizedBox(height: 6.0),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.0),
                            child: RoundedButton(
                              colour: kMainKupeColor,
                              buttonTitle: 'Güncelle',
                              onPressed: () {
                                setState(() {
                                  showSpinner = true;
                                });
                                User user;
                                try {
                                  _networkCheck.check().then((internet) {
                                    if (internet != null && internet) {
                                      if (textEmail.text != '' &&
                                          textAddress.text != '' &&
                                          textTelNo.text != '' &&
                                          textVet.text != '') {
                                        for (user in _userData) {
                                          if (loggedUserID == user.id &&
                                              textEmail.text == user.eMail &&
                                              textAddress.text == user.adress &&
                                              textTelNo.text == user.telno &&
                                              textVet.text == user.veteriner) {
                                            showDialog(
                                              context: context,
                                              builder: (_) =>
                                                  ProfileIsUpToDate(),
                                            );
                                          } else if (loggedUserID == user.id) {
                                            setState(() {
                                              _updateUserProfile(
                                                  loggedUserID,
                                                  textEmail.text,
                                                  textAddress.text,
                                                  textTelNo.text,
                                                  textVet.text);
                                              showDialog(
                                                context: context,
                                                builder: (_) =>
                                                    AlertDialogWidget(
                                                  dialogTitle:
                                                      'Güncelleme Başarılı!',
                                                  dialogContent:
                                                      'Verileriniz başarılı bir şekilde güncellendi.',
                                                  btnTitle: 'Kapat',
                                                  onPressed: () {
                                                    Navigator.pop(_);
                                                    Navigator.pop(context,
                                                        ProfilGuncelle.id);
                                                  },
                                                ),
                                              );
                                            });
                                          }
                                        }
                                      } else {
                                        showDialog(
                                          context: context,
                                          builder: (_) => EmptyAreaError(),
                                        );
                                      }
                                    } else {
                                      //if there is no internet connection
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
                                  print(e);
                                }
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
      ),
    );
  }
}
