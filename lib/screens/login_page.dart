import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kupe/constants.dart';
import 'package:kupe/dbtables/users_table.dart';
import 'package:kupe/models/remember_me.dart';
import 'package:kupe/network/network_check.dart';
import 'package:kupe/screens/password_forgot.dart';
import 'package:kupe/widgets/alert_dialog_messages.dart';
import 'package:kupe/widgets/login_page_buttons.dart';
import 'package:kupe/screens/home_page.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:splashscreen/splashscreen.dart';

class LoginPage extends StatefulWidget {
  static const String id = 'login_page';
  final String username;
  LoginPage({this.username});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //String _username;
  String _password;
  TextEditingController _username = TextEditingController();
  //TextEditingController _password = TextEditingController();

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
  void initState() {
    super.initState();
    _username.text = widget.username;
    //print(_username.text);
  }

  @override
  void dispose() {
    super.dispose();
    _username.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        body: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: Padding(
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
                  decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Kullanıcı adı',
                    prefixIcon: Icon(
                      Icons.person,
                      color: kLoginLightDarkBackground,
                    ),
                  ),
                  controller: _username,
                ),
                SizedBox(
                  height: 8.0,
                ),
                TextField(
                  keyboardType: TextInputType.text,
                  textAlign: TextAlign.center,
                  obscureText: obscurePassword,
                  cursorColor: kMainKupeColor,
                  decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Şifre',
                    prefixIcon: Icon(
                      Icons.lock,
                      color: kLoginLightDarkBackground,
                    ),
                    suffixIcon: IconButton(
                        icon: Icon(
                          obscurePassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: kLoginLightDarkBackground,
                        ),
                        onPressed: () {
                          setState(() {
                            //toggle the state of visible password variable
                            obscurePassword = !obscurePassword;
                          });
                        }),
                    contentPadding: EdgeInsets.zero,
                  ),
                  onChanged: (value) {
                    setState(() {
                      _password = value;
                      checkLogin(_username.text, _password);
                    });
                  },
                ),
                SizedBox(height: 8.0),
                RememberMe(username: _username.text),
                SizedBox(height: 8.0),
                LoginPageButtons(
                  btnTitle: 'Giriş Yap',
                  icon: Icon(Icons.login_rounded, color: Colors.white),
                  color: kMainKupeColor,
                  onPressed: () {
                    //every time on button press, make request to json and send input parameters
                    setState(() {
                      showSpinner = true;
                      checkLogin(_username.text, _password);
                    });
                    User user;
                    try {
                      _networkCheck.check().then((internet) {
                        if (internet != null && internet) {
                          if (_loginUser != null) {
                            for (user in _loginUser) {
                              if (_username.text == user.username &&
                                  _password == user.password) {
                                //loggedUserID will be used for comparing
                                loggedUserID = user.id;
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LoadingScreen(),
                                  ),
                                );
                              } else {
                                showDialog(
                                  context: context,
                                  builder: (_) => UnsuccessfulLogin(),
                                );
                              }
                            }
                          } else {
                            //throw Exception('Failed to load users');
                            showDialog(
                              context: context,
                              builder: (_) => UnsuccessfulLogin(),
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
                SizedBox(height: 16.0),
                LoginPageButtons(
                    btnTitle: 'Şifremi Unuttum',
                    icon: Icon(Icons.vpn_key_rounded, color: Colors.white),
                    color: kLoginDarkBackground,
                    onPressed: () {
                      Navigator.of(context).push(PageRouteBuilder(
                          opaque: false,
                          pageBuilder: (BuildContext context, _, __) {
                            return PasswordForgot();
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
          builder: (context) => OnBackPressedExitOrNot(),
        ) ??
        false;
  }
}

class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 2,
      navigateAfterSeconds: HomePage(),
      title: Text('Küpe Takip', textScaleFactor: 2),
      image: Image.asset('images/logo_transparent.png'),
      loadingText: Text('Giriş Başarılı'),
      loaderColor: kMainKupeColor,
      photoSize: 100.0,
    );
  }
}
