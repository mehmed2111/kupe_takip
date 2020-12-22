import 'dart:convert';
import 'dart:io';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kupe/constants.dart';
import 'package:kupe/dbtables/userstable.dart';
import 'package:kupe/functions/beni_hatirla.dart';
import 'package:kupe/screens/sifremi_unuttum.dart';
import 'package:kupe/widgets/alert_dialog.dart';
import 'package:kupe/widgets/rounded_button.dart';
import 'package:kupe/widgets/sifremi_unuttum_butonu.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import 'home_page.dart';
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
  Users u;

  //fetch json data
  Future<List<Users>> fetchUsers() async {
    final response = await http
        .get('https://www.aractakipsistemleri.com/canli3/Takip/GetAllUser');

    var data = json.decode(response.body);

    //print(data);
    return (data as List).map((e) => Users.fromJson(e)).toList();
  }

  void getUsersList() async {
    var dataList = await fetchUsers();
    userList = dataList;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //fetchUsers();
    getUsersList();
    print('İNİTİN İÇİNDEEEEEEEEEEEEEEEEEEEEEEEEEE');
    //print(userList);
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
                    /*setState(() {
                      showSpinner = true;
                    });*/
                    try {
                      print(userList[0].username);

                      ListView.builder(
                        itemCount: userList.length,
                        itemBuilder: (context, index) {
                          if (username == userList[index].username &&
                              password == userList[index].password) {
                            return HomePage();
                          } else {
                            return null;
                          }

                          //Text(snapshot.data[index].username);
                        },
                      );

                      /* FutureBuilder<List<Users>>(
                        future: fetchUsers(),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            print(snapshot.error);
                          }
                          return snapshot.hasData
                              ? ListView.builder(
                                  itemCount: snapshot.data.length,
                                  itemBuilder: (context, index) {
                                    if (username == userList[index].username &&
                                        password == userList[index].password) {
                                      return HomePage();
                                    } else {
                                      return null;
                                    }

                                    //Text(snapshot.data[index].username);
                                  },
                                )
                              : Center(child: CircularProgressIndicator());
                        },
                      );*/

                      /*if (username != null && password != null) {
                        Navigator.pushNamed(context, HomePage.id);
                      } else {
                        showDialog(
                            context: context,
                            builder: (_) => AlertDialogWidget(
                                dialogTitle: 'Hata!',
                                dialogContent:
                                    'Kullanıcı adı ve şifre boş bırakılamaz!',
                                btnTitle: 'Kapat',
                                onPressed: () {
                                  Navigator.pop(context);
                                }));
                      }
                      setState(() {
                        showSpinner = false;
                      });*/
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
