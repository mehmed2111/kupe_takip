import 'dart:convert';
import 'package:http/http.dart' as http;

class AnimalHealth {
  //https://www.aractakipsistemleri.com/canli3/Takip/GetSelectedHealth?animal_id=10
  String _url = 'https://www.aractakipsistemleri.com/canli3/Takip/';

  Future<List<AnimalHealth>> fetchAnimalHealth(int animalId) async {
    final response =
        await http.get(_url + 'GetSelectedHealth?animal_id=$animalId');

    var data = json.decode(response.body);
    if (response.statusCode == 200) {
      return (data as List).map((e) => AnimalHealth.fromJson(e)).toList();
    } else {
      throw Exception('Could not load animal health');
    }
  }

  int id;
  int animalId;
  String parazitler;
  String karma;
  String kuduz;
  String mantar;
  String lyme;

  AnimalHealth(
      {this.id,
      this.animalId,
      this.parazitler,
      this.karma,
      this.kuduz,
      this.mantar,
      this.lyme});

  factory AnimalHealth.fromJson(Map<String, dynamic> json) => AnimalHealth(
        id: json["id"],
        animalId: json["animal_id"],
        parazitler: json["parazitler"],
        karma: json["karma"],
        kuduz: json["kuduz"],
        mantar: json["mantar"],
        lyme: json["lyme"],
      );
}
