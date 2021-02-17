import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:kupe/constants.dart';
import 'package:kupe/dbtables/region_exit_control.dart';
import 'package:kupe/widgets/rounded_button.dart';
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
    flp.initialize(
        initSettings /*, onSelectNotification: onSelectNotification*/);

    //fetch region control from json
    var response = await _regionExitControl.regionCheck(17);
    regionExitList = response;
    print("here================");
    print(regionExitList);

    //show notification
    //showNotification(flp);
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
class BildirimDeneme extends StatefulWidget {
  static const String id = 'bildirim_deneme';

  final List<RegionExitControl> regionExitList;
  BildirimDeneme({this.regionExitList});

  @override
  _BildirimDenemeState createState() => _BildirimDenemeState();
}

class _BildirimDenemeState extends State<BildirimDeneme> {
  /* RegionExitControl _regionExitControl = RegionExitControl();
  List<RegionExitControl> regionExitList;
  Timer _timer;*/

  /* void _exitCheck(int animalId) async {
    var data = await _regionExitControl.regionCheck(animalId);
    regionExitList = data;
  }*/

  @override
  void initState() {
    super.initState();
    /*var initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');
    var initializationSettingsIOS = IOSInitializationSettings();
    var initSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

    flutterLocalNotificationsPlugin.initialize(initSettings,
        onSelectNotification: onSelectNotification);*/

    //_timer = Timer.periodic(Duration(seconds: 20), (Timer t) => _exitCheck(17));
    //print('Bildirimler sayfasında: $regionExitList');
  }

  @override
  void dispose() {
    //_timer?.cancel();
    super.dispose();
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
            /*RoundedButton(
              colour: kMainKupeColor,
              buttonTitle: 'Bildirim Gönder',
              onPressed: showNotification,
            ),*/
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
    );
  }
}
