import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kupe/constants.dart';
import 'package:kupe/widgets/alert_dialog_messages.dart';
import 'package:kupe/widgets/kapat_button.dart';
import 'package:kupe/widgets/rounded_button.dart';
import 'package:kupe/dbtables/users_table.dart';
import 'package:kupe/network/network_check.dart';
import 'package:kupe/widgets/alert_dialog_widget.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

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
  bool showSpinner = false;
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
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10.0),
          child: Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0)),
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
                      style:
                          TextStyle(color: kLoginDarkBackground, fontSize: 25),
                    ),
                    SizedBox(height: 10.0),
                    Expanded(
                        child: Theme(
                      data: Theme.of(context)
                          .copyWith(accentColor: kMainKupeColor),
                      child: ListView(
                        controller: ScrollController(keepScrollOffset: false),
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.0),
                            child: TextField(
                              //controller: _controller,
                              keyboardType: TextInputType.text,
                              obscureText: obscurePassword4,
                              cursorColor: kMainKupeColor,
                              decoration: kTextFieldDecoration.copyWith(
                                hintText: 'Geçerli Şifre',
                                suffixIcon: IconButton(
                                    icon: Icon(
                                      obscurePassword4
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      color: kLoginLightDarkBackground,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        //toggle the state of visible password variable
                                        obscurePassword4 = !obscurePassword4;
                                      });
                                    }),
                                contentPadding: EdgeInsets.only(left: 20.0),
                              ),
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
                              keyboardType: TextInputType.text,
                              obscureText: obscurePassword5,
                              cursorColor: kMainKupeColor,
                              decoration: kTextFieldDecoration.copyWith(
                                hintText: 'Yeni Şifre',
                                suffixIcon: IconButton(
                                    icon: Icon(
                                      obscurePassword5
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      color: kLoginLightDarkBackground,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        //toggle the state of visible password variable
                                        obscurePassword5 = !obscurePassword5;
                                      });
                                    }),
                                contentPadding: EdgeInsets.only(left: 20.0),
                              ),
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
                              keyboardType: TextInputType.text,
                              obscureText: obscurePassword6,
                              cursorColor: kMainKupeColor,
                              decoration: kTextFieldDecoration.copyWith(
                                hintText: 'Yeni Şifre (Tekrar)',
                                suffixIcon: IconButton(
                                    icon: Icon(
                                      obscurePassword6
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      color: kLoginLightDarkBackground,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        //toggle the state of visible password variable
                                        obscurePassword6 = !obscurePassword6;
                                      });
                                    }),
                                contentPadding: EdgeInsets.only(left: 20.0),
                              ),
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
                                setState(() {
                                  showSpinner = true;
                                });
                                User user;
                                try {
                                  _networkCheck.check().then((internet) {
                                    if (internet != null && internet) {
                                      if (_userData != null) {
                                        if (_newPassword != null &&
                                            _oldPassword != null) {
                                          for (user in _userData) {
                                            if (_oldPassword == user.password &&
                                                _newPassword == _newPassAgain) {
                                              if (loggedUserID == user.id) {
                                                setState(() {
                                                  _updateUserPassword(
                                                      loggedUserID,
                                                      _newPassAgain);
                                                  showDialog(
                                                    context: context,
                                                    builder: (_) =>
                                                        AlertDialogWidget(
                                                      dialogTitle:
                                                          'Güncelleme Başarılı!',
                                                      dialogContent:
                                                          'Şifreniz başarılı bir şekilde güncellendi.',
                                                      btnTitle: 'Kapat',
                                                      onPressed: () {
                                                        Navigator.pop(_);
                                                        Navigator.pop(context,
                                                            SifreDegistir.id);
                                                      },
                                                    ),
                                                  );
                                                });
                                              }
                                            } else {
                                              showDialog(
                                                context: context,
                                                builder: (_) => PasswordError(),
                                              );
                                            }
                                          }
                                        } else {
                                          showDialog(
                                            context: context,
                                            builder: (_) => EmptyAreaError(),
                                          );
                                        }
                                      } else {
                                        showDialog(
                                          context: context,
                                          builder: (_) => CouldNotLoadData(),
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
      ),
    );
  }
}
