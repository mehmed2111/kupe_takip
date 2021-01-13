import 'package:flutter/material.dart';
import 'package:kupe/constants.dart';
import 'package:kupe/dbtables/animal_health.dart';
import 'package:kupe/widgets/saglik_takip_widget.dart';

class SaglikTakip extends StatefulWidget {
  SaglikTakip() : super();
  final String title = 'Sağlık Takip';

  static const String id = 'saglik_takip';

  @override
  _SaglikTakipState createState() => _SaglikTakipState();
}

class UAnimals {
  int animalID;
  String name;
  String parazitler;
  String karma;
  String kuduz;
  String mantar;
  String lyme;

  UAnimals(
      {this.animalID,
      this.name,
      this.parazitler,
      this.karma,
      this.kuduz,
      this.mantar,
      this.lyme});

  static List<UAnimals> getUAnimals() {
    return <UAnimals>[
      UAnimals(
          animalID: 10267,
          name: 'Boncuk',
          parazitler: 'Henüz aşı bilgisi yok',
          karma: '11.03.2020 de aşısı yapıldı',
          kuduz: 'Henüz aşı bilgisi yok',
          mantar: '01.06.2020 de aşısı yapıldı',
          lyme: 'Henüz aşı bilgisi yok'),
      UAnimals(
          animalID: 2,
          name: 'Dost2',
          parazitler: 'Parazit aşısı yapıldı',
          karma: 'Karma aşısı yapıldı',
          kuduz: 'Kuduz aşısı yapıldı',
          mantar: 'Mantar aşısı yapıldı',
          lyme: 'Lyme aşısı yapıldı'),
      UAnimals(
          animalID: 3,
          name: 'Dost3',
          parazitler: 'Parazit aşısı yapıldı',
          karma: 'Karma aşısı yapıldı',
          kuduz: 'Kuduz aşısı yapıldı',
          mantar: 'Mantar aşısı yapıldı',
          lyme: 'Lyme aşısı yapıldı'),
    ];
  }
}

class _SaglikTakipState extends State<SaglikTakip> {
  List<UAnimals> _animals = UAnimals.getUAnimals();
  List<DropdownMenuItem<UAnimals>> _dropdownMenuItems;
  UAnimals _selectedAnimal;

  AnimalHealth _animalHealth = AnimalHealth();
  List<AnimalHealth> animalHealthList;
  //fetch animal health
  void _getAnimalHealth(int id) async {
    var animalData = await _animalHealth.fetchAnimalHealth(id);
    animalHealthList = animalData;

    print('Animal Health Animal id: ${animalHealthList[0].animalId}');
  }

  @override
  void initState() {
    super.initState();
    _dropdownMenuItems = buildDropdownMenuItems(_animals);
    _selectedAnimal = _dropdownMenuItems[0].value;
    setState(() {
      _getAnimalHealth(10);
    });
  }

  //Kullanıcı da kaç tane hayvan varsa, dropdown menüde göster
  List<DropdownMenuItem<UAnimals>> buildDropdownMenuItems(List animals) {
    List<DropdownMenuItem<UAnimals>> items = List();
    for (UAnimals animal in animals) {
      items.add(
        DropdownMenuItem(
          value: animal,
          child: Text(animal.name),
        ),
      );
    }
    return items;
  }

  onChangedDropdownItem(UAnimals secilenhayvan) {
    setState(() {
      _selectedAnimal = secilenhayvan;

      Navigator.of(context).push(PageRouteBuilder(
          opaque: false,
          pageBuilder: (BuildContext context, _, __) {
            return SaglikTakipWidget(
                hayvanID: _selectedAnimal.animalID,
                name: _selectedAnimal.name,
                parazitler: _selectedAnimal.parazitler,
                karma: _selectedAnimal.karma,
                kuduz: _selectedAnimal.kuduz,
                mantar: _selectedAnimal.mantar,
                lyme: _selectedAnimal.lyme);
          }));
    });
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
