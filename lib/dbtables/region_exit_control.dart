import 'dart:convert';
import 'package:http/http.dart' as http;

class RegionExitControl {
  //https://www.aractakipsistemleri.com/canli3/Takip/PolygonCheck?animal_id=17
  String _url = 'https://www.aractakipsistemleri.com/canli3/Takip/';

  Future<List<RegionExitControl>> regionCheck(int animalId) async {
    final response = await http.get(_url + 'PolygonCheck?animal_id=$animalId');

    var data = json.decode(response.body);
    if (response.statusCode == 200) {
      return (data as List).map((e) => RegionExitControl.fromJson(e)).toList();
    } else {
      throw Exception('Could not load region data');
    }
  }

  int id;
  int animalId;
  String komut;

  RegionExitControl({this.id, this.animalId, this.komut});

  RegionExitControl.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    animalId = json['animal_id'];
    komut = json['komut'];
  }
}
