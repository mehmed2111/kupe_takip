import 'package:flutter/material.dart';
import 'package:kupe/constants.dart';
import 'package:kupe/widgets/nav_menu.dart';
import 'package:kupe/screens/google_maps_page.dart';

class HomePage extends StatelessWidget {
  static const String id = 'home_page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      //navigation menu sayfasına git
      drawer: NavMenu(),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: kMainKupeColor,
        title: Image.asset('images/yazi_logo.png', fit: BoxFit.contain),
      ),
      //google maps sayfasına git
      body: GoogleMapsPage(),
    );
  }
}
