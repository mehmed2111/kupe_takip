import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kupe/constants.dart';
import 'package:kupe/widgets/kapat_button.dart';
import 'package:kupe/widgets/rounded_button.dart';
import 'package:kupe/dbtables/users_table.dart';
import 'package:kupe/network/network_check.dart';
import 'package:kupe/widgets/alert_dialog_widget.dart';

class SifreDegistir extends StatefulWidget {
  static const String id = 'sifre_degistir';
  @override
  _SifreDegistirState createState() => _SifreDegistirState();
}

class _SifreDegistirState extends State<SifreDegistir> {
  String _oldPassword;
  String _newPassword;
  String _newPassAgain;

  NetworkCheck _networkCheck = NetworkCheck();
  User _user = User();
  List<User> updateUserPass;

  //added in order to fetch old password
  User _getUser = User();
  List<User> _userData;
  void _getUserData(int id) async {
    var dataList = await _getUser.fetchUserProfile(id);
    _userData = dataList;
  }

  //call fetchUsers() function inside this function in order to prevent 'instance of Users' error
  void _updateUserPassword(int userId, String password) async {
    var userData = await _user.updateUserPassword(userId, password);
    updateUserPass = userData;
  }

  @override
  void initState() {
    super.initState();
    //fetch user data on app start
    _getUserData(loggedUserID);
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
              height: 400.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 20.0),
                  Text(
                    'Şifre Değiştir',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: kLoginDarkBackground, fontSize: 25),
                  ),
                  SizedBox(height: 10.0),
                  Expanded(
                      child: Theme(
                    data:
                        Theme.of(context).copyWith(accentColor: kMainKupeColor),
                    child: ListView(
                      controller: ScrollController(keepScrollOffset: false),
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.0),
                          child: TextField(
                            //controller: _controller,
                            keyboardType: TextInputType.visiblePassword,
                            textAlign: TextAlign.center,
                            cursorColor: kMainKupeColor,
                            decoration: kTextFieldDecoration.copyWith(
                                hintText: 'Eski Şifre'),
                            onChanged: (value) {
                              setState(() {
                                _oldPassword = value;
                                //_getUserData(loggedUserID);
                              });
                            },
                          ),
                        ),
                        SizedBox(height: 10.0),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.0),
                          child: TextField(
                            //controller: _controller,
                            keyboardType: TextInputType.visiblePassword,
                            textAlign: TextAlign.center,
                            cursorColor: kMainKupeColor,
                            decoration: kTextFieldDecoration.copyWith(
                                hintText: 'Yeni Şifre'),
                            onChanged: (value) {
                              setState(() {
                                _newPassword = value;
                                //_updateUserPassword(loggedUserID, _newPassword);
                              });
                            },
                          ),
                        ),
                        SizedBox(height: 10.0),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.0),
                          child: TextField(
                            //controller: _controller,
                            keyboardType: TextInputType.visiblePassword,
                            textAlign: TextAlign.center,
                            cursorColor: kMainKupeColor,
                            decoration: kTextFieldDecoration.copyWith(
                                hintText: 'Tekrar Yeni Şifre'),
                            onChanged: (value) {
                              setState(() {
                                _newPassAgain = value;
                                //_updateUserPassword(loggedUserID, _newPassword);
                              });
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 16.0),
                          child: RoundedButton(
                            colour: kMainKupeColor,
                            buttonTitle: 'Güncelle',
                            onPressed: () {
                              try {
                                _networkCheck.check().then((internet) {
                                  if (internet != null && internet) {
                                    if (_newPassword != null &&
                                        _oldPassword != null) {
                                      if (_oldPassword ==
                                              _userData[0].password &&
                                          _newPassword == _newPassAgain) {
                                        if (loggedUserID == _userData[0].id) {
                                          setState(() {
                                            _updateUserPassword(
                                                loggedUserID, _newPassAgain);
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
                                                          Navigator.pop(
                                                              context);
                                                        }));
                                          });
                                        }
                                      } else {
                                        showDialog(
                                            context: context,
                                            builder: (_) => AlertDialogWidget(
                                                dialogTitle: 'Şifre Hatası!',
                                                dialogContent:
                                                    'Lütfen şifrenizi kontrol edin ve tekrar deneyin.',
                                                btnTitle: 'Kapat',
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                }));
                                      }
                                    } else {
                                      showDialog(
                                          context: context,
                                          builder: (_) => AlertDialogWidget(
                                              dialogTitle: 'Hata!',
                                              dialogContent:
                                                  'Şifre alanı boş bırakılamaz. Lütfen boş alanları doldurun ve tekrar deneyin.',
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
                      ],
                    ),
                  )),
                  KapatButton(onPressed: () {
                    Navigator.pop(context);
                  }),
                ],
              )),
        ),
      ),
    );
  }
}
