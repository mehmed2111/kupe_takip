import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:kupe/constants.dart';
import 'package:kupe/dbtables/region_exit_control.dart';
import 'package:kupe/widgets/rounded_button.dart';

class BildirimDeneme extends StatefulWidget {
  static const String id = 'bildirim_deneme';

  final List<RegionExitControl> regionExitList;
  BildirimDeneme({this.regionExitList});

  @override
  _BildirimDenemeState createState() => _BildirimDenemeState();
}

class _BildirimDenemeState extends State<BildirimDeneme> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  RegionExitControl _regionExitControl = RegionExitControl();
  List<RegionExitControl> regionExitList;
  Timer _timer;

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

    _timer = Timer.periodic(Duration(seconds: 20), (Timer t) => _exitCheck(17));
    print('Bildirimler sayfasında: $regionExitList');
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _exitCheck(int animalId) async {
    var data = await _regionExitControl.regionCheck(animalId);
    regionExitList = data;
  }

  Future onSelectNotification(String payload) {
    return Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) {
          return MessageScreen(
            payload: payload,
          );
        },
      ),
    );
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
              buttonTitle: 'Bildirim Gönder',
              onPressed: showNotification,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> cancelNotification() async {
    await flutterLocalNotificationsPlugin.cancel(0);
  }

  showNotification() async {
    if (regionExitList[0].komut == regionExitList[1].komut) {
      print('İhlal yok');
    }
    if (regionExitList[0].komut == 'BA' && regionExitList[1].komut == 'AB') {
      //print('İhlal var');
      var android = new AndroidNotificationDetails(
          'id', 'channel ', 'description',
          priority: Priority.high, importance: Importance.max);
      var iOS = new IOSNotificationDetails();
      var platform = new NotificationDetails(android: android, iOS: iOS);
      await flutterLocalNotificationsPlugin.show(
          0, 'Küpe Takip', 'Dostunuz bölgeyi ihlal etti.', platform,
          payload: 'Mesajın yönlendirildiği sayfa');
    }
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
