import 'package:google_maps_flutter/google_maps_flutter.dart';

class UserAnimals {
  //MarkerId markerId;

  int id;
  int userId;
  String name;
  double lat;
  double lng;
  int category;
  int gender;
  String color;

  UserAnimals(
      { //this.markerId,
      this.id,
      this.userId,
      this.name,
      this.lat,
      this.lng,
      this.category,
      this.gender,
      this.color});

  UserAnimals.fromJson(Map<String, dynamic> json) {
    //markerId = json['marker_id'];
    id = json['id'];
    userId = json['user_id'];
    name = json['name'];
    lat = json['lat'];
    lng = json['lng'];
    category = json['category'];
    gender = json['gender'];
    color = json['color'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['name'] = this.name;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['category'] = this.category;
    data['gender'] = this.gender;
    data['color'] = this.color;
    return data;
  }
}
