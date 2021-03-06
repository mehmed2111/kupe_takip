import 'dart:convert';
import 'package:http/http.dart' as http;

class UserAnimals {
  //https://www.aractakipsistemleri.com/canli3/Takip/GetSelectedAnimal?user_id=5
  //https://www.aractakipsistemleri.com/canli3/Takip/UpdateAnimal?id=10&name=hayvan10&color=Beyaz&gender=0
  String _url = 'https://www.aractakipsistemleri.com/canli3/Takip/';

  Future<List<UserAnimals>> fetchUserAnimals(int userId) async {
    final response = await http.get(_url + 'GetSelectedAnimal?user_id=$userId');
    var data = json.decode(response.body);

    if (response.statusCode == 200) {
      return (data as List).map((e) => UserAnimals.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load user animals');
    }
  }

  updateUserAnimal(int animalId, String animalName, String animalColor,
      int animalGender) async {
    final http.Response response = await http.post(
        _url +
            'UpdateAnimal?id=$animalId&name=$animalName&color=$animalColor&gender=$animalGender',
        body: jsonEncode(<String, String>{
          'id': '$animalId',
          'name': animalName,
          'color': animalColor,
          'gender': '$animalGender',
        }));

    var data = json.decode(response.body);
    if (response.statusCode == 200) {
      return data;
    } else {
      throw Exception('Failed to load user animal update json');
    }
  }

  int id;
  int userId;
  String name;
  double lat;
  double lng;
  int category;
  int gender;
  String color;

  UserAnimals(
      {this.id,
      this.userId,
      this.name,
      this.lat,
      this.lng,
      this.category,
      this.gender,
      this.color});

  UserAnimals.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    name = json['name'];
    lat = json['lat'];
    lng = json['lng'];
    category = json['category'];
    gender = json['gender'];
    color = json['color'];
  }
}
