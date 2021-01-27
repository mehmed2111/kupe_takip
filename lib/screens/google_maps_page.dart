import 'dart:async';
import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kupe/constants.dart';
import 'package:kupe/dbtables/user_animal_table.dart';
import 'package:kupe/dbtables/user_region.dart';
import 'package:kupe/network/network_check.dart';
import 'package:kupe/widgets/alert_dialog_messages.dart';
import 'package:kupe/widgets/hayvan_marker_widget.dart';
import 'package:location/location.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import '../constants.dart';

class GoogleMapsPage extends StatefulWidget {
  static const String id = 'google_maps_page';

  @override
  _GoogleMapsPageState createState() => _GoogleMapsPageState();
}

class _GoogleMapsPageState extends State<GoogleMapsPage> {
  NetworkCheck _networkCheck = NetworkCheck();
  //call json data every 20 seconds
  Timer timer;
  //On map start; default coordinates set to Turkey
  final LatLng _defaultIstanbul = const LatLng(39.1667, 35.6667);
  //Location
  final Location location = Location();
  LocationData locationData;
  bool _serviceEnabled;
  PermissionStatus _permissionGranted;
  //Maps
  MapType _mapType = MapType.normal;
  GoogleMapController _googleMapController;
  BitmapDescriptor _mIconDog;
  BitmapDescriptor _mIconCat;
  //create markers list
  Map<MarkerId, Marker> _markers = <MarkerId, Marker>{};
  //create polygon
  Map<PolygonId, Polygon> polygon = <PolygonId, Polygon>{};
  Set<Polygon> _polygons = HashSet<Polygon>();
  List<LatLng> polygonLatLngs = List<LatLng>();
  int _polygonIdCounter = 1;
  bool _isPolygon = false;
  //fetch data
  UserAnimals _userAnimals = UserAnimals();
  List<UserAnimals> _userAnimalList;
  UserRegion _userRegion = UserRegion();
  List<UserRegion> _userRegionList;

  void _getRegion(int userID) async {
    var data = await _userRegion.fetchUserRegion(userID);
    _userRegionList = data;
    //print('Fetched region data: ${_userRegionList[0].region1}');
  }

  //call fetchUserAnimals() function inside this function in order to prevent 'instance of Users' error
  //and show user's animals on the map
  void _getUserAnimals(GoogleMapController controller) async {
    var dataList = await _userAnimals.fetchUserAnimals(loggedUserID);
    _userAnimalList = dataList;

    _googleMapController = controller;
    setState(() {
      showSpinner = true;
    });
    try {
      _networkCheck.check().then((internet) {
        if (internet != null && internet) {
          if (_userAnimalList != null) {
            for (int i = 0; i < _userAnimalList.length; i++) {
              if (loggedUserID == _userAnimalList[i].userId) {
                //take the ids of the animals in a user
                animalID = _userAnimalList[i].id;
                //print(animalID);
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
                                return HayvanMarker(
                                  ad: _userAnimalList[i].name,
                                  sagDurumu: 'İyi',
                                  isi: '37',
                                  cinsiyet: _userAnimalList[i].gender == 0
                                      ? 'Erkek'
                                      : _userAnimalList[i].gender == 1
                                          ? 'Dişi'
                                          : null,
                                  renk: _userAnimalList[i].color,
                                  sonKonT: 'Eklenecek',
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
                  _markers[MarkerId('${_userAnimalList[i].id.toString()}')] =
                      markerList;
                });
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
  }

  void _getPolygon() async {
    var data = await _userRegion.fetchUserRegion(loggedUserID);
    _userRegionList = data;

    var fullPolygon;
    var polygonPoints;
    var polygonLatLngs;
    print('Fetched json length: ${_userRegionList.length}');
    for (var i = 0; i < _userRegionList.length; i++) {
      fullPolygon = _userRegionList[i].region1;
      print('fullPolygon: $fullPolygon');
      polygonPoints = fullPolygon.split("_");
      print('polygonPoints: $polygonPoints');
      polygonLatLngs = polygonPoints.length;
      print('polygonLatLngs: $polygonLatLngs');
      //set to null in every json item index change
      List<LatLng> selectedPolygonPoints = List<LatLng>();
      for (var j = 0; j < polygonLatLngs; j++) {
        var selectedLatLngs = [];
        selectedLatLngs.add(polygonPoints[j].split("x"));
        print('selectedLatLngs: $selectedLatLngs');

        selectedPolygonPoints.add(
          LatLng(
            double.parse('${selectedLatLngs[0][0]}'),
            double.parse('${selectedLatLngs[0][1]}'),
          ),
        );
        print('selectedPolygonPoints: $selectedPolygonPoints');

        /*
        //draw polygon on the map
        final String polygonIdVal = 'polygon_id_$_polygonIdCounter';
        _polygons.add(
          Polygon(
            polygonId: PolygonId(polygonIdVal),
            points: polygonLatLngs,
            strokeWidth: 2,
            strokeColor: Colors.red,
            fillColor: Colors.yellow.withOpacity(0.15),
          ),
        );*/

      }
      setState(() {
        Polygon polygonList = Polygon(
          polygonId: PolygonId('${_userRegionList[i].id.toString()}'),
          points: selectedPolygonPoints,
          strokeWidth: 2,
          strokeColor: Colors.red,
          fillColor: Colors.yellow.withOpacity(0.15),
        );
        polygon[PolygonId('${_userRegionList[i].id.toString()}')] = polygonList;
      });
      //print('polygonList: $polygon');
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

  @override
  void initState() {
    super.initState();
    _markerIconDog();
    _markerIconCat();
    _checkLocationPermission();
    timer = Timer.periodic(Duration(seconds: 20),
        (Timer t) => _getUserAnimals(_googleMapController));
    //print('Timer called $timer');
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
            markers: Set<Marker>.of(_markers.values), //_markers,
            onMapCreated: _getUserAnimals,
            polygons: Set<Polygon>.of(polygon.values),
            myLocationEnabled: true,
            /*onTap: (point) {
              if (_isPolygon) {
                setState(() {
                  //polygonLatLngs.add(point);
                  _setPolygon();
                });
              }
            },*/
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
                      },
                    ),
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
                      },
                    ),
                  ),
                  SizedBox(width: 13.0),
                  RaisedButton(
                    color: Colors.white.withOpacity(0.75),
                    onPressed: () {
                      //_isPolygon = true;
                      _getPolygon();
                    },
                    child: Text(
                      'Bölge Oluştur',
                      style: TextStyle(
                          fontSize: 18.0, color: kLoginDarkBackground),
                    ),
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
