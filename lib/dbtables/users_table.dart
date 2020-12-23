import 'dart:convert';
import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

/*
//fetch the JSON data
Future<List<Users>> fetchUsers() async {
  final response = await http
      .get('https://www.aractakipsistemleri.com/canli3/Takip/GetAllUser');

  return compute(parseUsers, response.body);
}

List<Users> parseUsers(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Users>((json) => Users.fromJson(json)).toList();
}
*/
class Users {
  Users({
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

  factory Users.fromJson(Map<String, dynamic> json) => Users(
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
}
