import 'dart:io';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kupe/constants.dart';
import 'package:kupe/dbtables/users_table.dart';
import 'package:kupe/models/beni_hatirla.dart';
import 'package:kupe/network/network_check.dart';
import 'package:kupe/screens/sifremi_unuttum.dart';
import 'package:kupe/widgets/alert_dialog_widget.dart';
import 'package:kupe/widgets/login_page_buttons.dart';
import 'package:kupe/screens/home_page.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:splashscreen/splashscreen.dart';

class LoginPage extends StatefulWidget {
  static const String id = 'login_page';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool showSpinner = false;
  String _username;
  String _password;
  //check for internet connection
  NetworkCheck _networkCheck = NetworkCheck();
  //fetch users and assign them to a List of object of Users
  User _getUser = User();
  List<User> _loginUser;

  //call fetchLoginUser() function inside this function in order to prevent 'instance of Users' error
  void checkLogin(String username, String password) async {
    var user = await _getUser.fetchLoginUser(username, password);
    _loginUser = user;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Scaffold(
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Flexible(
                  child: Hero(
                    tag: 'logo',
                    child: Container(
                      height: 200.0,
                      child: Image.asset('images/logo_transparent.png'),
                    ),
                  ),
                ),
                TypewriterAnimatedTextKit(
                  text: ['Küpe Takip'],
                  textAlign: TextAlign.center,
                  textStyle: TextStyle(
                    fontSize: 45.0,
                    fontWeight: FontWeight.w900,
                    color: kLoginDarkBackground,
                  ),
                ),
                SizedBox(
                  height: 24.0,
                ),
                TextField(
                  keyboardType: TextInputType.text,
                  textAlign: TextAlign.center,
                  cursorColor: kMainKupeColor,
                  onChanged: (value) {
                    setState(() {
                      _username = value;
                      checkLogin(_username, _password);
                    });
                  },
                  decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Kullanıcı adı',
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),
                TextField(
                  textAlign: TextAlign.center,
                  obscureText: true,
                  cursorColor: kMainKupeColor,
                  onChanged: (value) {
                    setState(() {
                      _password = value;
                      checkLogin(_username, _password);
                    });
                  },
                  decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Şifre',
                  ),
                ),
                SizedBox(height: 8.0),
                BeniHatirla(),
                SizedBox(height: 8.0),
                LoginPageButtons(
                  btnTitle: 'Giriş Yap',
                  icon: Icon(Icons.login_rounded, color: Colors.white),
                  color: kMainKupeColor,
                  onPressed: () {
                    //every time on button press, make request to json and send input parameters
                    setState(() {
                      showSpinner = true;
                      checkLogin(_username, _password);
                    });
                    try {
                      _networkCheck.check().then((internet) {
                        if (internet != null && internet) {
                          if (_loginUser != null) {
                            if (_username == _loginUser[0].username &&
                                _password == _loginUser[0].password) {
                              //loggedUserID will be used for comparing
                              loggedUserID = _loginUser[0].id;
                              Navigator.pushNamed(context, LoadingScreen.id);
                            } else {
                              showDialog(
                                  context: context,
                                  builder: (_) => AlertDialogWidget(
                                      dialogTitle: 'Giriş Başarısız!',
                                      dialogContent:
                                          'Kullanıcı adınız veya şifreniz yanlış. Lütfen tekrar deneyiniz.',
                                      btnTitle: 'Kapat',
                                      onPressed: () => Navigator.pop(context)));
                            }
                          } else {
                            //throw Exception('Failed to load users');
                            showDialog(
                                context: context,
                                builder: (_) => AlertDialogWidget(
                                    dialogTitle: 'Giriş Başarısız!',
                                    dialogContent:
                                        'Kullanıcı adınız veya şifreniz yanlış. Lütfen tekrar deneyiniz.',
                                    btnTitle: 'Kapat',
                                    onPressed: () => Navigator.pop(context)));
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
                      setState(() {
                        showSpinner = false;
                      });
                    } catch (e) {
                      print(e);
                    }
                  },
                ),
                SizedBox(height: 16.0),
                LoginPageButtons(
                    btnTitle: 'Şifremi Unuttum',
                    icon: Icon(Icons.vpn_key_rounded, color: Colors.white),
                    color: kLoginDarkBackground,
                    onPressed: () {
                      Navigator.of(context).push(PageRouteBuilder(
                          opaque: false,
                          pageBuilder: (BuildContext context, _, __) {
                            return SifremiUnuttum();
                          }));
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //Alert Dialog to ask to exit from the App onBackButton pressed on Android devices
  Future<bool> _onBackPressed() {
    return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0)),
              title: Text(
                'Emin misiniz?',
                style: TextStyle(
                    color: Colors.red,
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              content: Text('Uygulamadan çıkmak istiyor musunuz?',
                  style:
                      TextStyle(color: kLoginDarkBackground, fontSize: 18.0)),
              actions: [
                MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0)),
                  color: kLoginDarkBackground,
                  elevation: 5.0,
                  child: Text(
                    'Hayır',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () => Navigator.of(context).pop(false),
                ),
                MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0)),
                  color: kLoginDarkBackground,
                  elevation: 5.0,
                  child: Text(
                    'Evet',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () => exit(0),
                  //Navigator.of(context).pop(true);
                ),
              ],
            );
          },
        ) ??
        false;
  }
}

class LoadingScreen extends StatelessWidget {
  static const String id = 'loading_screen';
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 3,
      navigateAfterSeconds: HomePage.id,
      title: Text('Küpe Takip', textScaleFactor: 2),
      image: Image.asset('images/logo_transparent.png'),
      loadingText: Text('Giriş Başarılı'),
      loaderColor: kMainKupeColor,
      photoSize: 100.0,
    );
  }
}
