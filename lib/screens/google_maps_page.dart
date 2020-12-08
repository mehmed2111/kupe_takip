import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapsPage extends StatefulWidget {
  static const String id = 'google_maps_page';

  @override
  _GoogleMapsPageState createState() => _GoogleMapsPageState();
}

class _GoogleMapsPageState extends State<GoogleMapsPage> {
  //Completer<GoogleMapController> _mapController = Completer();
  GoogleMapController mapController;
  MapType _mapType = MapType.normal;

  //default coordinates set to Istanbul
  final LatLng _center = const LatLng(41.015137, 28.979530);

  void _onMapCreated(GoogleMapController controller) {
    //_mapController.complete(controller);
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GoogleMap(
          //choose type of the map
          mapType: _mapType,
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: _center,
            zoom: 11.0,
          ),
          zoomControlsEnabled: true,
        ),
        Padding(
          padding: EdgeInsets.all(16.0),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
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
                SizedBox(width: 16.0),
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
