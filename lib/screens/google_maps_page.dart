import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kupe/screens/HayvanMarkerlari.dart';
import 'package:location/location.dart';
import 'dart:collection';

class GoogleMapsPage extends StatefulWidget {
  static const String id = 'google_maps_page';

  @override
  _GoogleMapsPageState createState() => _GoogleMapsPageState();
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
  BitmapDescriptor _markerIcon;
  Set<Marker> _markers = HashSet<Marker>();

  //create markers list
  Set<Marker> markers = Set();
  List<Marker> addMarkers = [];

  @override
  void initState() {
    super.initState();
    _setMarkerIcon();
    _checkLocationPermission();
  }

  //Marker icon
  void _setMarkerIcon() async {
    BitmapDescriptor.fromAssetImage(ImageConfiguration(), 'images/kopek_64.png')
        .then((onValue) {
      _markerIcon = onValue;
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

  //On map start; default coordinates set to Istanbul
  //final LatLng _center = const LatLng(41.015137, 28.979530);
  void _onMapCreated(GoogleMapController controller) {
    googleMapController = controller;
    int i;
    for (i = 0; i < 6; i++) {
      setState(() {
        _markers.add(
          Marker(
            markerId: MarkerId('$i'),
            position: LatLng(i + 41.015137, i + 28.979530),
            infoWindow: InfoWindow(
              title: 'Boncuk $i',
              snippet: 'Boncuğun bilgileri',
              //buraya bizim hayvanların bilgileri gelecek, popup şeklinde
              onTap: () => {
                Navigator.of(context).push(PageRouteBuilder(
                    opaque: false,
                    pageBuilder: (BuildContext context, _, __) {
                      return HayvanMarkerlari(
                        deger: i,
                      );
                    })),
              },
            ),
            icon: _markerIcon,
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GoogleMap(
          initialCameraPosition: CameraPosition(
            target: LatLng(41.015137, 28.979530),
            zoom: 11.0,
          ),
          mapType: _mapType,
          markers: _markers,
          myLocationEnabled: true,
          onMapCreated: _onMapCreated,
          zoomControlsEnabled: true,
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
