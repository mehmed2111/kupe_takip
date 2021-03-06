import 'dart:convert';
import 'package:http/http.dart' as http;

class UserRegion {
  //https://www.aractakipsistemleri.com/canli3/Takip/GetMobileUserRegion?id=5
  String _url = 'https://www.aractakipsistemleri.com/canli3/Takip/';

  Future<List<UserRegion>> fetchUserRegion(int userID) async {
    final response = await http.get(_url + 'GetMobileUserRegion?id=$userID');
    var data = json.decode(response.body);

    if (response.statusCode == 200) {
      return (data as List).map((e) => UserRegion.fromJson(e)).toList();
    } else {
      throw Exception('Could not fetch user region');
    }
  }

  //https://www.aractakipsistemleri.com/canli3/Takip/InsertPolygon?user_id=5&rname=bolge_adi&region1=asdasdas
  addRegionToUser(int userID, String regionName, String polygonPoints) async {
    final response = await http.post(_url +
        'InsertPolygon?user_id=$userID&rname=$regionName&region1=$polygonPoints');
    var data = json.decode(response.body);

    if (response.statusCode == 200) {
      return data;
    } else {
      throw Exception('Could not add region to an user');
    }
  }

  //https://www.aractakipsistemleri.com/canli3/Takip/DeleteRegionName?id=8
  deleteRegionName(int regionId) async {
    final response = await http.post(_url + 'DeleteRegionName?id=$regionId');
    var data = json.decode(response.body);

    if (response.statusCode == 200) {
      return data;
    } else {
      throw Exception('Could not delete region name');
    }
  }

  int id;
  int userId;
  String rname;
  String region1;

  UserRegion({this.id, this.userId, this.rname, this.region1});

  UserRegion.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    rname = json['rname'];
    region1 = json['region1'];
  }
}
