import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:kupe/constants.dart';
import 'package:kupe/widgets/rounded_button.dart';

class BildirimDeneme extends StatefulWidget {
  static const String id = 'bildirim_deneme';
  @override
  _BildirimDenemeState createState() => _BildirimDenemeState();
}

class _BildirimDenemeState extends State<BildirimDeneme> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    var initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');
    var initializationSettingsIOS = IOSInitializationSettings();
    var initSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

    flutterLocalNotificationsPlugin.initialize(initSettings,
        onSelectNotification: onSelectNotification);
  }

  // ignore: missing_return
  Future onSelectNotification(String payload) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return MessageScreen(
        payload: payload,
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: kMainKupeColor,
        title: new Text('Bildirim Deneme'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RoundedButton(
                colour: kMainKupeColor,
                buttonTitle: 'BİLDİRİM GÖNDER',
                onPressed: showNotification),
          ],
        ),
      ),
    );
  }

  Future<void> cancelNotification() async {
    await flutterLocalNotificationsPlugin.cancel(0);
  }

  showNotification() async {
    var android = new AndroidNotificationDetails(
        'id', 'channel ', 'description',
        priority: Priority.high, importance: Importance.max);
    var iOS = new IOSNotificationDetails();
    var platform = new NotificationDetails(android: android, iOS: iOS);
    await flutterLocalNotificationsPlugin.show(
        0, 'Küpe Takip', 'Local bildirim deneme mesajıdır', platform,
        payload: 'Mesajın yönlendirildiği sayfa');
  }
}

class MessageScreen extends StatelessWidget {
  final String payload;

  MessageScreen({
    @required this.payload,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kMainKupeColor,
        title: Text(payload),
      ),
    );
  }
}
