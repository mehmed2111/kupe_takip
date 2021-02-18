import 'package:flutter/material.dart';
import 'package:kupe/notifications/notification_on_region_exit.dart';
import 'package:kupe/constants.dart';
import 'package:kupe/widgets/alert_dialog_messages.dart';
import 'package:kupe/widgets/nav_menu.dart';
import 'package:kupe/screens/google_maps_page.dart';
import 'google_maps_page.dart';

class HomePage extends StatefulWidget {
  static const String id = 'home_page';
  final bool isPolygon;
  HomePage({this.isPolygon});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        backgroundColor: Colors.white,
        //opens nav menu page
        drawer: NavMenu(),
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: kMainKupeColor,
          title: Image.asset('images/yazi_logo.png', fit: BoxFit.contain),
          actions: [
            IconButton(
                icon: Icon(Icons.notifications_active_outlined),
                onPressed: () {
                  print(loggedUserID);
                  Navigator.pushNamed(context, NotificationOnRegionExit.id);
                }),
          ],
        ),
        //opens google maps page
        body: GoogleMapsPage(isPolygon: widget.isPolygon),
      ),
    );
  }

  //Alert Dialog to ask to exit from the App onBackButton pressed on Android devices
  //declared context here because when I import notification_on_region_exit.dart context gets inactive
  BuildContext get context;
  Future<bool> _onBackPressed() {
    return showDialog(
          context: context,
          builder: (context) => OnBackPressedExitOrNot(),

          /*AlertDialog(
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
            );*/
        ) ??
        false;
  }
}
