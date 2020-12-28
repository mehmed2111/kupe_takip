import 'dart:convert';
import 'dart:io';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kupe/constants.dart';
import 'package:kupe/dbtables/users_table.dart';
import 'package:kupe/models/beni_hatirla.dart';
import 'package:kupe/network/network_check.dart';
import 'package:kupe/screens/sifremi_unuttum.dart';
import 'package:kupe/widgets/alert_dialog.dart';
import 'package:kupe/widgets/rounded_button.dart';
import 'package:kupe/widgets/sifremi_unuttum_butonu.dart';
import 'package:kupe/screens/home_page.dart';
import 'package:http/http.dart' as http;
import 'package:splashscreen/splashscreen.dart';

class LoginPage extends StatefulWidget {
  static const String id = 'login_page';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String username;
  String password;
  //check for internet connection
  NetworkCheck _networkCheck = NetworkCheck();

  //URL for json data to fetch USERS from DB
  String _url = 'https://www.aractakipsistemleri.com/canli3/Takip/GetAllUser';
  List<Users> _userList;

  //fetch json data
  Future<List<Users>> _fetchUsers() async {
    final response = await http.get(_url);
    var data = json.decode(response.body);

    return (data as List).map((e) => Users.fromJson(e)).toList();
  }

  //call fetchUsers() function inside this function in order to prevent 'instance of Users' error
  void _getUsersList() async {
    var dataList = await _fetchUsers();
    _userList = dataList;
  }

  @override
  void initState() {
    super.initState();
    //fetch json data on app start
    _getUsersList();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
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
                  username = value;
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
                  password = value;
                },
                decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Şifre',
                ),
              ),
              SizedBox(height: 8.0),
              BeniHatirla(),
              RoundedButton(
                colour: kMainKupeColor,
                buttonTitle: 'GİRİŞ YAP',
                onPressed: () {
                  //every time on button press, make request to json data
                  setState(() {
                    _getUsersList();
                  });
                  try {
                    _networkCheck.check().then((internet) {
                      if (internet != null && internet) {
                        if (_userList != null) {
                          int i = 0;
                          outerloop:
                          for (i; i < _userList.length; i++) {
                            if (username == _userList[i].username &&
                                password == _userList[i].password) {
                              //loggedUserID will be used for comparing
                              loggedUserID = _userList[i].id;
                              Navigator.pushNamed(context, LoadingScreen.id);
                              break outerloop;
                            }
                            innerloop:
                            for (i; i < 1; i++) {
                              if (username == null && password != null ||
                                  username != null && password == null ||
                                  username == null && password == null) {
                                showDialog(
                                    context: context,
                                    builder: (_) => AlertDialogWidget(
                                        dialogTitle: 'Hata!',
                                        dialogContent:
                                            'Kullanıcı adı ve şifre boş bırakılamaz!',
                                        btnTitle: 'Kapat',
                                        onPressed: () =>
                                            Navigator.pop(context)));
                                continue innerloop;
                              } else {
                                showDialog(
                                    context: context,
                                    builder: (_) => AlertDialogWidget(
                                        dialogTitle: 'Giriş Başarısız!',
                                        dialogContent:
                                            'Kullanıcı adınız veya şifreniz yanlış. Lütfen tekrar deneyiniz.',
                                        btnTitle: 'Kapat',
                                        onPressed: () =>
                                            Navigator.pop(context)));
                                continue innerloop;
                              }
                            } //inner for loop
                          } //outer for loop
                          //if userList is not empty ends here
                        } else {
                          print('Json bos geldi... ');
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
              //SizedBox(height: 8.0),
              SifremiUnuttumButonu(onPressed: () {
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
    );
  }

  //Alert Dialog to ask to exit from the App onBackButton pressed
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
                FlatButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0)),
                  color: kLoginDarkBackground,
                  child: Text(
                    'Hayır',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () => Navigator.of(context).pop(false),
                ),
                FlatButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0)),
                  color: kLoginDarkBackground,
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
