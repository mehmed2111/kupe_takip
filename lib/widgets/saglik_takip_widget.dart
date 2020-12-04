import 'package:flutter/material.dart';

import 'kapat_butonu.dart';

class SaglikTakipWidget extends StatelessWidget {
  final int hayvanID;
  final String name;
  final String parazitler;
  final String karma;
  final String kuduz;
  final String mantar;
  final String lyme;

  SaglikTakipWidget(
      {@required this.hayvanID,
      @required this.name,
      @required this.parazitler,
      @required this.karma,
      @required this.kuduz,
      @required this.mantar,
      @required this.lyme});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.25),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 0.0),
        child: Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
          elevation: 16.0,
          child: Theme(
            data: Theme.of(context).copyWith(accentColor: Color(0xFF5CB3AB)),
            child: Container(
              height: 400.0,
              width: 360.0,
              child: ListView(
                controller: ScrollController(keepScrollOffset: false),
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 10.0,
                      ),
                      Text(
                        'Kullanıcı Profili',
                        style: TextStyle(
                          color: Color(0xFF1d2136),
                          fontSize: 25.0,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    children: [
                      Text(
                        'Deneme1',
                        style:
                            TextStyle(color: Color(0xFF1d2136), fontSize: 18.0),
                      ),
                      Text(
                        hayvanID.toString(),
                        style:
                            TextStyle(color: Color(0xFF1d2136), fontSize: 18.0),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'Deneme2',
                        style:
                            TextStyle(color: Color(0xFF1d2136), fontSize: 18.0),
                      ),
                      Text(
                        name,
                        style:
                            TextStyle(color: Color(0xFF1d2136), fontSize: 18.0),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'Deneme3',
                        style:
                            TextStyle(color: Color(0xFF1d2136), fontSize: 18.0),
                      ),
                      Text(
                        parazitler,
                        style:
                            TextStyle(color: Color(0xFF1d2136), fontSize: 18.0),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'Deneme4',
                        style:
                            TextStyle(color: Color(0xFF1d2136), fontSize: 18.0),
                      ),
                      Text(
                        karma,
                        style:
                            TextStyle(color: Color(0xFF1d2136), fontSize: 18.0),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'Deneme5',
                        style:
                            TextStyle(color: Color(0xFF1d2136), fontSize: 18.0),
                      ),
                      Text(
                        kuduz,
                        style:
                            TextStyle(color: Color(0xFF1d2136), fontSize: 18.0),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'Deneme6',
                        style:
                            TextStyle(color: Color(0xFF1d2136), fontSize: 18.0),
                      ),
                      Text(
                        mantar,
                        style:
                            TextStyle(color: Color(0xFF1d2136), fontSize: 18.0),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'Deneme7',
                        style:
                            TextStyle(color: Color(0xFF1d2136), fontSize: 18.0),
                      ),
                      Text(
                        lyme,
                        style:
                            TextStyle(color: Color(0xFF1d2136), fontSize: 18.0),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  KapatButonu(onPressed: () {
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
