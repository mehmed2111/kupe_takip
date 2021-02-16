import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kupe/constants.dart';
import 'package:kupe/network/network_check.dart';
import 'package:kupe/screens/alarm_report_description.dart';
import 'package:kupe/screens/dostlarin_guncelle.dart';
import 'package:kupe/screens/animal_history_tracking.dart';
import 'package:kupe/screens/home_page.dart';
import 'package:kupe/screens/kullanici_profili.dart';
import 'package:kupe/screens/login_page.dart';
import 'package:kupe/screens/profil_guncelle.dart';
import 'package:kupe/screens/region_delete_name.dart';
import 'package:kupe/screens/saglik_takip.dart';
import 'package:kupe/screens/password_change.dart';
import 'package:kupe/dbtables/users_table.dart';
import 'package:kupe/widgets/alert_dialog_messages.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NavMenu extends StatefulWidget {
  final bool rememberMeValue;
  NavMenu({this.rememberMeValue});
  @override
  _NavMenuState createState() => _NavMenuState();
}

class _NavMenuState extends State<NavMenu> {
  NetworkCheck _networkCheck = NetworkCheck();
  User _getUser = User();
  List<User> _userData;

  //call fetchUsers() function inside this function in order to prevent 'instance of Users' error
  void _getUserData(int id) async {
    var dataList = await _getUser.fetchUserProfile(id);
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
      child: ModalProgressHUD(
        inAsyncCall: showSpinner,
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
                  leading: Icon(Icons.account_box, color: Colors.white),
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
                      showSpinner = true;
                    });

