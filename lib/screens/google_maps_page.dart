import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kupe/screens/HayvanMarkerlari.dart';
import 'package:location/location.dart';

class GoogleMapsPage extends StatefulWidget {
  static const String id = 'google_maps_page';

  @override
  _GoogleMapsPageState createState() => _GoogleMapsPageState();
}

class UserAnimalList {
  MarkerId markerId;
  LatLng position;

  String ad;
  String sagDurumu;
  String isi;
  String cinsiyet;
  String renk;
  String sonKonT;
  String hayvanTuru;

  UserAnimalList({
    this.markerId,
    this.position,
    this.ad,
    this.sagDurumu,
    this.isi,
    this.cinsiyet,
    this.renk,
    this.sonKonT,
    this.hayvanTuru,
  });

  static List<UserAnimalList> getAnimals() {
    return <UserAnimalList>[
      UserAnimalList(
          markerId: MarkerId('1'),
          position: LatLng(40.999593, 28.780675),
          ad: 'Boncuk',
          sagDurumu: 'iyi',
          isi: '37.5',
          cinsiyet: 'Erkek',
          renk: 'Kahverengi',
          sonKonT: '19.12.2020 17:25:57',
          hayvanTuru: 'Köpek'),
      UserAnimalList(
          markerId: MarkerId('2'),
          position: LatLng(41.097982, 28.795096),
          ad: 'Bobi',
          sagDurumu: 'iyi',
          isi: '37.5',
          cinsiyet: 'Erkek',
          renk: 'Siyah',
          sonKonT: '17.12.2020 19:35:45',
          hayvanTuru: 'Köpek'),
      UserAnimalList(
          markerId: MarkerId('3'),
          position: LatLng(41.045699, 28.920069),
          ad: 'Maru',
          sagDurumu: 'Normal',
          isi: '37.5',
          cinsiyet: 'Erkek',
          renk: 'Koyu kahverengi',
          sonKonT: '18.12.2020 15:57:37',
          hayvanTuru: 'Kedi'),
    ];
  }
}

class _GoogleMapsPageState extends State<GoogleMapsPage> {
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

  @override
  void initState() {
    super.initState();
    _markerIconDog();
    _markerIconCat();
    _checkLocationPermission();
  }

  //Marker icons
  void _markerIconDog() async {
    BitmapDescriptor.fromAssetImage(ImageConfiguration(), 'images/kopek_64.png')
        .then((onValue) {
      _mIconDog = onValue;
    });
  }

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

  //show user's animals on the map
  void _onMapCreated(GoogleMapController controller) {
    googleMapController = controller;
    List<UserAnimalList> _animalMarkers = UserAnimalList.getAnimals();

    for (UserAnimalList animal in _animalMarkers) {
      setState(() {
        Marker markerList = Marker(
          markerId: animal.markerId,
          position: animal.position,
          infoWindow: InfoWindow(
              title: animal.ad,
              snippet: 'Daha fazla bilgi için tıklayınız..',
              onTap: () {
                Navigator.of(context).push(PageRouteBuilder(
                    opaque: false,
                    pageBuilder: (BuildContext context, _, __) {
                      return HayvanMarkerlari(
                        ad: animal.ad,
                        sagDurumu: animal.sagDurumu,
                        isi: animal.isi,
                        cinsiyet: animal.cinsiyet,
                        renk: animal.renk,
                        sonKonT: animal.sonKonT,
                        deger: animal.markerId,
                      );
                    }));
              }),
          icon: animal.hayvanTuru == 'Köpek'
              ? _mIconDog
              : animal.hayvanTuru == 'Kedi'
                  ? _mIconCat
                  : null,
        );
        //add all animals which are in _animalMarkers
        markers[animal.markerId] = markerList;
      });
    }
  }

  //On map start; default coordinates set to Istanbul
  final LatLng _defaultIstanbul = const LatLng(41.015137, 28.979530);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GoogleMap(
          initialCameraPosition: CameraPosition(
            target: _defaultIstanbul,
            zoom: 9.0,
          ),
          mapType: _mapType,
          markers: Set<Marker>.of(markers.values), //_markers,
          onMapCreated: _onMapCreated,
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
    );
  }
}
