import 'package:flutter/material.dart';
import 'package:kupe/constants.dart';

class AgreeOrNotButton extends StatelessWidget {
  final String dialogTitle;
  final String dialogContent;
  final String agreeBtnTitle;
  final String notAgreeBtnTitle;
  final Function agreeOnPressed;
  final Function notAgreeOnPressed;

  AgreeOrNotButton({
    this.dialogTitle,
    this.dialogContent,
    this.agreeBtnTitle,
    this.notAgreeBtnTitle,
    this.agreeOnPressed,
    this.notAgreeOnPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(accentColor: kMainKupeColor),
      child: AlertDialog(
        backgroundColor: Colors.white,
        titlePadding: EdgeInsets.symmetric(vertical: 20.0),
        contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
        buttonPadding: EdgeInsets.symmetric(horizontal: 20.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        title: Text(
          dialogTitle,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.red,
            fontSize: 21,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: SingleChildScrollView(
          child: Text(
            dialogContent,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: kLoginDarkBackground,
              fontSize: 18,
            ),
          ),
        ),
        actions: [
          SizedBox(
            //MediaQuery olmadan kapat butonu ortalanamıyor ve display'e göre responsive olmuyor
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0)),
                  color: kLoginDarkBackground,
                  elevation: 5.0,
                  height: 42.0,
                  minWidth: 75.0,
                  child: Text(
                    agreeBtnTitle,
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: agreeOnPressed,
                ),
                MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0)),
                  color: kLoginDarkBackground,
                  elevation: 5.0,
                  height: 42.0,
                  minWidth: 75.0,
                  child: Text(
                    notAgreeBtnTitle,
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: notAgreeOnPressed,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
