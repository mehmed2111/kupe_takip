import 'package:flutter/material.dart';
import 'package:kupe/constants.dart';
import 'package:kupe/widgets/rounded_button.dart';

class RegionDeleteName extends StatefulWidget {
  @override
  _RegionDeleteNameState createState() => _RegionDeleteNameState();
}

class _RegionDeleteNameState extends State<RegionDeleteName> {
  /* //Show all animals in a user on dropDownMenu by name
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
  }*/

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      child: Container(
        height: 260,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.edit, color: kLoginDarkBackground),
                SizedBox(width: 10),
                Text('Bölge Düzenle',
                    style:
                        TextStyle(color: kLoginDarkBackground, fontSize: 25)),
              ],
            ),
            SizedBox(height: 16),
            Container(
              height: 48.0,
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              padding: EdgeInsets.symmetric(horizontal: 20),
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 1.0, color: kMainKupeColor),
                  borderRadius: BorderRadius.circular(32.0),
                ),
              ),
              child: DropdownButton(
                //value: _selectedAnimal,
                //items: _dropdownMenuItems,
                //onChanged: onChangedDropdownItem,
                icon: Icon(Icons.arrow_drop_down, color: kLoginDarkBackground),
                isExpanded: true,
                iconSize: 30.0,
                iconEnabledColor: kLoginDarkBackground,
                underline: SizedBox(),
                dropdownColor: Colors.white,
                style: TextStyle(color: kLoginDarkBackground),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: RoundedButton(
                  colour: kMainKupeColor,
                  buttonTitle: 'Bölgeyi Sil',
                  onPressed: () {
                    //controls here..
                  }),
            ),
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: RoundedButton(
                  colour: kLoginDarkBackground,
                  buttonTitle: 'İptal',
                  onPressed: () => Navigator.pop(context)),
            ),
          ],
        ),
      ),
    );
  }
}
