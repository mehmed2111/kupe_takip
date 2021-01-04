import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kupe/constants.dart';
import 'package:kupe/dbtables/user_animal_table.dart';
import 'package:kupe/screens/HayvanMarkerlari.dart';
import 'package:location/location.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class GoogleMapsPage extends StatefulWidget {
  static const String id = 'google_maps_page';

  @override
  _GoogleMapsPageState createState() => _GoogleMapsPageState();
}

class _GoogleMapsPageState extends State<GoogleMapsPage> {
  //On map start; default coordinates set to Turkey
  final LatLng _defaultIstanbul = const LatLng(39.1667, 35.6667);
  bool showSpinner = false;
  //Location
  final Location location = Location();
  LocationData locationData;
  bool _serviceEnabled;
  PermissionStatus _permissionGranted;
  //Maps
  MapType _mapType = MapType.normal;
  GoogleMapController googleMapController;
  BitmapDescriptor _mIconDog;
  BitmapDescriptor _mIconCat;
  //create markers list
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  //
  UserAnimals _userAnimals = UserAnimals();
  List<UserAnimals> _userAnimalList;

  //call fetchUsers() function inside this function in order to prevent 'instance of Users' error
  //and show user's animals on the map
  void _getUsersAnimalsList(GoogleMapController controller) async {
    var dataList = await _userAnimals.fetchUsersAnimals();
    _userAnimalList = dataList;

    googleMapController = controller;
    setState(() {
      showSpinner = true;
    });
    try {
      if (_userAnimalList != null) {
        for (int i = 0; i < _userAnimalList.length; i++) {
          if (loggedUserID == _userAnimalList[i].userId) {
            setState(() {
              Marker markerList = Marker(
                markerId: MarkerId('${_userAnimalList[i].id.toString()}'),
                position:
                    LatLng(_userAnimalList[i].lat, _userAnimalList[i].lng),
                infoWindow: InfoWindow(
                    title: _userAnimalList[i].name,
                    snippet: 'Daha fazla bilgi için tıklayınız..',
                    onTap: () {
                      Navigator.of(context).push(PageRouteBuilder(
                          opaque: false,
                          pageBuilder: (BuildContext context, _, __) {
                            return HayvanMarkerlari(
                              ad: _userAnimalList[i].name,
                              sagDurumu: 'animal.sagDurumu',
                              isi: 'animal.isi',
                              cinsiyet: _userAnimalList[i].gender,
                              renk: _userAnimalList[i].color,
                              sonKonT: 'animal.sonKonT',
                              deger: MarkerId(
                                  '${_userAnimalList[i].id.toString()}'),
                            );
                          }));
                    }),
                icon: _userAnimalList[i].category == 1
                    ? _mIconDog
                    : _userAnimalList[i].category == 0
                        ? _mIconCat
                        : null,
              );
              //add all animals which are in _animalMarkers
              markers[MarkerId('${_userAnimalList[i].id.toString()}')] =
                  markerList;
            });
          }
        }
        setState(() {
          showSpinner = false;
        });
      } else {
        throw Exception('Json data could not load');
      }
    } catch (e) {
      print(e);
    }
  }

  //dog marker icons
  void _markerIconDog() async {
    BitmapDescriptor.fromAssetImage(ImageConfiguration(), 'images/kopek_64.png')
        .then((onValue) {
      _mIconDog = onValue;
    });
  }

  //cat marker icon
  void _markerIconCat() async {
    BitmapDescriptor.fromAssetImage(ImageConfiguration(), 'images/kedi_64.png')
        .then((value) {
      _mIconCat = value;
    });
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
    LocationData currLocation = await location.getLocation();
    setState(() {
      locationData = currLocation;
    });
  }

  //call json data every 20 seconds
  Timer timer;

  @override
  void initState() {
    super.initState();
    _markerIconDog();
    _markerIconCat();
    _checkLocationPermission();
    timer = Timer.periodic(Duration(seconds: 20),
        (Timer t) => _getUsersAnimalsList(googleMapController));
    print('Timer called $timer');
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: _defaultIstanbul,
              zoom: 5.0,
            ),
            mapType: _mapType,
            markers: Set<Marker>.of(markers.values), //_markers,
            onMapCreated: _getUsersAnimalsList,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 13.0, vertical: 16.0),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 28.0,
                    backgroundColor: Colors.white.withOpacity(0.75),
                    child: IconButton(
                        icon: Icon(Icons.satellite),
                        iconSize: 36.0,
                        color: Colors.grey[700],
                        onPressed: () {
                          setState(() {
                            this._mapType = MapType.hybrid;
                          });
                        }),
                  ),
                  SizedBox(width: 13.0),
                  CircleAvatar(
                    radius: 28.0,
                    backgroundColor: Colors.white.withOpacity(0.75),
                    child: IconButton(
                        icon: Icon(Icons.map_rounded),
                        iconSize: 36.0,
                        color: Colors.grey[700],
                        onPressed: () {
                          setState(() {
                            this._mapType = MapType.normal;
                          });
                        }),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
