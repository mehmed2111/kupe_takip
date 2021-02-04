import 'dart:convert';
import 'package:http/http.dart' as http;

class AnimalTracking {
  //https://www.aractakipsistemleri.com/canli3/Takip/HistoryTracking?animal_id=1014&startTime=2020-01-01%2012:00:00&finishTime=2020-01-01%2012:30:00
  String _url = 'https://www.aractakipsistemleri.com/canli3/Takip/';

  Future<List<AnimalTracking>> fetchAnimalTrack(
      int animalId, String startDateTime, String endDateTime) async {
    final response = await http.get(_url +
        'HistoryTracking?animal_id=$animalId&startTime=$startDateTime&finishTime=$endDateTime');

    var data = json.decode(response.body);
    if (response.statusCode == 200) {
      return (data as List).map((e) => AnimalTracking.fromJson(e)).toList();
    } else {
      throw Exception('Could not load animal track');
    }
  }

  int id;
  int animalId;
  double lat;
  double lng;
  String tarihBilgi;

  AnimalTracking({this.id, this.animalId, this.lat, this.lng, this.tarihBilgi});

  AnimalTracking.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    animalId = json['animal_id'];
    lat = json['lat'];
    lng = json['lng'];
    tarihBilgi = json['tarihBilgi'];
  }
}
