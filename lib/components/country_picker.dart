import 'package:country_picker/country_picker.dart';
import 'package:covid_tracker/utils/constants.dart';
import 'package:flutter/material.dart';

class CountryPicker extends StatelessWidget {
  final Function onSelect;

  CountryPicker({this.onSelect});

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      color: Colors.transparent,
      elevation: 0.0,
      textColor: kMainTextColor,
      onPressed: () {
        showCountryPicker(
          context: context,
          showPhoneCode: false,
          onSelect: onSelect,
        );
      },
      child: Text(
        'Change country ▼',
        style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w300),
      ),
    );
  }
}
