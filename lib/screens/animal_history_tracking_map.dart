import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kupe/constants.dart';
import 'package:kupe/dbtables/animal_tracking.dart';
import 'package:kupe/network/network_check.dart';
import 'package:kupe/widgets/alert_dialog_messages.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class AnimalHistoryTrackingMap extends StatefulWidget {
  final int animalId;
  final String startDateTime;
  final String endDateTime;
  final List<AnimalTracking> animalTrackList;
  AnimalHistoryTrackingMap(
      {this.animalId,
      this.startDateTime,
      this.endDateTime,
      this.animalTrackList});

  @override
  _AnimalHistoryTrackingMapState createState() =>
      _AnimalHistoryTrackingMapState();
}

class _AnimalHistoryTrackingMapState extends State<AnimalHistoryTrackingMap> {
  final LatLng _defaultTurkey = const LatLng(39.1667, 35.6667);
  NetworkCheck _networkCheck = NetworkCheck();
  //map
  GoogleMapController googleMapController;
  Map<PolylineId, Polyline> _polylines = <PolylineId, Polyline>{};

  //AnimalTracking _animalTracking = AnimalTracking();
  //List<AnimalTracking> animalTrackList;

  void _getAnimalTracking(GoogleMapController controller) async {
    /*var data = await _animalTracking.fetchAnimalTrack(
        widget.animalId, widget.startDateTime, widget.endDateTime);
    widget.animalTrackList = data;*/

    googleMapController = controller;
    setState(() {
      showSpinner = true;
    });
    List<LatLng> polylinePoints = List<LatLng>();
    try {
      _networkCheck.check().then((internet) {
        if (internet != null && internet) {
          if (widget.animalTrackList != null) {
            for (int i = 0; i < widget.animalTrackList.length; i++) {
              if (widget.animalId == widget.animalTrackList[i].animalId) {
                /*print('json dan gelen animal id: ${widget.animalTrackList[i].animalId}');
                print('json dan gelen lat: ${widget.animalTrackList[i].lat}');
                print('json dan gelen lng: ${widget.animalTrackList[i].lng}');
                print('json dan gelen tarih: ${widget.animalTrackList[i].tarihBilgi}');*/
                //add the points(coordinates)
                polylinePoints.add(LatLng(
                  double.parse('${widget.animalTrackList[i].lat}'),
                  double.parse('${widget.animalTrackList[i].lng}'),
                ));
                setState(() {
                  Polyline polylineList = Polyline(
                    color: Colors.red,
                    polylineId: PolylineId(
                        '${widget.animalTrackList[i].id.toString()}'),
                    points: polylinePoints,
                    width: 3,
                    geodesic: true,
                  );
                  _polylines[PolylineId(
                          '${widget.animalTrackList[i].id.toString()}')] =
                      polylineList;
                  //print('polyline lar: ${_polylines.toString()}');
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
        //Future.delayed(Duration(seconds: 2), () {
        showSpinner = false;
        //});
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    //_getAnimalTracking(googleMapController);
    /*print('Animal id: ${widget.animalId}');
    print('Start Date Time: ${widget.startDateTime}');
    print('End Date Time: ${widget.endDateTime}');
    print('widget.animalTrackList: ${widget.animalTrackList}');*/
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
        progressIndicator: CircularProgressIndicator(
          backgroundColor: Colors.white,
          valueColor: AlwaysStoppedAnimation<Color>(kMainKupeColor),
        ),
        inAsyncCall: showSpinner,
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: GoogleMap(
                initialCameraPosition:
                    CameraPosition(target: _defaultTurkey, zoom: 7),
                mapType: MapType.normal,
                zoomControlsEnabled: false,
                myLocationEnabled: false,
                onMapCreated: _getAnimalTracking,
                polylines: Set<Polyline>.of(_polylines.values),
              ),
            ),
            Container(
              height: 30.0,
              color: kLoginLightDarkBackground,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.0),
                child: Row(
                  children: [
                    Text(
                      'KONUM',
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                    SizedBox(width: 28.0),
                    Text(
                      'ID',
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                    SizedBox(width: 40.0),
                    Text(
                      'TARİH',
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Theme(
                data: Theme.of(context).copyWith(accentColor: kMainKupeColor),
                child: ListView(
                  padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
                  children: [
                    for (int i = 0; i < widget.animalTrackList.length; i++)
                      Row(
                        children: [
                          Text(
                            '${widget.animalTrackList[i].lat.roundToDouble()}' +
                                ',' +
                                '${widget.animalTrackList[i].lng.roundToDouble()}',
                            style: TextStyle(
                                color: kLoginLightDarkBackground, fontSize: 13),
                          ),
                          SizedBox(width: 25.0),
                          Text(
                            widget.animalTrackList[i].animalId.toString(),
                            style: TextStyle(
                                color: kLoginLightDarkBackground, fontSize: 13),
                          ),
                          SizedBox(width: 25.0),
                          Text(
                            widget.animalTrackList[i].tarihBilgi.toString(),
                            style: TextStyle(
                                color: kLoginLightDarkBackground, fontSize: 13),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
