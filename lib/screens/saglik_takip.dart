import 'package:flutter/material.dart';
import 'package:kupe/constants.dart';
import 'package:kupe/dbtables/animal_health.dart';
import 'package:kupe/dbtables/user_animal_table.dart';
import 'package:kupe/network/network_check.dart';
import 'package:kupe/widgets/alert_dialog_widget.dart';
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

    //UserAnimals animal;
    setState(() {
      _dropdownMenuItems = buildDropdownMenuItems(_userAnimalList);
      _selectedAnimal = _dropdownMenuItems[0].value;
      _getAnimalHealth(animalID);
      //for (animal in _userAnimalList) {
      //if (loggedUserID == animal.userId) {
      //send animals ids in a user
      //animalID = animal.id;
      //_getAnimalHealth(animalID);
      //}
      //}
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
    AnimalHealth animalHealth;
    setState(() {
      showSpinner = true;
    });
    try {
      _networkCheck.check().then((internet) {
        if (internet != null && internet) {
          if (_userAnimalList != null && animalHealthList != null) {
            for (animal in _userAnimalList) {
              for (animalHealth in animalHealthList) {
                if (animal.id == animalHealth.animalId) {
                  setState(() {
                    _selectedAnimal = selectedAnimal;

                    Navigator.of(context).push(PageRouteBuilder(
                        opaque: false,
                        pageBuilder: (BuildContext context, _, __) {
                          return SaglikTakipWidget(
                            hayvanID: _selectedAnimal.id,
                            name: _selectedAnimal.name,
                            parazitler: animalHealth.parazitler,
                            karma: animalHealth.parazitler,
                            kuduz: animalHealth.kuduz,
                            mantar: animalHealth.mantar,
                            lyme: animalHealth.lyme,
                          );
                        }));
                  });
                }
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
                      Navigator.pop(_);
                    }));
          }
        } else {
          //if there is no internet connection
          showDialog(
              context: context,
              builder: (_) => AlertDialogWidget(
                  dialogTitle: 'İnternet hatası!',
                  dialogContent:
                      'Lütfen internete bağlı olduğunuzdan emin olun ve tekrar deneyin.',
                  btnTitle: 'Kapat',
                  onPressed: () {
                    Navigator.pop(_);
                  }));
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
