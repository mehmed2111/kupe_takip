import 'package:flutter/material.dart';
import 'package:kupe/constants.dart';
import 'package:kupe/dbtables/user_region.dart';
import 'package:kupe/network/network_check.dart';
import 'package:kupe/screens/home_page.dart';
import 'package:kupe/widgets/alert_dialog_messages.dart';
import 'package:kupe/widgets/alert_dialog_widget.dart';
import 'package:kupe/widgets/rounded_button.dart';

class RegionDeleteName extends StatefulWidget {
  static const String id = 'region_delete_name';
  @override
  _RegionDeleteNameState createState() => _RegionDeleteNameState();
}

class _RegionDeleteNameState extends State<RegionDeleteName> {
  NetworkCheck _networkCheck = NetworkCheck();
  UserRegion region = UserRegion();
  List<UserRegion> _regionList;
  UserRegion _selectedRegion;
  List<DropdownMenuItem<UserRegion>> _dropDownMenuItems;

  void _getUserRegion(int userID) async {
    var data = await region.fetchUserRegion(userID);
    _regionList = data;
    setState(() {
      _dropDownMenuItems = buildDropdownMenuItems(_regionList);
      _selectedRegion = _dropDownMenuItems[0].value;
    });
  }

  void _deleteRegionName(int regionId) async {
    var data = region.deleteRegionName(regionId);
  }

  //Show all regions in a user on dropDownMenu by name
  List<DropdownMenuItem<UserRegion>> buildDropdownMenuItems(
      List<UserRegion> userRegion) {
    List<DropdownMenuItem<UserRegion>> items = List();
    for (UserRegion region in userRegion) {
      items.add(
        DropdownMenuItem(
          value: region,
          child: Text(region.rname),
        ),
      );
    }
    return items;
  }

  onChangedDropDownMenuItem(UserRegion selectedRegion) {
    setState(() {
      _selectedRegion = selectedRegion;
    });
  }

  @override
  void initState() {
    super.initState();
    _getUserRegion(loggedUserID);
  }

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
                value: _selectedRegion,
                items: _dropDownMenuItems,
                onChanged: onChangedDropDownMenuItem,
                icon: Icon(Icons.arrow_drop_down, color: kLoginDarkBackground),
                isExpanded: true,
                iconSize: 30.0,
                iconEnabledColor: kLoginDarkBackground,
                underline: SizedBox(),
                dropdownColor: Colors.white,
                style: TextStyle(color: kLoginDarkBackground, fontSize: 18.0),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: RoundedButton(
                  colour: kMainKupeColor,
                  buttonTitle: 'Bölgeyi Sil',
                  onPressed: () {
                    UserRegion region;
                    setState(() {
                      showSpinner = true;
                    });
                    try {
                      _networkCheck.check().then((internet) {
                        if (internet != null && internet) {
                          if (_regionList != null) {
                            for (region in _regionList) {
                              if (loggedUserID == region.userId) {
                                if (region.id == _selectedRegion.id) {
                                  //delete function here
                                  setState(() {
                                    print(
                                        'selected Region Id: ${_selectedRegion.id}');
                                    _deleteRegionName(_selectedRegion.id);
                                    showDialog(
                                      context: context,
                                      builder: (_) => AlertDialogWidget(
                                          dialogTitle: 'İşlem Başarılı!',
                                          dialogContent:
                                              'Seçilen bölge başarılı bir şekilde silindi.',
                                          btnTitle: 'Kapat',
                                          onPressed: () {
                                            Navigator.pop(_);
                                            Navigator.pop(
                                                context, RegionDeleteName.id);
                                            Navigator.pushNamed(
                                                context, HomePage.id);
                                          }),
                                    );
                                  });
                                }
                              }
                            }
                          } else {
                            showDialog(
                              context: context,
                              builder: (_) => CouldNotLoadData(),
                            );
                          }
                        } else {
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
                      throw Exception('Could not load user Region');
                    }
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
