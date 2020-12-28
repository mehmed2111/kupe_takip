import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kupe/constants.dart';
import 'package:kupe/widgets/kapat_butonu.dart';
import 'package:kupe/widgets/rounded_button.dart';
import 'package:kupe/dbtables/users_table.dart';
import 'package:kupe/network/network_check.dart';
import 'package:kupe/widgets/alert_dialog.dart';

class SifreDegistir extends StatefulWidget {
  static const String id = 'sifre_degistir';
  @override
  _SifreDegistirState createState() => _SifreDegistirState();
}

class _SifreDegistirState extends State<SifreDegistir> {
  String password;

  NetworkCheck _networkCheck = NetworkCheck();
  Users _getUsers = Users();
  List<Users> _userList;
  List<Users> _updateList;

  Future<List<Users>> _futureUsers;
  Users _users = Users();
  final _controller = TextEditingController();

  //call fetchUsers() function inside this function in order to prevent 'instance of Users' error
  void _getUsersList() async {
    var dataList = await _getUsers.fetchUsers();
    _userList = dataList;
  }

  /*void _updatePassword(String password) async {
    var dataList = await _getUsers.updateUsers(password);
    _updateList = dataList;
  }*/

  @override
  void initState() {
    super.initState();
    //fetch json data on app start
    _getUsersList();
    //_updatePassword();
    //_futureUsers = _users.fetchUsers();
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
              height: 290,
              //width: 360,
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
                            controller: _controller,
                            keyboardType: TextInputType.text,
                            textAlign: TextAlign.center,
                            cursorColor: kMainKupeColor,
                            decoration: kTextFieldDecoration.copyWith(
                                hintText: 'Lütfen yeni şifrenizi giriniz..'),
                            /*onChanged: (value) {
                              password = value;
                            },*/
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.0),
                          child: RoundedButton(
                            colour: kMainKupeColor,
                            buttonTitle: 'GÜNCELLE',
                            onPressed: () {
                              /*daha sonra veritabanı ile karşılaştırılarak yapılacak*/
                              setState(() {
                                _getUsersList();
                              });
                              try {
                                _networkCheck.check().then((internet) {
                                  if (internet != null && internet) {
                                    if (_userList != null) {
                                      for (int i = 0;
                                          i < _userList.length;
                                          i++) {
                                        if (loggedUserID == _userList[i].id) {
                                          setState(() {
                                            _userList[i].password =
                                                _getUsers.updateUsers(
                                                    _controller.text) as String;
                                          });
                                        }
                                      }
                                    } else {
                                      print('json data bos geldi');
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
                  KapatButonu(onPressed: () {
                    Navigator.pop(context);
                  }),
                ],
              )),
        ),
      ),
    );
  }
}
