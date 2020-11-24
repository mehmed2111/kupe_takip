import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kupe/screens/login_page.dart';

class NavMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Color(0xFF1d2136),
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  'Dostunu takip et..',
                  style: TextStyle(
                    color: Color(0xFF1d2136),
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('images/logo.jpg'),
                ),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.supervised_user_circle,
                color: Colors.white,
              ),
              title: Text(
                'Kullanıcı Profili',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              onTap: () => {Navigator.of(context).pop()},
            ),
            ListTile(
              leading:
                  Icon(Icons.medical_services_outlined, color: Colors.white),
              title: Text(
                'Sağlık Takip',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              onTap: () => {Navigator.of(context).pop()},
            ),
            ListTile(
              leading: Icon(Icons.mobile_friendly, color: Colors.white),
              title: Text(
                'Dostların',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              onTap: () => {Navigator.of(context).pop()},
            ),
            ListTile(
              leading: Icon(Icons.refresh_outlined, color: Colors.white),
              title: Text(
                'Yenile',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              onTap: () => {Navigator.of(context).pop()},
            ),
            ListTile(
              leading: Icon(Icons.settings, color: Colors.white),
              title: Text(
                'Ayarlar',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              onTap: () => {Navigator.of(context).pop()},
            ),
            ListTile(
              leading: Icon(Icons.logout, color: Colors.white),
              title: Text(
                'Çıkış',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              onTap: () => {Navigator.pushNamed(context, LoginPage.id)},
            ),
          ],
        ),
      ),
    );
  }
}
