import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AlertDialogWidget extends StatelessWidget {
  final String dialogTitle;
  final String dialogContent;
  final String kapatBtnTitle;
  final Function onPressed;

  AlertDialogWidget(
      {@required this.dialogTitle,
      @required this.dialogContent,
      @required this.kapatBtnTitle,
      @required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(accentColor: Color(0xFF5CB3AB)),
      child: AlertDialog(
        backgroundColor: Colors.white,
        titlePadding: EdgeInsets.symmetric(vertical: 20.0),
        contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
        buttonPadding: EdgeInsets.symmetric(horizontal: 30.0),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        title: Text(dialogTitle,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.red, fontSize: 25, fontWeight: FontWeight.bold)),
        content: SingleChildScrollView(
          child: Text(dialogContent,
              textAlign: TextAlign.center,
              style: TextStyle(color: Color(0xFF1d2136), fontSize: 18)),
        ),
        actions: [
          SizedBox(
            //MediaQuery olmadan buton ortalanamıyor ve display'e göre responsive olmasını sağlıyor
            width: MediaQuery.of(context).size.width,
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0)),
                  color: Color(0xFF1d2136),
                  elevation: 5.0,
                  height: 42.0,
                  child: Text(
                    'Kapat',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: onPressed),
            ]),
          ),
        ],
      ),
    );
  }
}
