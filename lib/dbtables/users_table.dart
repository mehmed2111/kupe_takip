import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kupe/constants.dart';

class User {
  //URL for json to fetch data from DB
  String _url = 'https://www.aractakipsistemleri.com/canli3/Takip/';
  //Map<String, String> headers = {};

  Future<List<User>> fetchLoginUser(String username, String password) async {
    final response = await http
        .post(_url + 'MobileLogin?username=$username&password=$password');
    var data = json.decode(response.body);

    if (response.statusCode == 200) {
      return (data as List).map((e) => User.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load user');
    }
  }

  Future<List<User>> fetchUserProfile(int id) async {
    final response = await http.post(_url + 'GetSelectedUser?user_id=$id');

    var data = json.decode(response.body);
    if (response.statusCode == 200) {
      return (data as List).map((e) => User.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load user data');
    }
  }

  Future<List<User>> updateUserPassword(String password) async {
    //Map<String, String> headers = {};
    //headers['user_cookie'] = "$loggedUserID";
    final http.Response response = await http.post(_url + "UpdatePassword",
        body: jsonEncode(
            <String, String>{'id': "$loggedUserID", 'password': password}));

    var data = json.decode(response.body);
    if (response.statusCode == 200) {
      return (data as List).map((e) => User.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load password update');
    }
  }

  Future<List<User>> updateUserProfile(
      String email, String telNo, String address, String veteriner) async {
    //Map<String, String> headers = {};
    //headers['user_cookie'] = "$loggedUserID";
    final http.Response response = await http.post(_url + "UpdateUser",
        body: jsonEncode(<String, String>{
          'id': "$loggedUserID",
          'eMail': email,
          'telno': telNo,
          'adress': address,
          'veteriner': veteriner
        }));

    var data = json.decode(response.body);
    if (response.statusCode == 200) {
      return (data as List).map((e) => User.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load profile update');
    }
  }

  User({
    this.id,
    this.username,
    this.password,
    this.eMail,
    this.adress,
    this.telno,
    this.veteriner,
    this.regionAlarm,
    this.heatAlarm,
    this.sifre2,
  });

  int id;
  String username;
  String password;
  String eMail;
  String adress;
  String telno;
  String veteriner;
  int regionAlarm;
  int heatAlarm;
  String sifre2;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        username: json["username"],
        password: json["password"],
        eMail: json["e_mail"],
        adress: json["adress"],
        telno: json["telno"],
        veteriner: json["veteriner"],
        regionAlarm: json["region_alarm"],
        heatAlarm: json["heat_alarm"],
        sifre2: json["sifre2"],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['password'] = this.password;
    data['e_mail'] = this.eMail;
    data['adress'] = this.adress;
    data['telno'] = this.telno;
    data['veteriner'] = this.veteriner;
    data['region_alarm'] = this.regionAlarm;
    data['heat_alarm'] = this.heatAlarm;
    data['sifre2'] = this.sifre2;
    return data;
  }
}

/*
  //post data to json
  postUsers(Users users) async {
    var bodyValue = users.toJson();

    var bodyData = json.encode(bodyValue);
    print('Body data burada: $bodyData');

    final response = await http.post(_url, body: bodyData);

    print('Status kod burada: ${response.statusCode}');
    print('Response body burada: ${response.body}');
    return response;
  }*/
