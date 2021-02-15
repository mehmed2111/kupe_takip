import 'package:flutter/material.dart';
import 'package:kupe/constants.dart';
import 'package:kupe/widgets/alert_dialog_messages.dart';
import 'package:kupe/widgets/rounded_button_with_icon.dart';

class HealthVaccineInfo extends StatelessWidget {
  final Icon iconDate;
  final String vaccineDate;
  final String vaccineEndDate;
  final Icon iconEndDate;
  final Function onPressed;

  HealthVaccineInfo({
    this.iconDate,
    this.vaccineDate,
    this.vaccineEndDate,
    this.iconEndDate,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          flex: 1,
          child: Column(
            children: [
              IconButton(
                icon: iconDate,
                color: Colors.grey[500],
                iconSize: 25.0,
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (_) => VaccineInfo(),
                  );
                },
              ),
              Text(
                vaccineDate,
                style: TextStyle(
                  color: kLoginDarkBackground,
                  fontSize: 16.0,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Column(
            children: [
              IconButton(
                icon: iconEndDate,
                color: Colors.red[900],
                iconSize: 25.0,
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (_) => VaccineEndDate(),
                  );
                },
              ),
              Text(
                vaccineEndDate,
                style: TextStyle(
                  color: kLoginDarkBackground,
                  fontSize: 16.0,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: RoundedButtonWithIcon(
            icon: Icons.calendar_today,
            btnTitle: 'Aşı Gir',
            onPressed: onPressed,
          ),
        ),
      ],
    );
  }
}
