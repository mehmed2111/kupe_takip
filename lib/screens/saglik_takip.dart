import 'package:flutter/material.dart';
import 'package:kupe/constants.dart';
import 'package:kupe/dbtables/animal_health.dart';
import 'package:kupe/dbtables/user_animal_table.dart';
import 'package:kupe/widgets/alert_dialog_widget.dart';
import 'package:kupe/widgets/saglik_takip_widget.dart';

class SaglikTakip extends StatefulWidget {
  SaglikTakip() : super();
  final String title = 'Sağlık Takip';

  static const String id = 'saglik_takip';

  @override
  _SaglikTakipState createState() => _SaglikTakipState();
}

class _SaglikTakipState extends State<SaglikTakip> {
  List<DropdownMenuItem<UserAnimals>> _dropdownMenuItems;
  UserAnimals _selectedAnimal;

  AnimalHealth _animalHealth = AnimalHealth();
  List<AnimalHealth> animalHealthList;

  UserAnimals _userAnimals = UserAnimals();
  List<UserAnimals> _userAnimalList;

  //call fetchAnimalHealth() function inside this function in order to prevent 'instance of Users' error
  void _getAnimalHealth(int animalId) async {
    var animalData = await _animalHealth.fetchAnimalHealth(animalId);
    animalHealthList = animalData;
  }

  //call fetchUserAnimals() function inside this function in order to prevent 'instance of Users' error
  void _getUserAnimals(int userId) async {
    var dataList = await _userAnimals.fetchUserAnimals(userId);
    _userAnimalList = dataList;

    setState(() {
      _dropdownMenuItems = buildDropdownMenuItems(_userAnimalList);
      _selectedAnimal = _dropdownMenuItems[0].value;
      for (int i = 0; i < _userAnimalList.length; i++) {
        if (loggedUserID == _userAnimalList[i].userId) {
          //send animals ids in a user
          _getAnimalHealth(_userAnimalList[i].id);
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _getUserAnimals(loggedUserID);
  }

  //Show all animals in a user by name
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
    if (_userAnimalList != null) {
      for (int i = 0; i < _userAnimalList.length; i++) {
        if (_userAnimalList[i].id == animalHealthList[i].animalId) {
          setState(() {
            _selectedAnimal = selectedAnimal;

            Navigator.of(context).push(PageRouteBuilder(
                opaque: false,
                pageBuilder: (BuildContext context, _, __) {
                  return SaglikTakipWidget(
                    hayvanID: _selectedAnimal.id,
                    name: _selectedAnimal.name,
                    parazitler: animalHealthList[i].parazitler,
                    karma: animalHealthList[i].parazitler,
                    kuduz: animalHealthList[i].kuduz,
                    mantar: animalHealthList[i].mantar,
                    lyme: animalHealthList[i].lyme,
                  );
                }));
          });
        }
      }
    } else {
      showDialog(
          context: context,
          builder: (_) => AlertDialogWidget(
              dialogTitle: 'Hata!',
              dialogContent:
                  'Verileriniz yüklenemedi. Lütfen daha sonra tekrar deneyin.',
              btnTitle: 'Kapat',
              onPressed: () {
                Navigator.pop(context);
              }));
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
      body: Center(
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
    );
  }
}
