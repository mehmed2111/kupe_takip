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
  String color;
  int gender;
  int category;
  double lat;
  double lng;
  String tarih;
  String parazitler;
  String karma;
  String kuduz;
  String mantar;
  String lyme;

  AnimalData(
      {this.id,
      this.name,
      this.color,
      this.gender,
      this.category,
      this.lat,
      this.lng,
      this.tarih,
      this.parazitler,
      this.karma,
      this.kuduz,
      this.mantar,
      this.lyme});

  AnimalData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    color = json['color'];
    gender = json['gender'];
    category = json['category'];
    lat = json['lat'];
    lng = json['lng'];
    tarih = json['tarih'];
    parazitler = json['parazitler'];
    karma = json['karma'];
    kuduz = json['kuduz'];
    mantar = json['mantar'];
    lyme = json['lyme'];
  }
}
