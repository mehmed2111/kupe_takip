import 'package:flutter/material.dart';
import 'package:kupe/constants.dart';
import 'package:kupe/dbtables/users_table.dart';
import 'package:kupe/network/network_check.dart';
import 'package:kupe/widgets/kapat_button.dart';
import 'package:kupe/widgets/rounded_button.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:kupe/widgets/alert_dialog_widget.dart';

class SifremiUnuttum extends StatefulWidget {
  static const String id = 'sifremi_unuttum';

  @override
  _SifremiUnuttumState createState() => _SifremiUnuttumState();
}

class _SifremiUnuttumState extends State<SifremiUnuttum> {
  String _email;
  String _newPassword;
  String _newPasswordRepeat;
  NetworkCheck _networkCheck = NetworkCheck();
  bool showSpinner = false;
  User getUser = User();
  List<User> _userByEmailList;
  List<User> userForgotPassList;

  void getUserByEmail(String email) async {
    var data = await getUser.fetchUserByEmail(email);
    _userByEmailList = data;
  }

  void updateForgottenPass(int userId, String password) async {
    var data = await getUser.updateForgottenPassword(userId, password);
    userForgotPassList = data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.25),
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0)),
            elevation: 16.0,
            child: Container(
              height: 400,
              //width: 360,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 20.0),
                  Text(
                    'Şifremi Unuttum',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: kLoginDarkBackground, fontSize: 25),
                  ),
                  //SizedBox(height: 10.0),
                  Expanded(
                    child: Theme(
                      data: Theme.of(context)
                          .copyWith(accentColor: kMainKupeColor),
                      child: ListView(
                        controller: ScrollController(keepScrollOffset: false),
                        children: [
                          SizedBox(height: 10.0),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.0),
                            child: TextField(
                              keyboardType: TextInputType.emailAddress,
                              textAlign: TextAlign.center,
                              cursorColor: kMainKupeColor,
                              decoration: kTextFieldDecoration.copyWith(
                                  hintText: 'Mail adresinizi giriniz..'),
                              onChanged: (newValue) {
                                setState(() {
                                  _email = newValue;
                                  getUserByEmail(_email);
                                });
                              },
                            ),
                          ),
                          SizedBox(height: 10.0),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.0),
                            child: TextField(
                              keyboardType: TextInputType.visiblePassword,
                              textAlign: TextAlign.center,
                              cursorColor: kMainKupeColor,
                              decoration: kTextFieldDecoration.copyWith(
                                  hintText: 'Yeni Şifre'),
                              onChanged: (newValue) {
                                setState(() {
                                  _newPassword = newValue;
                                });
                              },
                            ),
                          ),
                          SizedBox(height: 10.0),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.0),
                            child: TextField(
                              keyboardType: TextInputType.visiblePassword,
                              textAlign: TextAlign.center,
                              cursorColor: kMainKupeColor,
                              decoration: kTextFieldDecoration.copyWith(
                                  hintText: 'Yeni Şifre (Tekrar)'),
                              onChanged: (newValue) {
                                setState(() {
                                  _newPasswordRepeat = newValue;
                                });
                              },
                            ),
                          ),
                          SizedBox(height: 16.0),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.0),
                            child: RoundedButton(
                              colour: kMainKupeColor,
                              buttonTitle: 'Güncelle',
                              onPressed: () {
                                setState(() {
                                  showSpinner = true;
                                  getUserByEmail(_email);
                                  /*User u;
                                  for (u in _userByEmailList) {
                                    print(u.password);
                                  }*/
                                });
                                try {
                                  _networkCheck.check().then((internet) {
                                    if (internet != null && internet) {
                                      if (_userByEmailList != null) {
                                        User user;
                                        if (_email != null &&
                                            _newPassword != null &&
                                            _newPasswordRepeat != null) {
                                          for (user in _userByEmailList) {
                                            if (_email == user.eMail &&
                                                _newPassword ==
                                                    _newPasswordRepeat) {
                                              //update password
                                              updateForgottenPass(
                                                  user.id, _newPasswordRepeat);
                                              showDialog(
                                                context: context,
                                                builder: (_) =>
                                                    AlertDialogWidget(
                                                  dialogTitle:
                                                      'Güncelleme Başarılı',
                                                  dialogContent:
                                                      'Şifreniz başarılı bir şekilde güncellendi.',
                                                  btnTitle: 'Kapat',
                                                  onPressed: () {
                                                    Navigator.pop(_);
                                                    Navigator.pop(context,
                                                        SifremiUnuttum.id);
                                                  },
                                                ),
                                              );
                                            } else {
                                              showDialog(
                                                context: context,
                                                builder: (_) =>
                                                    AlertDialogWidget(
                                                  dialogTitle: 'Şifre Hatası!',
                                                  dialogContent:
                                                      'Lütfen şifrenizi kontrol edin ve tekrar deneyin.',
                                                  btnTitle: 'Kapat',
                                                  onPressed: () {
                                                    Navigator.pop(_);
                                                  },
                                                ),
                                              );
                                            }
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
                                                    Navigator.pop(_);
                                                  }));
                                        }
                                      } else {
                                        throw Exception(
                                            'Could not load user by email');
                                      }
                                    } else {
                                      showDialog(
                                          context: context,
                                          builder: (_) => AlertDialogWidget(
                                              dialogTitle: 'İnternet hatası!',
                                              dialogContent:
                                                  'Lütfen internete bağlı olduğunuzdan emin olun ve tekrar deneyin.',
                                              btnTitle: 'Kapat',
                                              onPressed: () {
                                                Navigator.pop(_);
                                              }));
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
