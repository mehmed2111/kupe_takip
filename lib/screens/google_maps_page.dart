import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kupe/constants.dart';
import 'package:kupe/screens/HayvanMarkerlari.dart';
import 'package:kupe/widgets/marker_info_window.dart';
import 'package:kupe/widgets/nav_menu.dart';
import 'package:location/location.dart';
import 'dart:collection';

import '../bildirim_deneme.dart';

class GoogleMapsPage extends StatefulWidget {
  static const String id = 'google_maps_page';
  final LocationData location;
  GoogleMapsPage({this.location});

  @override
  _GoogleMapsPageState createState() => _GoogleMapsPageState();
}

class _GoogleMapsPageState extends State<GoogleMapsPage> {
  MapType _mapType = MapType.normal;
  //Location
  LocationData _locationData;

  //Maps
  Set<Marker> _markers = HashSet<Marker>();
  GoogleMapController _googleMapController;
  BitmapDescriptor _markerIcon;

  //id
  int _markerIdCounter = 1;

  //Type controller
  bool _isMarker = false;

  @override
  void initState() {
    super.initState();
    //Marker ikonunu değiştirmek istersem
    _setMarkerIcon();
    _locationData = widget.location;
    //print('Google Maps Page de........');
    //print('Lat Long buraya gelmeli... $_locationData');
  }

  //Marker ikonunu değiştirmek için
  void _setMarkerIcon() async {
    BitmapDescriptor.fromAssetImage(ImageConfiguration(), 'images/kopek.png')
        .then((onValue) {
      _markerIcon = onValue;
    });
  }

  //Set Markers to the map
  /*void _setMarkers(LatLng point) {
    final String markerIdVal = 'marker_id_$_markerIdCounter';
    _markerIdCounter++;
    setState(() {
      print(
          'Marker | Latitude: ${point.latitude} Longitude: ${point.longitude}');
      _markers.add(
        Marker(
          markerId: MarkerId(markerIdVal),
          position: point,
        ),
      );
    });
  }*/

  //default coordinates set to Istanbul
  //final LatLng _center = const LatLng(41.015137, 28.979530);

  //Mapi bu marker ayarlarıyla başlat
  void _onMapCreated(GoogleMapController controller) {
    _googleMapController = controller;

    setState(() {
      _markers.add(
        Marker(
          markerId: MarkerId('0'),
          position: LatLng(41.015137, 28.979530),
          infoWindow: InfoWindow(
            title: 'Boncuk',
            snippet: 'Boncuğun bilgileri',
            //buraya bizim hayvanların bilgileri gelecek, popup şeklinde
            onTap: () => {
              Navigator.of(context).push(PageRouteBuilder(
                  opaque: false,
                  pageBuilder: (BuildContext context, _, __) {
                    return HayvanMarkerlari();
                  })),
            },
          ),
          icon: _markerIcon,
        ),
      );
    });
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
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(_locationData.latitude, _locationData.longitude),
              zoom: 11.0,
            ),
            mapType: _mapType,
            markers: _markers,
            myLocationEnabled: true,
            /* onTap: (point) {
              if (_isMarker) {
                setState(() {
                  _markers.clear();
                  _setMarkers(point);
                });
              } else {}
            },*/
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
                  SizedBox(width: 13.0),
                  //Marker için ornek button
                  /*RaisedButton(
                      color: kMainKupeColor,
                      onPressed: () {
                        _isMarker = true;
                      },
                      child: Text('Marker',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white))),*/
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
