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
    return Scaffold(
      backgroundColor: Colors.grey[300],
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

      body: RaisedButton(
        onPressed: () => _locationData != null
            ? Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => GoogleMapsPage(
                          location: _locationData,
                        )))
            : null,
      ),

      //GoogleMapsPage(location: _locationData),
    );
  }
}
