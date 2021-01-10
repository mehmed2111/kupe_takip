import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kupe/constants.dart';
import 'package:kupe/deneme.dart';
import 'package:kupe/network/network_check.dart';
import 'package:kupe/screens/alarm_rapor_tanim.dart';
import 'package:kupe/screens/dostlarin.dart';
import 'package:kupe/screens/home_page.dart';
import 'package:kupe/screens/kullanici_profili.dart';
import 'package:kupe/screens/login_page.dart';
import 'package:kupe/screens/profil_guncelle.dart';
import 'package:kupe/screens/saglik_takip.dart';
import 'package:kupe/screens/sifre_degistir.dart';
import 'package:kupe/dbtables/users_table.dart';
import 'package:kupe/widgets/alert_dialog_widget.dart';

class NavMenu extends StatefulWidget {
  @override
  _NavMenuState createState() => _NavMenuState();
}

class _NavMenuState extends State<NavMenu> {
  NetworkCheck _networkCheck = NetworkCheck();
  User _getUsers = User();
  List<User> _userData;

  //call fetchUsers() function inside this function in order to prevent 'instance of Users' error
  void _getUserData(int id) async {
    var dataList = await _getUsers.fetchUserData(id);
    _userData = dataList;
  }

  @override
  void initState() {
    super.initState();
    //fetch json data on app start
    _getUserData(loggedUserID);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Theme(
        data: Theme.of(context).copyWith(accentColor: kMainKupeColor),
        child: Container(
          color: kLoginDarkBackground,
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    'Dostunu takip et..',
                    style: TextStyle(
                      color: kLoginDarkBackground,
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('images/logo_arka_beyaz.jpg'),
                  ),
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.account_box,
                  color: Colors.white,
                ),
                title: Text(
                  'Kullanıcı Profili',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
                onTap: () {
                  setState(() {
                    _getUserData(loggedUserID);
                  });
                  try {
                    _networkCheck.check().then((internet) {
                      if (internet != null && internet) {
                        for (int i = 0; i < _userData.length; i++) {
                          if (loggedUserID == _userData[i].id) {
                            Navigator.of(context).push(PageRouteBuilder(
                                opaque: false,
                                pageBuilder: (BuildContext context, _, __) {
                                  return KullaniciProfili(
                                      kullid: _userData[i].id,
                                      ad: _userData[i].username,
                                      adres: _userData[i].adress,
                                      telNo: _userData[i].telno,
                                      email: _userData[i].eMail,
                                      kayitliVet: _userData[i].veteriner);
                                }));
                          } else {
                            throw Exception('Could not find selected user');
                          }
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
              ListTile(
                leading:
                    Icon(Icons.medical_services_outlined, color: Colors.white),
                title: Text(
                  'Sağlık Takip',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                onTap: () => Navigator.pushNamed(context, SaglikTakip.id),
              ),
              ListTile(
                leading: Icon(Icons.mobile_friendly, color: Colors.white),
                title: Text(
                  'Dostların',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                onTap: () {
                  //Navigator.of(context).pop()
                  Navigator.of(context).push(PageRouteBuilder(
                      opaque: false,
                      pageBuilder: (BuildContext context, _, __) {
                        return Dostlarin();
                      }));
                },
              ),
              ListTile(
                leading: Icon(Icons.refresh_outlined, color: Colors.white),
                title: Text(
                  'Yenile',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                onTap: () {
                  _networkCheck.check().then((internet) {
                    if (internet != null && internet) {
                      Navigator.popAndPushNamed(context, HomePage.id);
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
                },
              ),
              //burada Submenu oluşturuldu
              Divider(color: Colors.white, thickness: 0.3),
              Theme(
                data: Theme.of(context).copyWith(
                    accentColor: Colors.white,
                    unselectedWidgetColor: Colors.white..withOpacity(0.8)),
                child: ExpansionTile(
                  //trailing:
                  //Icon(Icons.subdirectory_arrow_left, color: Colors.white),
                  backgroundColor: Color(0xFF323244),
                  leading: Icon(Icons.settings, color: Colors.white),
                  title: Text('Ayarlar',
                      style: TextStyle(fontSize: 18, color: Colors.white)),
                  children: [
                    ListTile(
                      leading: Icon(Icons.admin_panel_settings_sharp,
                          color: Colors.white),
                      title: Text('Şifre Değiştir',
                          style: TextStyle(fontSize: 18, color: Colors.white)),
                      onTap: () {
                        //Navigator.of(context).pop(),
                        Navigator.of(context).push(PageRouteBuilder(
                            opaque: false,
                            pageBuilder: (BuildContext context, _, __) {
                              return SifreDegistir();
                            }));
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.switch_account, color: Colors.white),
                      title: Text('Profil Güncelle',
                          style: TextStyle(fontSize: 18, color: Colors.white)),
                      onTap: () => {
                        //Navigator.of(context).pop(),
                        Navigator.of(context).push(PageRouteBuilder(
                            opaque: false,
                            pageBuilder: (BuildContext context, _, __) {
                              return ProfilGuncelle();
                            })),
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.alarm, color: Colors.white),
                      title: Text(
                        'Alarm & Rapor Tanımlama',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                      onTap: () => {
                        //Navigator.of(context).pop(),
                        Navigator.of(context).push(PageRouteBuilder(
                            opaque: false,
                            pageBuilder: (BuildContext context, _, __) {
                              return AlarmRaporTanim();
                            })),
                      },
                    ),
                  ],
                ),
              ),
              Divider(color: Colors.white, thickness: 0.3),
              ListTile(
                leading: Icon(Icons.logout, color: Colors.white),
                title: Text(
                  'Çıkış',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                onTap: () {
                  //close all previous screens and take the user to login page
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      LoginPage.id, (Route<dynamic> route) => false);
                },
              ),
              ListTile(
                leading: Icon(Icons.logout, color: Colors.white),
                title: Text(
                  'Deneme',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MyApp()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
