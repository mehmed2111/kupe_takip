import 'package:flutter/material.dart';
import 'package:kupe/widgets/saglik_takip_widget.dart';

class SaglikTakip extends StatefulWidget {
  SaglikTakip() : super();
  final String title = 'Sağlık Takip';

  static const String id = 'saglik_takip';

  @override
  _SaglikTakipState createState() => _SaglikTakipState();
}

class Hayvanlarim {
  int hayvanID;
  String name;
  String parazitler;
  String karma;
  String kuduz;
  String mantar;
  String lyme;

  Hayvanlarim(
      {this.hayvanID,
      this.name,
      this.parazitler,
      this.karma,
      this.kuduz,
      this.mantar,
      this.lyme});

  static List<Hayvanlarim> getHayvanlarim() {
    return <Hayvanlarim>[
      Hayvanlarim(
          hayvanID: 1,
          name: 'Dost1',
          parazitler: 'Parazit aşısı yapıldı',
          karma: 'Karma aşısı yapıldı',
          kuduz: 'Kuduz aşısı yapıldı',
          mantar: 'Mantar aşısı yapıldı',
          lyme: 'Lyme aşısı yapıldı'),
      Hayvanlarim(
          hayvanID: 2,
          name: 'Dost2',
          parazitler: 'Parazit aşısı yapıldı',
          karma: 'Karma aşısı yapıldı',
          kuduz: 'Kuduz aşısı yapıldı',
          mantar: 'Mantar aşısı yapıldı',
          lyme: 'Lyme aşısı yapıldı'),
      Hayvanlarim(
          hayvanID: 3,
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
  List<Hayvanlarim> _hayvanlar = Hayvanlarim.getHayvanlarim();
  List<DropdownMenuItem<Hayvanlarim>> _dropdownMenuItems;
  Hayvanlarim _secilenHayvan;

  @override
  void initState() {
    _dropdownMenuItems = buildDropdownMenuItems(_hayvanlar);
    _secilenHayvan = _dropdownMenuItems[0].value;
    super.initState();
  }

  //kullanıcı da kaç tane hayvan varsa, dropdown menüde göster
  List<DropdownMenuItem<Hayvanlarim>> buildDropdownMenuItems(List hayvanlar) {
    List<DropdownMenuItem<Hayvanlarim>> items = List();
    for (Hayvanlarim hayvan in hayvanlar) {
      items.add(
        DropdownMenuItem(
          value: hayvan,
          child: Text(hayvan.name),
        ),
      );
    }
    return items;
  }

  onChangedDropdownItem(Hayvanlarim secilenhayvan) {
    setState(() {
      _secilenHayvan = secilenhayvan;

      Navigator.of(context).push(PageRouteBuilder(
          opaque: false,
          pageBuilder: (BuildContext context, _, __) {
            return SaglikTakipWidget(
                hayvanID: 3,
                name: 'Dost3',
                parazitler: 'Parazit aşısı yapıldı',
                karma: 'Karma aşısı yapıldı',
                kuduz: 'Kuduz aşısı yapıldı',
                mantar: 'Mantar aşısı yapıldı',
                lyme: 'Lyme aşısı yapıldı');
          }));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1d2136),
      appBar: AppBar(
        backgroundColor: Color(0xFF5CB3AB),
        title: Text('Sağlık Takibi'),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20.0),
            Text(
              'Dost seç',
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
                value: _secilenHayvan,
                items: _dropdownMenuItems,
                onChanged: onChangedDropdownItem,
                icon: Icon(Icons.arrow_drop_down),
                isExpanded: true,
                iconSize: 37.0,
                iconEnabledColor: Color(0xFF1d2136),
                underline: SizedBox(),
                dropdownColor: Colors.white,
                style: TextStyle(color: Color(0xFF1d2136), fontSize: 18.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}