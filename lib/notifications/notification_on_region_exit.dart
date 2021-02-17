import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:kupe/constants.dart';
import 'package:kupe/dbtables/region_exit_control.dart';
import 'package:workmanager/workmanager.dart';

RegionExitControl _regionExitControl = RegionExitControl();
List<RegionExitControl> regionExitList;

void callbackDispatcher() {
  FlutterLocalNotificationsPlugin flp = FlutterLocalNotificationsPlugin();
  Workmanager.executeTask((task, inputData) async {
    var initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');
    var initializationSettingsIOS = IOSInitializationSettings();
    var initSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    flp.initialize(initSettings, onSelectNotification: onSelectNotification);

    //fetch region control from json
    var response = await _regionExitControl.regionCheck(17);
    regionExitList = response;

    print("here================");
    print(regionExitList);

    //show notification
    //showNotification(flp);
    if (regionExitList[0].komut == regionExitList[1].komut) {
      print('İhlal yok');
      var android = new AndroidNotificationDetails(
          'id', 'channel ', 'description',
          priority: Priority.high, importance: Importance.max);
      var iOS = new IOSNotificationDetails();
      var platform = new NotificationDetails(android: android, iOS: iOS);
      await flp.show(
          0, 'Küpe Takip', 'Dostunuz bölgeyi ihlal etmedi.', platform,
          payload: 'Bildirimler');
    }
    if (regionExitList[0].komut == 'BA' && regionExitList[1].komut == 'AB') {
      print('İhlal var');
      var android = new AndroidNotificationDetails(
          'id', 'channel ', 'description',
          priority: Priority.high, importance: Importance.max);
      var iOS = new IOSNotificationDetails();
      var platform = new NotificationDetails(android: android, iOS: iOS);
      await flp.show(0, 'Küpe Takip', 'Dostunuz bölgeyi ihlal etti.', platform,
          payload: 'Bildirimler');
    }

    /*var convert = json.decode(response.body);
      if (convert['status'] == true) {
        showNotification(convert['msg'], flutterLocalNotificationsPlugin);
      } else {
        print("no messgae");
      }*/

    return Future.value(true);
  });
}

Future<void> cancelNotification(flp) async {
  await flp.cancel(0);
}

/*
void showNotification(flp) async {
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
    await flp.show(0, 'Küpe Takip', 'Dostunuz bölgeyi ihlal etti.', platform,
        payload: 'Mesajın yönlendirildiği sayfa');
  }
}
*/

BuildContext context;
Future onSelectNotification(String payload) {
  return Navigator.of(context).push(
    MaterialPageRoute(
      builder: (_) {
        return MessageScreen(payload: payload);
      },
    ),
  );
}

class NotificationOnRegionExit extends StatelessWidget {
  static const String id = 'notification_region_exit';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kMainKupeColor,
        title: Text('Bildirimler'),
      ),
      body: Center(
        child: ListView(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
          children: [
            //for (int i = 0; i < regionExitList.length; i++)
            //Text(regionExitList[i].komut),
          ],
        ),
      ),
    );
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
      body: NotificationOnRegionExit(),
    );
  }
}