                    User user;
                    try {
                      _networkCheck.check().then((internet) {
                        if (internet != null && internet) {
                          Navigator.of(context).pop();
                          if (_userData != null) {
                            for (user in _userData) {
                              if (loggedUserID == user.id) {
                                Navigator.of(context).push(
                                  PageRouteBuilder(
                                    opaque: false,
                                    pageBuilder: (BuildContext context, _, __) {
                                      return KullaniciProfili(
                                        kullid: user.id,
                                        ad: user.username,
                                        adres: user.adress,
                                        telNo: user.telno,
                                        email: user.eMail,
                                        kayitliVet: user.veteriner,
                                      );
                                    },
                                  ),
                                );
                              } else {
                                throw Exception('Could not find selected user');
                              }
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
                ListTile(
                    leading: Icon(
                      Icons.medical_services_outlined,
                      color: Colors.white,
                    ),
                    title: Text(
                      'Sağlık Takip',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                    onTap: () {
                      _networkCheck.check().then((internet) {
                        if (internet != null && internet) {
                          Navigator.of(context).pop();
                          Navigator.pushNamed(context, SaglikTakip.id);
                        } else {
                          //if there is no internet connection
                          showDialog(
                            context: context,
                            builder: (_) => InternetError(),
                          );
                        }
                      });
                    }),
                ListTile(
                  leading: Icon(Icons.mobile_friendly, color: Colors.white),
                  title: Text(
                    'Dostlarını Güncelle',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  onTap: () {
                    _networkCheck.check().then((internet) {
                      if (internet != null && internet) {
                        Navigator.of(context).pop();
                        Navigator.of(context).push(
                          PageRouteBuilder(
                            opaque: false,
                            pageBuilder: (BuildContext context, _, __) {
                              return DostlariniGuncelle();
                            },
                          ),
                        );
                      } else {
                        //if there is no internet connection
                        showDialog(
                          context: context,
                          builder: (_) => InternetError(),
                        );
                      }
                    });
                  },
                ),
                ListTile(
                  leading: Icon(Icons.refresh_outlined, color: Colors.white),
                  title: Text(
                    'Yenile',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  onTap: () {
                    _networkCheck.check().then(
                      (internet) {
                        if (internet != null && internet) {
                          Navigator.popAndPushNamed(context, HomePage.id);
                        } else {
                          //if there is no internet connection
                          showDialog(
                            context: context,
                            builder: (_) => InternetError(),
                          );
                        }
                      },
                    );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.slideshow, color: Colors.white),
                  title: Text(
                    'Geçmiş İzleme',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  onTap: () {
                    _networkCheck.check().then(
                      (internet) {
                        if (internet != null && internet) {
                          Navigator.of(context).pop();
                          Navigator.of(context).push(PageRouteBuilder(
                            opaque: false,
                            pageBuilder: (BuildContext context, _, __) {
                              return AnimalHistoryTracking();
                            },
                          ));
                        } else {
                          //if there is no internet connection
                          showDialog(
                            context: context,
                            builder: (_) => InternetError(),
                          );
                        }
                      },
                    );
                  },
                ),
                //Submenu oluşturuldu
                Divider(color: Colors.white, thickness: 0.3),
                Theme(
                  data: Theme.of(context).copyWith(
                      accentColor: kMainKupeColor,
                      unselectedWidgetColor: Colors.white),
                  child: ExpansionTile(
                    backgroundColor: kLoginLightDarkBackground,
                    leading:
                        Icon(Icons.edit_location_outlined, color: Colors.white),
                    title: Text('Bölge',
                        style: TextStyle(fontSize: 18, color: Colors.white)),
                    children: [
                      ListTile(
                          leading: Icon(Icons.add, color: Colors.white),
                          title: Text(
                            'Yeni',
                            style:
                                TextStyle(fontSize: 18.0, color: Colors.white),
                          ),
                          onTap: () {
                            _networkCheck.check().then((internet) {
                              if (internet != null && internet) {
                                Navigator.of(context).pop();
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            HomePage(isPolygon: true)));
                              } else {
                                showDialog(
                                  context: context,
                                  builder: (_) => InternetError(),
                                );
                              }
                            });
                          }),
                      ListTile(
                        leading: Icon(Icons.create, color: Colors.white),
                        title: Text(
                          'Düzenle',
                          style: TextStyle(fontSize: 18.0, color: Colors.white),
                        ),
                        onTap: () {
                          _networkCheck.check().then((internet) {
                            if (internet != null && internet) {
                              Navigator.of(context).pop();
                              Navigator.of(context).push(PageRouteBuilder(
                                opaque: false,
                                pageBuilder: (BuildContext context, _, __) {
                                  return RegionDeleteName();
                                },
                              ));
                            } else {
                              showDialog(
                                context: context,
                                builder: (_) => InternetError(),
                              );
                            }
                          });
                        },
                      ),
                    ],
                  ),
                ),
                //Submenu oluşturuldu
                Divider(color: Colors.white, thickness: 0.3),
                Theme(
                  data: Theme.of(context).copyWith(
                      accentColor: kMainKupeColor,
                      unselectedWidgetColor: Colors.white),
                  child: ExpansionTile(
                    //trailing:
                    //Icon(Icons.subdirectory_arrow_left, color: Colors.white),
                    backgroundColor: kLoginLightDarkBackground,
                    leading: Icon(Icons.settings, color: Colors.white),
                    title: Text('Ayarlar',
                        style: TextStyle(fontSize: 18, color: Colors.white)),
                    children: [
                      ListTile(
                        leading: Icon(
                          Icons.admin_panel_settings_sharp,
                          color: Colors.white,
                        ),
                        title: Text(
                          'Şifre Değiştir',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                        onTap: () {
                          _networkCheck.check().then((internet) {
                            if (internet != null && internet) {
                              Navigator.of(context).pop();
                              Navigator.of(context).push(
                                PageRouteBuilder(
                                  opaque: false,
                                  pageBuilder: (BuildContext context, _, __) {
                                    return PasswordChange();
                                  },
                                ),
                              );
                            } else {
                              //if there is no internet connection
                              showDialog(
                                context: context,
                                builder: (_) => InternetError(),
                              );
                            }
                          });
                        },
                      ),
                      ListTile(
                        leading:
                            Icon(Icons.switch_account, color: Colors.white),
                        title: Text('Profil Güncelle',
                            style:
                                TextStyle(fontSize: 18, color: Colors.white)),
                        onTap: () {
                          _networkCheck.check().then((internet) {
                            if (internet != null && internet) {
                              Navigator.of(context).pop();
                              Navigator.of(context).push(
                                PageRouteBuilder(
                                  opaque: false,
                                  pageBuilder: (BuildContext context, _, __) {
                                    return ProfilGuncelle();
                                  },
                                ),
                              );
                            } else {
                              //if there is no internet connection
                              showDialog(
                                context: context,
                                builder: (_) => InternetError(),
                              );
                            }
                          });
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.alarm, color: Colors.white),
                        title: Text(
                          'Alarm & Rapor Tanımlama',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                        onTap: () {
                          _networkCheck.check().then((internet) {
                            if (internet != null && internet) {
                              Navigator.of(context).pop();
                              Navigator.of(context).push(
                                PageRouteBuilder(
                                  opaque: false,
                                  pageBuilder: (BuildContext context, _, __) {
                                    return AlarmReportDescription();
                                  },
                                ),
                              );
                            } else {
                              //if there is no internet connection
                              showDialog(
                                context: context,
                                builder: (_) => InternetError(),
                              );
                            }
                          });
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
                  onTap: () async {
                    if (widget.rememberMeValue != null &&
                        widget.rememberMeValue) {
                      WidgetsFlutterBinding.ensureInitialized();
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      var username = prefs.getString('username');
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext ctx) =>
                              LoginPage(username: username),
                        ),
                      );
                    } else if (widget.rememberMeValue == null ||
                        widget.rememberMeValue) {
                      WidgetsFlutterBinding.ensureInitialized();
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      var username = prefs.getString('username');
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext ctx) =>
                              LoginPage(username: username),
                        ),
                      );
                    }
                    //close all previous screens and take the user to the login page
                    /* Navigator.of(context).pushNamedAndRemoveUntil(
                        LoginPage.id, (Route<dynamic> route) => false);*/
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
