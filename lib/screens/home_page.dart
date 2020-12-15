import 'dart:io';

import 'package:flutter/material.dart';
import 'package:kupe/bildirim_deneme.dart';
import 'package:kupe/constants.dart';
import 'package:kupe/widgets/nav_menu.dart';
import 'package:kupe/screens/google_maps_page.dart';
import 'package:location/location.dart';
import '../bildirim_deneme.dart';

class HomePage extends StatefulWidget {
  static const String id = 'home_page';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Location location = Location();
  bool _serviceEnabled;
  PermissionStatus _permissionGranted;
  LocationData _locationData;

  @override
  void initState() {
    super.initState();
    _checkLocationPermission();
    print('home page de');
    print(_locationData);
  }

  //Check Location Permissions and get my location
  void _checkLocationPermission() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    _locationData = await location.getLocation();

    print('Fonksyonunu içinde..');
    print(_locationData);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
          backgroundColor: Colors.white,
          //navigation menu sayfasına git
          drawer: NavMenu(),
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: kMainKupeColor,
            title: Image.asset('images/yazi_logo.png', fit: BoxFit.contain),
            actions: [
              IconButton(
                  icon: Icon(Icons.notifications_active_outlined),
                  onPressed: () {
                    Navigator.pushNamed(context, BildirimDeneme.id);
                  }),
            ],
          ),
          //google maps sayfasına git
          /*body: _locationData != null
            ? GoogleMapsPage(location: _locationData)
            : null,*/

          body: Container(
            child: ConstrainedBox(
              constraints: BoxConstraints.expand(),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                child: Column(
                  children: [
                    Text(
                      'Dostlarınızı görüntülemek için ekrana dokunun...',
                      style: TextStyle(
                          color: kLoginDarkBackground, fontSize: 18.0),
                    ),
                    FlatButton(
                      onPressed: () => _locationData != null
                          ? Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => GoogleMapsPage(
                                        location: _locationData,
                                      )))
                          : null,
                      padding: EdgeInsets.all(0.0),
                      child: Image.asset(
                        'images/logo_transparent.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
          /*RaisedButton(
          onPressed: () => _locationData != null
              ? Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => GoogleMapsPage(
                            location: _locationData,
                          )))
              : null,
        ),*/

          //GoogleMapsPage(location: _locationData),
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
