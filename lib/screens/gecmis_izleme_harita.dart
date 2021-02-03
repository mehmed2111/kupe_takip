import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kupe/constants.dart';
import 'package:kupe/dbtables/animal_tracking.dart';
import 'package:kupe/network/network_check.dart';
import 'package:kupe/widgets/alert_dialog_messages.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class GecmisIzlemeHarita extends StatefulWidget {
  final int animalId;

  GecmisIzlemeHarita({this.animalId});

  @override
  _GecmisIzlemeHaritaState createState() => _GecmisIzlemeHaritaState();
}

class _GecmisIzlemeHaritaState extends State<GecmisIzlemeHarita> {
  final LatLng _defaultTurkey = const LatLng(39.1667, 35.6667);
  NetworkCheck _networkCheck = NetworkCheck();
  //map
  GoogleMapController googleMapController;
  Map<PolylineId, Polyline> _polylines = <PolylineId, Polyline>{};

  AnimalTracking _animalTracking = AnimalTracking();
  List<AnimalTracking> animalTrackList;

  /*LatLng _startPoint;
  void getAnimalTrack(int animalId) async {
    var data = await _animalTracking.fetchAnimalTrack(animalId);
    animalTrackList = data;
    for (int i = 0; i < animalTrackList.length; i++) {
      if (widget.animalId == animalTrackList[i].animalId) {
        _startPoint = LatLng(animalTrackList[0].lat, animalTrackList[0].lng);
      }
    }
  }*/

  void _getAnimalTracking(GoogleMapController controller) async {
    var data = await _animalTracking.fetchAnimalTrack(widget.animalId);
    animalTrackList = data;
    //print('json dan gelen data: $animalTrackList');
    googleMapController = controller;
    setState(() {
      showSpinner = true;
    });
    List<LatLng> polylinePoints = List<LatLng>();
    try {
      _networkCheck.check().then((internet) {
        if (internet != null && internet) {
          if (animalTrackList != null) {
            for (int i = 0; i < animalTrackList.length; i++) {
              if (widget.animalId == animalTrackList[i].animalId) {
                //add the points(coordinates)
                polylinePoints.add(LatLng(
                  double.parse('${animalTrackList[i].lat}'),
                  double.parse('${animalTrackList[i].lng}'),
                ));
                setState(() {
                  Polyline polylineList = Polyline(
                    color: Colors.red,
                    polylineId:
                        PolylineId('${animalTrackList[i].id.toString()}'),
                    points: polylinePoints,
                    width: 2,
                  );
                  _polylines[
                          PolylineId('${animalTrackList[i].id.toString()}')] =
                      polylineList;
                  //print('polyline lar: $_polylines');
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

  @override
  void initState() {
    super.initState();
    //getAnimalTrack(widget.animalId);
    //print('Animal id from gecmis izleme: ${widget.animalId}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: kMainKupeColor,
        title: Text('Geçmiş İzleme'),
      ),
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Column(
          children: [
            Expanded(
              child: GoogleMap(
                initialCameraPosition:
                    CameraPosition(target: _defaultTurkey, zoom: 7),
                mapType: MapType.normal,
                zoomControlsEnabled: false,
                onMapCreated: _getAnimalTracking,
                polylines: Set<Polyline>.of(_polylines.values),
              ),
              flex: 2,
            ),
            Expanded(
              child: Container(
                  color: Colors.white,
                  child: Row(
                    children: [
                      Container(
                        height: 20.0,
                        color: kLoginLightDarkBackground,
                      ),
                    ],
                  )),
              flex: 1,
            ),
          ],
        ),
      ),
    );
  }
}
