import 'dart:convert';
import 'package:http/http.dart' as http;

class AnimalData {
  //https://www.aractakipsistemleri.com/canli3/Takip/GetAnimalEveryData?animal_id=6
  //https://www.aractakipsistemleri.com/canli3/Takip/GetAnimalEveryData?animal_id=10
  String _url = 'https://www.aractakipsistemleri.com/canli3/Takip/';

  Future<List<AnimalData>> fetchAnimalData(int animalId) async {
    final response =
        await http.get(_url + 'GetAnimalEveryData?animal_id=$animalId');

    var data = json.decode(response.body);
    if (response.statusCode == 200) {
      return (data as List).map((e) => AnimalData.fromJson(e)).toList();
    } else {
      throw Exception('Could not load animal data');
    }
  }

  int id;
  String name;
  int category;
  int gender;
  String color;
  double lat;
  double lng;
  String konumTarih;
  String parazitler;
  String karma;
  String kuduz;
  String mantar;
  String lyme;

  AnimalData(
      {this.id,
      this.name,
      this.category,
      this.gender,
      this.color,
      this.lat,
      this.lng,
      this.konumTarih,
      this.parazitler,
      this.karma,
      this.kuduz,
      this.mantar,
      this.lyme});

  AnimalData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    category = json['category'];
    gender = json['gender'];
    color = json['color'];
    lat = json['lat'];
    lng = json['lng'];
    konumTarih = json['konumTarih'];
    parazitler = json['parazitler'];
    karma = json['karma'];
    kuduz = json['kuduz'];
    mantar = json['mantar'];
    lyme = json['lyme'];
  }
}
