import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kupe/constants.dart';

class AlertDialogWidget extends StatelessWidget {
  final String dialogTitle;
  final String dialogContent;
  final String btnTitle;
  final Function onPressed;

  AlertDialogWidget(
      {@required this.dialogTitle,
      @required this.dialogContent,
      @required this.btnTitle,
      @required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(accentColor: kMainKupeColor),
      child: AlertDialog(
        backgroundColor: Colors.white,
        titlePadding: EdgeInsets.symmetric(vertical: 20.0),
        contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
        buttonPadding: EdgeInsets.symmetric(horizontal: 25.0),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        title: Text(dialogTitle,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.red, fontSize: 25, fontWeight: FontWeight.bold)),
        content: SingleChildScrollView(
          child: Text(dialogContent,
              textAlign: TextAlign.center,
              style: TextStyle(color: kLoginDarkBackground, fontSize: 18)),
        ),
        actions: [
          SizedBox(
            //MediaQuery olmadan kapat butonu ortalanamıyor ve display'e göre responsive olmasını sağlıyor
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
                      btnTitle,
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: onPressed),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
