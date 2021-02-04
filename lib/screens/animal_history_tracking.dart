import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kupe/constants.dart';
import 'package:kupe/dbtables/user_animal_table.dart';
import 'package:kupe/network/network_check.dart';
import 'package:kupe/widgets/alert_dialog_messages.dart';
import 'package:kupe/widgets/kapat_button.dart';
import 'package:kupe/widgets/rounded_button.dart';
import 'package:kupe/dbtables/animal_tracking.dart';
import 'package:kupe/screens/animal_history_tracking_map.dart';

class AnimalHistoryTracking extends StatefulWidget {
  static const String id = 'animal_tracking';
  @override
  _AnimalHistoryTrackingState createState() => _AnimalHistoryTrackingState();
}

class _AnimalHistoryTrackingState extends State<AnimalHistoryTracking> {
  NetworkCheck _networkCheck = NetworkCheck();
  DateTime selectedStartDate = DateTime.now();
  DateTime selectedEndDate = DateTime.now();
  TimeOfDay selectedStartTime = TimeOfDay.now();
  TimeOfDay selectedEndTime = TimeOfDay.now();

  UserAnimals _userAnimals = UserAnimals();
  List<UserAnimals> _userAnimalsList;
  UserAnimals _selectedAnimal;
  List<DropdownMenuItem<UserAnimals>> _dropDownMenuItems;
  AnimalTracking getAnimalTracking = AnimalTracking();
  List<AnimalTracking> animalTrackList;

  String _startDateTime;
  String _endDateTime;

  void getUserAnimals(int userId) async {
    var data = await _userAnimals.fetchUserAnimals(userId);
    _userAnimalsList = data;

    setState(() {
      _dropDownMenuItems = buildDropdownMenuItems(_userAnimalsList);
      _selectedAnimal = _dropDownMenuItems[0].value;
    });
  }

  //Show all animal data by name
  List<DropdownMenuItem<UserAnimals>> buildDropdownMenuItems(
      List<UserAnimals> userAnimalsList) {
    List<DropdownMenuItem<UserAnimals>> items = List();
    for (UserAnimals animal in userAnimalsList) {
      items.add(
        DropdownMenuItem(
          value: animal,
          child: Text(animal.name),
        ),
      );
    }
    return items;
  }

  onChangedDropDownMenuItem(UserAnimals selectedAnimal) {
    setState(() {
      _selectedAnimal = selectedAnimal;
    });
  }

