import 'dart:convert';
import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<List<Users>> fetchUsers(http.Client client) async {
  final response = await client
      .get('https://www.aractakipsistemleri.com/canli3/Takip/GetAllUser');

  return compute(parseUsers, response.body);
}

List<Users> parseUsers(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Users>((json) => Users.fromJson(json)).toList();
}

class Users {
  Users({
    this.id,
    this.username,
    this.password,
    this.eMail,
  });

  int id;
  String username;
  String password;
  String eMail;

  factory Users.fromJson(Map<String, dynamic> json) => Users(
        id: json["id"],
        username: json["username"],
        password: json["password"],
        eMail: json["e_mail"],
      );
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Deneme JSON'),
      ),
      body: FutureBuilder<List<Users>>(
        future: fetchUsers(http.Client()),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);

          return snapshot.hasData
              ? UsersList(usersData: snapshot.data)
              : Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class UsersList extends StatelessWidget {
  final List<Users> usersData;

  const UsersList({Key key, this.usersData}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: usersData.length,
      itemBuilder: (context, index) {
        return Text(usersData[index].username);
      },
    );
  }
}
