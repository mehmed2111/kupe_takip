import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kupe/widgets/alert_dialog_messages.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:kupe/network/network_check.dart';
import 'package:kupe/dbtables/user_animal_table.dart';
import 'package:kupe/constants.dart';
import 'dostlarin.dart';

class DostlariniGuncelle extends StatefulWidget {
  DostlariniGuncelle() : super();
  final String title = 'Dostlarını Güncelle';
  static const String id = 'dostlarini_guncelle';

  @override
  _DostlariniGuncelleState createState() => _DostlariniGuncelleState();
}

class _DostlariniGuncelleState extends State<DostlariniGuncelle> {
  NetworkCheck _networkCheck = NetworkCheck();
  bool showSpinner = false;
  List<DropdownMenuItem<UserAnimals>> _dropdownMenuItems;
  UserAnimals _selectedAnimal;

  UserAnimals _userAnimals = UserAnimals();
  List<UserAnimals> _userAnimalList;

  //call fetchUserAnimals() function inside this function in order to prevent 'instance of Users' error
  void _getUserAnimals(int userId) async {
    var dataList = await _userAnimals.fetchUserAnimals(userId);
    _userAnimalList = dataList;

    setState(() {
      _dropdownMenuItems = buildDropdownMenuItems(_userAnimalList);
      _selectedAnimal = _dropdownMenuItems[0].value;
    });
  }

  @override
  void initState() {
    super.initState();
    _getUserAnimals(loggedUserID);
  }

  //Show all animals in a user on dropDownMenu by name
  List<DropdownMenuItem<UserAnimals>> buildDropdownMenuItems(
      List<UserAnimals> userAnimals) {
    List<DropdownMenuItem<UserAnimals>> items = List();
    for (UserAnimals animal in userAnimals) {
      items.add(
        DropdownMenuItem(
          value: animal,
          child: Text(animal.name),
        ),
      );
    }
    return items;
  }

  onChangedDropdownItem(UserAnimals selectedAnimal) {
    UserAnimals animal;
    setState(() {
      showSpinner = true;
    });
    try {
      _networkCheck.check().then((internet) {
        if (internet != null && internet) {
          if (_userAnimalList != null) {
            for (animal in _userAnimalList) {
              if (animalID == animal.id) {
                setState(() {
                  _selectedAnimal = selectedAnimal;

                  Navigator.of(context).push(
                    PageRouteBuilder(
                      opaque: false,
                      pageBuilder: (BuildContext context, _, __) {
                        return Dostlarin(
                          selectedAnimalId: _selectedAnimal.id,
                          name: _selectedAnimal.name,
                          gender: _selectedAnimal.gender == 0
                              ? 'Erkek'
                              : _selectedAnimal.gender == 1
                                  ? 'Dişi'
                                  : null,
                          color: _selectedAnimal.color,
                        );
                      },
                    ),
                  );
                });
              }
            }
          } else {
            showDialog(
              context: context,
              builder: (_) => CouldNotLoadData(),
            );
          }
        } else {
          //if there is no internet connection
          showDialog(
            context: context,
            builder: (_) => InternetError(),
          );
        }
      });
      setState(() {
        showSpinner = false;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kLoginDarkBackground,
      appBar: AppBar(
        backgroundColor: kMainKupeColor,
        title: Text('Dostlarını Güncelle'),
      ),
      body: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Text(
                    'Güncellemek istediğin dostunu seç',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.0)),
                  child: DropdownButton(
                    value: _selectedAnimal,
                    items: _dropdownMenuItems,
                    onChanged: onChangedDropdownItem,
                    icon: Icon(Icons.arrow_drop_down),
                    isExpanded: true,
                    iconSize: 37.0,
                    iconEnabledColor: kLoginDarkBackground,
                    underline: SizedBox(),
                    dropdownColor: Colors.white,
                    style:
                        TextStyle(color: kLoginDarkBackground, fontSize: 18.0),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
