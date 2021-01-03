import 'package:flutter/material.dart';
import 'package:kupe/constants.dart';

class KapatButton extends StatelessWidget {
  final Function onPressed;

  KapatButton({@required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      child: SizedBox(
        //MediaQuery olmadan kapat butonu ortalanamıyor ve display'e göre responsive olmuyor.
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0)),
                color: kLoginDarkBackground,
                elevation: 5.0,
                height: 42.0,
                child: Text(
                  'Kapat',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: onPressed),
          ],
        ),
      ),
    );
    /*Padding(
      padding: EdgeInsets.symmetric(horizontal: 90.0, vertical: 10.0),
      child: MaterialButton(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        color: Color(0xFF1d2136),
        elevation: 5.0,
        height: 42.0,
        child: Text(
          'Kapat',
          style: TextStyle(color: Colors.white),
        ),
        onPressed: onPressed,
      ),
    );*/
  }
}
