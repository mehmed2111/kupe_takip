import 'package:flutter/material.dart';
import 'package:kupe/constants.dart';
import 'package:kupe/dbtables/animal_data.dart';
import 'package:kupe/dbtables/user_animal_table.dart';
import 'package:kupe/network/network_check.dart';
import 'package:kupe/widgets/alert_dialog_messages.dart';
import 'package:kupe/widgets/saglik_takip_widget.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class SaglikTakip extends StatefulWidget {
  SaglikTakip() : super();
  final String title = 'Sağlık Takip';
  static const String id = 'saglik_takip';

  @override
  _SaglikTakipState createState() => _SaglikTakipState();
}

class _SaglikTakipState extends State<SaglikTakip> {
  NetworkCheck _networkCheck = NetworkCheck();
  bool showSpinner = false;
  List<DropdownMenuItem<UserAnimals>> _dropdownMenuItems;
  UserAnimals _selectedAnimal;

  UserAnimals _userAnimals = UserAnimals();
  List<UserAnimals> _userAnimalList;
  AnimalData _animalData = AnimalData();
  List<AnimalData> _animalDataList;

  //call fetchAnimalHealth() function inside this function in order to prevent 'instance of Users' error
  void _getAnimalData(int animalId) async {
    var animalData = await _animalData.fetchAnimalData(animalId);
    _animalDataList = animalData;
  }

  //call fetchUserAnimals() function inside this function in order to prevent 'instance of Users' error
  void _getUserAnimals(int userId) async {
    var dataList = await _userAnimals.fetchUserAnimals(userId);
    _userAnimalList = dataList;

    var animalId = Iterable<int>.generate(_userAnimalList.length).toList();
    print('animal id lenght: $animalId');
    setState(() {
      _dropdownMenuItems = buildDropdownMenuItems(_userAnimalList);
      _selectedAnimal = _dropdownMenuItems[0].value;

      for (int i = 0; i < _userAnimalList.length; i++) {
        if (loggedUserID == _userAnimalList[i].userId) {
          animalId[i] = _userAnimalList[i].id;
          print('animal ids: ${animalId[i]}');
          _getAnimalData(animalId[i]);
        }
      }
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
    AnimalData animalData;
    int id;
    setState(() {
      id = 0;
      showSpinner = true;
      _selectedAnimal = selectedAnimal;
      id = _selectedAnimal.id;
      print('selectedAnimal dan gelen id: $id');
      _getAnimalData(id);
    });
    try {
      _networkCheck.check().then((internet) {
        if (internet != null && internet) {
          if (_animalDataList != null) {
            for (int i = 0; i < _animalDataList.length; i++) {
              print('animal data dan gelen id: ${_animalDataList[i].id}');
              if (id == _animalDataList[i].id) {
                //id = 0;
                setState(() {
                  Navigator.of(context).push(PageRouteBuilder(
                      opaque: false,
                      pageBuilder: (BuildContext context, _, __) {
                        return SaglikTakipWidget(
                          hayvanID: _animalDataList[i].id,
                          name: _animalDataList[i].name,
                          parazitler: _animalDataList[i].parazitler,
                          karma: _animalDataList[i].karma,
                          kuduz: _animalDataList[i].kuduz,
                          mantar: _animalDataList[i].mantar,
                          lyme: _animalDataList[i].lyme,
                        );
                      }));
                });
              } else {
                showDialog(
                  context: context,
                  builder: (_) => DateTimeNotMatched(),
                );
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
        title: Text('Sağlık Takibi'),
      ),
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20.0),
              Text(
                'Dostunu seç',
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
              SizedBox(height: 20.0),
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
                  style: TextStyle(color: kLoginDarkBackground, fontSize: 18.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
