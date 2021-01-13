import 'package:flutter/material.dart';
import 'package:kupe/constants.dart';
import 'package:kupe/widgets/kapat_button.dart';
import 'package:kupe/widgets/profil_guncelle_widget.dart';
import 'package:kupe/widgets/rounded_button.dart';
import 'package:kupe/dbtables/users_table.dart';
import 'package:kupe/network/network_check.dart';
import 'package:kupe/widgets/alert_dialog_widget.dart';

import '../constants.dart';

class ProfilGuncelle extends StatefulWidget {
  static const String id = 'profil_guncelle';

  @override
  _ProfilGuncelleState createState() => _ProfilGuncelleState();
}

class _ProfilGuncelleState extends State<ProfilGuncelle> {
  String eMail;
  String telNo;
  String address;
  String vet;

  final textEmail = TextEditingController();
  final textTelno = TextEditingController();
  final textAddress = TextEditingController();
  final textVet = TextEditingController();

  NetworkCheck _networkCheck = NetworkCheck();
  //added in order to fetch user data
  User _user = User();
  List<User> _userData;
  List<User> updateUserProf;

  void _getUserData(int id) async {
    var dataList = await _user.fetchUserProfile(id);
    _userData = dataList;

    //should be assigned here in to show them in TextField controller
    textEmail.text = _userData[0].eMail;
    textTelno.text = _userData[0].telno;
    textAddress.text = _userData[0].adress;
    textVet.text = _userData[0].veteriner;
  }

  void _updateUserProfile(int userId, String email, String address,
      String telNo, String vet) async {
    var userData =
        await _user.updateUserProfile(userId, email, address, telNo, vet);
    updateUserProf = userData;
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
    textTelno.dispose();
    textAddress.dispose();
    textVet.dispose();
  }

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
                          title: 'Mail adresiniz:',
                          hintText: 'Mail adresinizi giriniz.',
                          controllerText: textEmail,
                        ),
                        ProfilGuncelleWidget(
                          title: 'Telefon numarası:',
                          hintText: 'Telefon numaranızı giriniz..',
                          controllerText: textTelno,
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
                              try {
                                _networkCheck.check().then((internet) {
                                  if (internet != null && internet) {
                                    if (textEmail.text != '' &&
                                        textAddress.text != '' &&
                                        textTelno.text != '' &&
                                        textVet.text != '') {
                                      if (loggedUserID == _userData[0].id &&
                                          textEmail.text ==
                                              _userData[0].eMail &&
                                          textAddress.text ==
                                              _userData[0].adress &&
                                          textTelno.text ==
                                              _userData[0].telno &&
                                          textVet.text ==
                                              _userData[0].veteriner) {
                                        showDialog(
                                            context: context,
                                            builder: (_) => AlertDialogWidget(
                                                dialogTitle:
                                                    'Profiliniz Güncel!',
                                                dialogContent:
                                                    'Profilinizde yer alan bilgiler zaten güncel bilgilerinizdir.',
                                                btnTitle: 'Kapat',
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                }));
                                      } else if (loggedUserID ==
                                          _userData[0].id) {
                                        setState(() {
                                          _updateUserProfile(
                                              loggedUserID,
                                              textEmail.text,
                                              textAddress.text,
                                              textTelno.text,
                                              textVet.text);
                                          showDialog(
                                              context: context,
                                              builder: (_) => AlertDialogWidget(
                                                  dialogTitle:
                                                      'Güncelleme Başarılı!',
                                                  dialogContent:
                                                      'Verileriniz başarılı bir şekilde güncellendi.',
                                                  btnTitle: 'Kapat',
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  }));
                                        });
                                      }
                                    } else {
                                      showDialog(
                                          context: context,
                                          builder: (_) => AlertDialogWidget(
                                              dialogTitle: 'Hata!',
                                              dialogContent:
                                                  'Alanlar boş bırakılamaz. Lütfen boş alanları doldurun ve tekrar deneyin.',
                                              btnTitle: 'Kapat',
                                              onPressed: () {
                                                Navigator.pop(context);
                                              }));
                                    }
                                  } else {
                                    //if there is no internet connection
                                    showDialog(
                                        context: context,
                                        builder: (_) => AlertDialogWidget(
                                            dialogTitle: 'İnternet hatası!',
                                            dialogContent:
                                                'Lütfen internete bağlı olduğunuzdan emin olun ve tekrar deneyin.',
                                            btnTitle: 'Kapat',
                                            onPressed: () {
                                              Navigator.pop(context);
                                            }));
                                  }
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
    );
  }
}
