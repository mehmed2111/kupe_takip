import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kupe/constants.dart';
import 'package:kupe/dbtables/animal_data.dart';
import 'package:kupe/dbtables/region_exit_control.dart';
import 'package:kupe/dbtables/user_animal_table.dart';
import 'package:kupe/dbtables/user_region.dart';
import 'package:kupe/network/network_check.dart';
import 'package:kupe/screens/region_name.dart';
import 'package:kupe/widgets/alert_dialog_messages.dart';
import 'package:kupe/widgets/hayvan_marker_widget.dart';
import 'package:kupe/widgets/rounded_button.dart';
import 'package:location/location.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class GoogleMapsPage extends StatefulWidget {
  static const String id = 'google_maps_page';

  final bool isPolygon;
  GoogleMapsPage({this.isPolygon});

  @override
  _GoogleMapsPageState createState() => _GoogleMapsPageState();
}

class _GoogleMapsPageState extends State<GoogleMapsPage> {
  NetworkCheck _networkCheck = NetworkCheck();
  //call json data every 20 seconds
  Timer timer;
  //On map start; default coordinates set to Turkey
  final LatLng _defaultTurkey = const LatLng(39.1667, 35.6667);
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
  //Polygon
  Map<PolygonId, Polygon> _polygon = <PolygonId, Polygon>{};
  List<LatLng> _polygonLatLngs = List<LatLng>();
  int _polygonIdCounter = 1;
  //animals in a user
  UserAnimals _userAnimals = UserAnimals();
  List<UserAnimals> _userAnimalList;
  //regions in a user
  UserRegion _userRegion = UserRegion();
  List<UserRegion> _userRegionList;
  //all animal data
  AnimalData _getAnimalData = AnimalData();
  List<AnimalData> _animalDataList;
  AnimalData _animalData;

  RegionExitControl _regionExitControl = RegionExitControl();
  List<RegionExitControl> regionExitList;

  /*void _exitCheck(int animalId) async {
    var data = await _regionExitControl.regionCheck(animalId);
    regionExitList = data;

    /*Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BildirimDeneme(regionExitList: regionExitList),
      ),
    );*/

    /*if (regionExitList != null) {
      setState(() {
        BildirimDeneme(regionExitList: regionExitList);
      });
    }*/

