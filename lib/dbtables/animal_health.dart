import 'dart:convert';
import 'package:http/http.dart' as http;

class AnimalHealth {
  //https://www.aractakipsistemleri.com/canli3/Takip/GetSelectedHealth?animal_id=10
  String _url = 'https://www.aractakipsistemleri.com/canli3/Takip/';

  Future<List<AnimalHealth>> fetchAnimalHealth(int id) async {
    final response = await http.post(_url + 'GetSelectedHealth?animal_id=$id');

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

  AnimalHealth.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    animalId = json['animal_id'];
    parazitler = json['parazitler'];
    karma = json['karma'];
    kuduz = json['kuduz'];
    mantar = json['mantar'];
    lyme = json['lyme'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['animal_id'] = this.animalId;
    data['parazitler'] = this.parazitler;
    data['karma'] = this.karma;
    data['kuduz'] = this.kuduz;
    data['mantar'] = this.mantar;
    data['lyme'] = this.lyme;
    return data;
  }
}