  //select start date on button pressed
  _selectStartDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      locale: const Locale("tr", "TR"),
      initialDate: selectedStartDate,
      firstDate: DateTime(2015),
      lastDate: DateTime(2032),
      helpText: 'Tarih seçin',
      cancelText: 'İptal',
      confirmText: 'Seç',
      fieldLabelText: 'Tarih Seç',
      fieldHintText: 'aa/gg/yyyy',
      errorFormatText: 'Tarih formatı yanlış',
      errorInvalidText: 'Geçerli tarih aralığı giriniz',
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: kMainKupeColor,
            accentColor: kMainKupeColor,
            colorScheme: ColorScheme.light(primary: kMainKupeColor),
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child,
        );
      },
    );
    if (picked != null && picked != selectedStartDate)
      setState(() {
        selectedStartDate = picked;
      });
  }

  //select start time on button pressed
  _selectStartTime(BuildContext context) async {
    final TimeOfDay startTime = await showTimePicker(
      context: context,
      initialTime: selectedStartTime,
      helpText: 'Saat seçin',
      cancelText: 'İptal',
      confirmText: 'Seç',
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: kMainKupeColor,
            accentColor: kMainKupeColor,
            colorScheme: ColorScheme.light(primary: kMainKupeColor),
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child,
        );
      },
    );
    if (startTime != null) {
      setState(() {
        selectedStartTime = startTime;
      });
    }
  }

  //select end date on button pressed
  _selectEndDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      locale: const Locale("tr", "TR"),
      initialDate: selectedEndDate,
      firstDate: DateTime(2015),
      lastDate: DateTime(2032),
      helpText: 'Tarih seçin',
      cancelText: 'İptal',
      confirmText: 'Seç',
      fieldLabelText: 'Tarih Seç',
      fieldHintText: 'aa/gg/yyyy',
      errorFormatText: 'Tarih formatı yanlış',
      errorInvalidText: 'Geçerli tarih aralığı giriniz',
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: kMainKupeColor,
            accentColor: kMainKupeColor,
            colorScheme: ColorScheme.light(primary: kMainKupeColor),
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child,
        );
      },
    );
    if (picked != null && picked != selectedEndDate)
      setState(() {
        selectedEndDate = picked;
      });
  }

  //select end time on button pressed
  _selectEndTime(BuildContext context) async {
    final TimeOfDay entTime = await showTimePicker(
      context: context,
      initialTime: selectedEndTime,
      helpText: 'Saat seçin',
      cancelText: 'İptal',
      confirmText: 'Seç',
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: kMainKupeColor,
            accentColor: kMainKupeColor,
            colorScheme: ColorScheme.light(primary: kMainKupeColor),
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child,
        );
      },
    );
    if (entTime != null) {
      setState(() {
        selectedEndTime = entTime;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getUserAnimals(loggedUserID);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.25),
      body: Dialog(
        insetPadding: EdgeInsets.symmetric(horizontal: 10.0),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        child: Container(
          height: 470,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.slideshow,
                      color: kLoginLightDarkBackground, size: 30),
                  SizedBox(width: 10.0),
                  Text(
                    'Geçmiş İzleme',
                    style:
                        TextStyle(color: kLoginDarkBackground, fontSize: 25.0),
                  ),
                ],
              ),
              SizedBox(height: 10.0),
              Expanded(
                child: Theme(
                  data: Theme.of(context).copyWith(accentColor: kMainKupeColor),
                  child: ListView(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                    children: [
                      //start date
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 17.0),
                        child: Text(
                          'Başlangıç Tarihi/Saati:',
                          style: TextStyle(
                            color: kLoginDarkBackground,
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Container(
                              height: 48.0,
                              child: RaisedButton(
                                color: Colors.white,
                                child: Stack(
                                  children: [
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: Icon(
                                        Icons.calendar_today,
                                        color: kLoginDarkBackground,
                                        size: 20,
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        '${selectedStartDate.toLocal()}'
                                            .split(' ')[0],
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: kLoginDarkBackground),
                                      ),
                                    ),
                                  ],
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(32.0),
                                  side: BorderSide(
                                    width: 1.0,
                                    color: kMainKupeColor,
                                  ),
                                ),
                                onPressed: () => _selectStartDate(context),
                              ),
                            ),
                          ),
                          SizedBox(width: 10.0),
                          Expanded(
                            flex: 1,
                            child: Container(
                              height: 48.0,
                              child: RaisedButton(
                                color: Colors.white,
                                child: Stack(
                                  children: [
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: Icon(
                                        Icons.watch_later_outlined,
                                        color: kLoginDarkBackground,
                                        size: 20,
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        '${selectedStartTime.format(context)}'
                                            .split(' ')[0],
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: kLoginDarkBackground),
                                      ),
                                    ),
                                  ],
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(32.0),
                                  side: BorderSide(
                                    width: 1.0,
                                    color: kMainKupeColor,
                                  ),
                                ),
                                onPressed: () => _selectStartTime(context),
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 10.0),
                      //end date
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 17.0),
                        child: Text(
                          'Bitiş Tarihi/Saati:',
                          style: TextStyle(
                            color: kLoginDarkBackground,
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Container(
                              height: 48.0,
                              child: RaisedButton(
                                  color: Colors.white,
                                  child: Stack(
                                    children: [
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: Icon(
                                          Icons.calendar_today,
                                          color: kLoginDarkBackground,
                                          size: 20,
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          '${selectedEndDate.toLocal()}'
                                              .split(' ')[0],
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: kLoginDarkBackground),
                                        ),
                                      ),
                                    ],
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(32.0),
                                    side: BorderSide(
                                      width: 1.0,
                                      color: kMainKupeColor,
                                    ),
                                  ),
                                  onPressed: () => _selectEndDate(context)),
                            ),
                          ),
                          SizedBox(width: 10.0),
                          Expanded(
                            flex: 1,
                            child: Container(
                              height: 48.0,
                              child: RaisedButton(
                                color: Colors.white,
                                child: Stack(
                                  children: [
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: Icon(
                                        Icons.watch_later_outlined,
                                        color: kLoginDarkBackground,
                                        size: 20,
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        '${selectedEndTime.format(context)}'
                                            .split(' ')[0],
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: kLoginDarkBackground),
                                      ),
                                    ),
                                  ],
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(32.0),
                                  side: BorderSide(
                                    width: 1.0,
                                    color: kMainKupeColor,
                                  ),
                                ),
                                onPressed: () => _selectEndTime(context),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10.0),
                      //choose animal
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 17.0),
                        child: Text(
                          'Dostunu Seç',
                          style: TextStyle(
                            color: kLoginDarkBackground,
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Container(
                        height: 48.0,
                        padding: EdgeInsets.symmetric(horizontal: 15.0),
                        decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(width: 1.0, color: kMainKupeColor),
                            borderRadius: BorderRadius.circular(32.0),
                          ),
                        ),
                        child: DropdownButton(
                          value: _selectedAnimal,
                          items: _dropDownMenuItems,
                          onChanged: onChangedDropDownMenuItem,
                          icon: Icon(Icons.arrow_drop_down,
                              color: kLoginDarkBackground),
                          isExpanded: true,
                          iconSize: 30.0,
                          iconEnabledColor: kLoginDarkBackground,
                          underline: SizedBox(),
                          dropdownColor: Colors.white,
                          style: TextStyle(
                              color: kLoginDarkBackground, fontSize: 18.0),
                        ),
                      ),
                      SizedBox(height: 20.0),
                      //show on map
                      RoundedButton(
                        colour: kMainKupeColor,
                        buttonTitle: 'Haritada Göster',
                        onPressed: () {
                          _startDateTime =
                              '${selectedStartDate.toLocal()}'.split(' ')[0] +
                                  ' ' +
                                  '${selectedStartTime.format(context)}'
                                      .split(' ')[0];
                          _endDateTime =
                              '${selectedEndDate.toLocal()}'.split(' ')[0] +
                                  ' ' +
                                  '${selectedEndTime.format(context)}'
                                      .split(' ')[0];

                          _networkCheck.check().then((internet) async {
                            if (internet != null && internet) {
                              var data =
                                  await getAnimalTracking.fetchAnimalTrack(
                                _selectedAnimal.id,
                                _startDateTime,
                                _endDateTime,
                              );
                              //assign fetched data from json to animalTrackList
                              animalTrackList = data;

                              if (animalTrackList.length != 0 &&
                                  animalTrackList.length > 1) {
                                //push parameters to the chosen page
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        AnimalHistoryTrackingMap(
                                      animalTrackList: animalTrackList,
                                      animalId: _selectedAnimal.id,
                                      startDateTime: _startDateTime,
                                      endDateTime: _endDateTime,
                                    ),
                                  ),
                                );
                              } else {
                                showDialog(
                                  context: context,
                                  builder: (_) => DateTimeNotMatched(),
                                );
                              }
                            } else {
                              showDialog(
                                context: context,
                                builder: (_) => InternetError(),
                              );
                            }
                          });
                        },
                      ),
                      SizedBox(height: 10.0),
                    ],
                  ),
                ),
              ),
              //SizedBox(height: 10.0),
              KapatButton(onPressed: () {
                Navigator.pop(context);
              }),
            ],
          ),
        ),
      ),
    );
  }
}
