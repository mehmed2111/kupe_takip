import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapsPage extends StatefulWidget {
  static const String id = 'google_maps_page';

  @override
  _GoogleMapsPageState createState() => _GoogleMapsPageState();
}

class _GoogleMapsPageState extends State<GoogleMapsPage> {
  GoogleMapController mapController;
  var mapType = MapType.normal;

  //default coordinates set to Istanbul
  final LatLng _center = const LatLng(41.015137, 28.979530);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        //buradan uydu görünümü de yapılabilir
        mapType: mapType,
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: _center,
          zoom: 10.0,
        ),
        zoomControlsEnabled: true,
      ),
      floatingActionButton: FloatingActionButton.extended(
          label: Text('Harita görünümünü değiştir'),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          icon: Icon(Icons.swipe),
          onPressed: () {
            setState(() {
              if (mapType == MapType.normal) {
                this.mapType = MapType.satellite;
              } else {
                this.mapType = MapType.normal;
              }
            });
          }),
    );
  }
}

/*
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          child: const Icon(Icons.my_location),
          onPressed: () {
            setState(() {
              this.mapType = MapType.satellite;
            });
          }),*/
