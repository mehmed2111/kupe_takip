import 'dart:convert';
import 'dart:io';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kupe/constants.dart';
import 'package:kupe/dbtables/users_table.dart';
import 'package:kupe/functions/beni_hatirla.dart';
import 'package:kupe/screens/sifremi_unuttum.dart';
import 'package:kupe/widgets/alert_dialog.dart';
import 'package:kupe/widgets/rounded_button.dart';
import 'package:kupe/widgets/sifremi_unuttum_butonu.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:kupe/screens/home_page.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  static const String id = 'login_page';
  final List<Users> usersData;

  const LoginPage({Key key, this.usersData}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool showSpinner = false;
  String username;
  String password;
  List<Users> userList;

  //fetch json data
  Future<List<Users>> fetchUsers() async {
    final response = await http
        .get('https://www.aractakipsistemleri.com/canli3/Takip/GetAllUser');

    var data = json.decode(response.body);

    return (data as List).map((e) => Users.fromJson(e)).toList();
  }

  //call fetchUsers() function inside this function in order to prevent 'instance of Users' error
  void getUsersList() async {
    var dataList = await fetchUsers();
    userList = dataList;
  }

  @override
  void initState() {
    super.initState();
    //fetch json data on app start
    getUsersList();
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
                  onPressed: () async {
                    int i = 0;
                    setState(() {
                      showSpinner = true;
                    });
                    try {
                      if (userList.isNotEmpty) {
                        for (i; i < userList.length; i++) {
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
                                    onPressed: () => Navigator.pop(context)));
                            i = userList.length + 1;
                          } else if (username != userList[i].username &&
                                  password == userList[i].password ||
                              username == userList[i].username &&
                                  password != userList[i].password ||
                              username != userList[i].username &&
                                  password != userList[i].password) {
                            showDialog(
                                context: context,
                                builder: (_) => AlertDialogWidget(
                                    dialogTitle: 'Giriş Başarısız!',
                                    dialogContent:
                                        'Kullanıcı adınız veya şifreniz yanlış. Lütfen tekrar deneyiniz.',
                                    btnTitle: 'Kapat',
                                    onPressed: () => Navigator.pop(context)));
                            i = userList.length + 1;
                          } else if (username == userList[i].username &&
                              password == userList[i].password) {
                            tutulanDeger = userList[i].id;
                            Navigator.pushNamed(context, HomePage.id);
                            break;
                          }
                        }
                        //if userList is not empty ends here
                      } else {
                        setState(() {
                          showSpinner = true;
                        });
                      }
                      setState(() {
                        showSpinner = false;
                      });
                      //try ends here
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
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
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