    /*if (regionExitList[0].komut == regionExitList[1].komut) {
      print('İhlal yok');
    }
    if (regionExitList[0].komut == 'BA' && regionExitList[1].komut == 'AB') {
      print('İhlal var');
    }*/
    //print('regionExitList: ${regionExitList[0].komut}');
  }*/

  //call fetchUserAnimals() function inside this function in order to prevent 'instance of Users' error and show user's animals on the map
  void _getUserAnimals(GoogleMapController controller) async {
    //_exitCheck(17);
    //fetch all user animals
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
                      onTap: () async {
                        //fetch all animal data by id
                        var data = await _getAnimalData.fetchAnimalData(
                          _userAnimalList[i].id,
                        );
                        _animalDataList = data;
                        //print('user animal dan gelen id: ${_userAnimalList[i].id}');

                        if (_animalDataList != null) {
                          for (_animalData in _animalDataList) {
                            if (_userAnimalList[i].id == _animalData.id) {
                              //print('animal data dan gelen id: ${_animalData.id}');
                              Navigator.of(context).push(PageRouteBuilder(
                                  opaque: false,
                                  pageBuilder: (BuildContext context, _, __) {
                                    return HayvanMarker(
                                      ad: _animalData.name,
                                      sagDurumu: 'İyi',
                                      isi: '37',
                                      cinsiyet: _animalData.gender == 0
                                          ? 'Erkek'
                                          : _animalData.gender == 1
                                              ? 'Dişi'
                                              : null,
                                      renk: _animalData.color,
                                      sonKonT: _animalData.konumTarih,
                                    );
                                  }));
                            } else {
                              showDialog(
                                context: context,
                                builder: (_) => AnimalIdDoesNotMatched(),
                              );
                            }
                          }
                        } else {
                          showDialog(
                            context: context,
                            builder: (_) => CouldNotLoadData(),
                          );
                        }
                      },
                    ),
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

  void _getUserPolygon() async {
    var data = await _userRegion.fetchUserRegion(loggedUserID);
    _userRegionList = data;
    //print('Fetched json length: ${_userRegionList.length}');
    for (var i = 0; i < _userRegionList.length; i++) {
      var fullPolygon = _userRegionList[i].region1;
      //print('fullPolygon: $fullPolygon');
      var polygonPoints = fullPolygon.split("_");
      //print('polygonPoints: $polygonPoints');
      var polygonLatLngs = polygonPoints.length;
      //print('polygonLatLngs: $polygonLatLngs');
      //set to null in every json item index change
      List<LatLng> selectedPolygonPoints = List<LatLng>();
      for (var j = 0; j < polygonLatLngs; j++) {
        var selectedLatLngs = [];
        selectedLatLngs.add(polygonPoints[j].split("x"));
        //print('selectedLatLngs: $selectedLatLngs');

        selectedPolygonPoints.add(
          LatLng(
            double.parse('${selectedLatLngs[0][0]}'),
            double.parse('${selectedLatLngs[0][1]}'),
          ),
        );
        //print('selectedPolygonPoints: $selectedPolygonPoints');
      }
      setState(() {
        Polygon polygonList = Polygon(
          polygonId: PolygonId('${_userRegionList[i].id.toString()}'),
          points: selectedPolygonPoints,
          strokeWidth: 2,
          strokeColor: Colors.red,
          fillColor: Colors.yellow.withOpacity(0.15),
        );
        _polygon[PolygonId('${_userRegionList[i].id.toString()}')] =
            polygonList;
      });
      //print('polygonList: $polygon');
    }
  }

  //draw Polygon region
  void _drawPolygonRegion() {
    final String polygonIdVal = 'polygon_id_$_polygonIdCounter';
    setState(() {
      Polygon polygonDraw = Polygon(
        polygonId: PolygonId(polygonIdVal),
        points: _polygonLatLngs,
        strokeWidth: 2,
        strokeColor: Colors.red,
        fillColor: Colors.yellow.withOpacity(0.15),
      );
      _polygon[PolygonId(polygonIdVal)] = polygonDraw;
    });
    //print('polygon Instance of Lat Lngs: $polygonLatLngs');
  }

  String _polygonToDatabase() {
    var latLngCounter = 0;
    var truePolygon = "";
    for (var a = 0; a <= ((_polygonLatLngs.length * 2) - 1); a++) {
      latLngCounter++;
      var polygonDrawn = _polygonLatLngs.toString();
      var polygonPath = polygonDrawn.split(",");
      if (latLngCounter % 2 == 0) {
        var spaceReplace = polygonPath[a].replaceAll(" ", "");
        var leftReplace = spaceReplace.replaceAll("[", "");
        var leftReplace2 = leftReplace.replaceAll("LatLng", "");
        var leftReplace3 = leftReplace2.replaceAll("(", "");
        var rightReplace = leftReplace3.replaceAll(")", "");
        var rightReplace2 = rightReplace.replaceAll("]", "");
        rightReplace2 = rightReplace2 + "_";
        truePolygon += rightReplace2;
      } else {
        var spaceReplace = polygonPath[a].replaceAll(" ", "");
        var leftReplace = spaceReplace.replaceAll("[", "");
        var leftReplace2 = leftReplace.replaceAll("LatLng", "");
        var leftReplace3 = leftReplace2.replaceAll("(", "");
        var rightReplace = leftReplace3.replaceAll(")", "");
        var rightReplace2 = rightReplace.replaceAll("]", "");
        rightReplace2 = rightReplace2 + "x";
        truePolygon += rightReplace2;
      }
    }
    //subtract the last character("_") of the string
    truePolygon = truePolygon.substring(0, truePolygon.length - 1);
    //print('true Polygon here: $truePolygon');
    return truePolygon;
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
    //if there are polygon regions in a user, show them on the map
    _getUserPolygon();
    //print('Timer called $timer');
    //print('isPolygon value: ${widget.isPolygon}');
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
              target: _defaultTurkey,
              zoom: 5.0,
            ),
            mapType: _mapType,
            markers: Set<Marker>.of(_markers.values), //_markers,
            onMapCreated: _getUserAnimals,
            polygons: Set<Polygon>.of(_polygon.values), //_polygons,
            //myLocationEnabled: true,
            zoomControlsEnabled: false,
            onTap: (point) {
              if (widget.isPolygon != null && widget.isPolygon) {
                setState(() {
                  _polygonLatLngs.add(point);
                  _drawPolygonRegion();
                });
              } else {
                //do nothing
              }
            },
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 13.0, vertical: 16.0),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Row(children: [
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
                if (widget.isPolygon != null && widget.isPolygon)
                  RoundedButton(
                    colour: kMainKupeColor.withOpacity(0.80),
                    buttonTitle: 'Bölge Oluştur',
                    onPressed: () {
                      if (_polygonLatLngs.length >= 3) {
                        Navigator.of(context).pop();
                        Navigator.of(context).push(PageRouteBuilder(
                          opaque: false,
                          pageBuilder: (BuildContext context, _, __) {
                            return RegionName(
                                polygonLatLngs: _polygonToDatabase());
                          },
                        ));
                      } else {
                        Scaffold.of(context).showSnackBar(SnackBar(
                          backgroundColor: Colors.white,
                          content: Text(
                            'Bölge oluşturmak için HARİTA üzerinde en az 3 nokta seçmelisiniz..',
                            style: TextStyle(
                                color: Colors.grey[700], fontSize: 18.0),
                          ),
                        ));
                      }
                    },
                  )
                else
                  //widget gone example
                  Visibility(
                    visible: false,
                    child: RaisedButton(onPressed: () {}),
                  ),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
