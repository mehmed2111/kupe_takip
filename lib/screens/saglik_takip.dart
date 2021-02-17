import 'package:flutter/material.dart';
import 'package:kupe/constants.dart';
import 'package:kupe/dbtables/animal_data.dart';
import 'package:kupe/dbtables/user_animal_table.dart';
import 'package:kupe/network/network_check.dart';
import 'package:kupe/widgets/alert_dialog_messages.dart';
import 'package:kupe/screens/saglik_takip_pop_up.dart';
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
  //drop down menu
  List<DropdownMenuItem<UserAnimals>> _dropdownMenuItems;
  UserAnimals _selectedAnimal;
  //animals in a user
  UserAnimals _userAnimals = UserAnimals();
  List<UserAnimals> _userAnimalList;
  //all animal data
  AnimalData _getAnimalData = AnimalData();
  List<AnimalData> _animalDataList;
  AnimalData _animalData;

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
      if (userAnimals != null) {
        items.add(
          DropdownMenuItem(
            value: animal,
            child: Text(animal.name),
          ),
        );
      } else {
        showDialog(
          context: context,
          builder: (_) => CouldNotLoadData(),
        );
      }
    }
    return items;
  }

  onChangedDropdownItem(UserAnimals selectedAnimal) async {
    var data = await _getAnimalData.fetchAnimalData(selectedAnimal.id);
    _animalDataList = data;

    setState(() {
      showSpinner = true;
      //print('selectedAnimal dan gelen id: ${selectedAnimal.id}');
    });
    try {
      _networkCheck.check().then((internet) {
        if (internet != null && internet) {
          if (_animalDataList != null) {
            for (_animalData in _animalDataList) {
              //print('animal data dan gelen id: ${_animalData.id}');
              if (selectedAnimal.id == _animalData.id) {
                setState(() {
                  Navigator.of(context).push(PageRouteBuilder(
                      opaque: false,
                      pageBuilder: (BuildContext context, _, __) {
                        return SaglikTakipPopUp(
                          hayvanID: _animalData.id,
                          name: _animalData.name,
                          parazitler: _animalData.parazitler,
                          karma: _animalData.karma,
                          kuduz: _animalData.kuduz,
                          mantar: _animalData.mantar,
                          lyme: _animalData.lyme,
                        );
                      }));
                });
              } else {
                showDialog(
                  context: context,
                  builder: (_) => AnimalIdDoesNotMatched(),
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
                  borderRadius: BorderRadius.circular(20.0),
                ),
                /* height: 60.0,
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(width: 1.0, color: kMainKupeColor),
                    borderRadius: BorderRadius.circular(32.0),
                  ),
                ),*/
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
