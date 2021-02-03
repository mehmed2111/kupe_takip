import 'dart:convert';

import 'package:http/http.dart' as http;

class AnimalTracking {
  //https://www.aractakipsistemleri.com/canli3/Takip/GetAllTracking?animal_id=1014
  String _url = 'https://www.aractakipsistemleri.com/canli3/Takip/';

  Future<List<AnimalTracking>> fetchAnimalTrack(int animalId) async {
    final response =
        await http.get(_url + 'GetAllTracking?animal_id=$animalId');

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
  String tarih;

  AnimalTracking({this.id, this.animalId, this.lat, this.lng, this.tarih});

  AnimalTracking.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    animalId = json['animal_id'];
    lat = json['lat'];
    lng = json['lng'];
    tarih = json['tarih'];
  }
}
