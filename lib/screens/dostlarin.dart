import 'package:flutter/material.dart';
import 'package:kupe/constants.dart';
import 'package:kupe/dbtables/user_animal_table.dart';
import 'package:kupe/network/network_check.dart';
import 'package:kupe/widgets/alert_dialog_widget.dart';
import 'package:kupe/widgets/dostlarin_widget.dart';
import 'package:kupe/widgets/kapat_button.dart';
import 'package:kupe/widgets/rounded_button.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class Dostlarin extends StatefulWidget {
  static const String id = 'dostlarin';
  final String name;
  final String gender;
  final String color;
  final int selectedAnimalId;

  Dostlarin({this.name, this.gender, this.color, this.selectedAnimalId});

  @override
  _DostlarinState createState() => _DostlarinState();
}

class _DostlarinState extends State<Dostlarin> {
  NetworkCheck _networkCheck = NetworkCheck();
  UserAnimals _userAnimals = UserAnimals();
  List<UserAnimals> updateAnimal;
  List<UserAnimals> _userAnimalList;

  String dropDownAnimalGender = 'Cinsiyetini seç..';
  final animalName = TextEditingController();
  final animalColor = TextEditingController();

  void _updateUserAnimal(int animalId, String animalName, String animalColor,
      int animalGender) async {
    var userAnimalData = await _userAnimals.updateUserAnimal(
        animalId, animalName, animalColor, animalGender);
    updateAnimal = userAnimalData;
  }

  //call fetchUserAnimals() function inside this function in order to prevent 'instance of Users' error
  void _getUserAnimals(int userId) async {
    var dataList = await _userAnimals.fetchUserAnimals(userId);
    _userAnimalList = dataList;

    UserAnimals animal;
    //assign animal which come from animal_update page dropDownMenu
    for (animal in _userAnimalList) {
      if (widget.selectedAnimalId == animal.id) {
        animalName.text = widget.name;
        animalColor.text = widget.color;
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _getUserAnimals(loggedUserID);
  }

  @override
  void dispose() {
    super.dispose();
    animalName.dispose();
    animalColor.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.25),
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10.0),
          child: Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0)),
            child: Container(
              height: 530,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        backgroundImage: AssetImage('images/logo.jpg'),
                        radius: 40.0,
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Text(
                        widget.name,
                        style: TextStyle(
                          color: kLoginDarkBackground,
                          fontSize: 25.0,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.0),
                  Expanded(
                    child: Theme(
                      data: Theme.of(context).copyWith(
                        accentColor: kMainKupeColor,
                      ),
                      child: ListView(
                        children: [
                          DostlarinWidget(
                            textTitle: 'ADI',
                            hintText: 'Dostunuzun adını giriniz..',
                            controllerText: animalName,
                          ),
                          SizedBox(height: 10.0),
                          Text(
                            'CİNSİYETİ',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: kLoginDarkBackground,
                                fontWeight: FontWeight.bold),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 1),
                            decoration: ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    width: 1.0, color: kMainKupeColor),
                                borderRadius: BorderRadius.circular(32.0),
                              ),
                            ),
                            child: DropdownButton<String>(
                              value: dropDownAnimalGender,
                              items: <String>[
                                'Cinsiyetini seç..',
                                'Erkek',
                                'Dişi'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: kLoginDarkBackground,
                                          fontSize: 15)),
                                );
                              }).toList(),
                              onChanged: (String newValue) {
                                setState(() {
                                  dropDownAnimalGender = newValue;
                                });
                              },
                              icon: Icon(Icons.arrow_drop_down),
                              isExpanded: true,
                              iconSize: 30.0,
                              iconEnabledColor: kLoginDarkBackground,
                              underline: SizedBox(),
                              dropdownColor: Colors.white,
                              style: TextStyle(color: kLoginDarkBackground),
                            ),
                          ),
                          DostlarinWidget(
                            textTitle: 'RENGİ',
                            hintText: 'Dostunuzun rengini giriniz..',
                            controllerText: animalColor,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 16.0),
                            child: RoundedButton(
                              colour: kMainKupeColor,
                              buttonTitle: 'Güncelle',
                              onPressed: () {
                                setState(() {
                                  showSpinner = true;
                                });
                                UserAnimals animal;
                                try {
                                  _networkCheck.check().then(
                                    (internet) {
                                      if (internet != null && internet) {
                                        if (animalName.text != '' &&
                                            animalColor.text != '' &&
                                            dropDownAnimalGender !=
                                                'Cinsiyetini seç..') {
                                          for (animal in _userAnimalList) {
                                            if (widget.selectedAnimalId ==
                                                animal.id) {
                                              setState(
                                                () {
                                                  _updateUserAnimal(
                                                    widget.selectedAnimalId,
                                                    animalName.text,
                                                    animalColor.text,
                                                    dropDownAnimalGender ==
                                                            'Erkek'
                                                        ? 0
                                                        : dropDownAnimalGender ==
                                                                'Dişi'
                                                            ? 1
                                                            : null,
                                                  );
                                                  showDialog(
                                                    context: context,
                                                    builder: (_) =>
                                                        AlertDialogWidget(
                                                      dialogTitle:
                                                          'Güncelleme Başarılı!',
                                                      dialogContent:
                                                          'Verileriniz başarılı bir şekilde güncellendi.',
                                                      btnTitle: 'Kapat',
                                                      onPressed: () {
                                                        Navigator.pop(_);
                                                        //close this page
                                                        Navigator.pop(context,
                                                            Dostlarin.id);
                                                        //Navigator.pop(context, DostlariniGuncelle.id);
                                                        //Navigator.pushNamed(context, DostlariniGuncelle.id);
                                                      },
                                                    ),
                                                  );
                                                },
                                              );
                                            }
                                          }
                                        } else {
                                          showDialog(
                                            context: context,
                                            builder: (_) => AlertDialogWidget(
                                              dialogTitle: 'Hata!',
                                              dialogContent:
                                                  'Alanlar boş bırakılamaz. Lütfen boş alanları doldurun ve tekrar deneyin.',
                                              btnTitle: 'Kapat',
                                              onPressed: () {
                                                Navigator.pop(_);
                                              },
                                            ),
                                          );
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
                                            },
                                          ),
                                        );
                                      }
                                    },
                                  );
                                  setState(() {
                                    showSpinner = false;
                                  });
                                } catch (e) {
                                  print(e);
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  KapatButton(onPressed: () {
                    Navigator.pop(context);
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
