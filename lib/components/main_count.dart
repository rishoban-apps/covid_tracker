import 'package:covid_tracker/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../components/counter_card.dart';
import '../screens/error_screen.dart';

final num = NumberFormat("###,##0");

class MainCount extends StatefulWidget {
  final Future countData;

  MainCount({this.countData});

  @override
  _MainCountState createState() => _MainCountState();
}

class _MainCountState extends State<MainCount> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: widget.countData,
      builder: (context, snapshot) {
        if (snapshot.hasData &&
            snapshot.connectionState == ConnectionState.done) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.network(
                snapshot.data.flagUrl,
                scale: 3,
              ),
              Text(
                snapshot.data.countryName.toString(),
                style: TextStyle(
                    color: kMainTextColor,
                    fontSize: 15.0,
                    fontWeight: FontWeight.w400),
              ),
              Text(
                'Last updated at ${DateTime.fromMillisecondsSinceEpoch(snapshot.data.date).toString().split('.')[0]}',
                style: kCardTextStyle.copyWith(fontSize: 12.0),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CounterCard(
                    color: kCasesCardColor,
                    title: "Cases",
                    count: num.format(snapshot.data.totalCases).toString(),
                  ),
                  CounterCard(
                    color: kDeathCardColor,
                    title: "Deaths",
                    count: num.format(snapshot.data.deaths).toString(),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CounterCard(
                    color: kActiveCardColor,
                    title: "Active",
                    count: num.format(snapshot.data.active).toString(),
                  ),
                  CounterCard(
                    color: kRecoveredCardColor,
                    title: "Recovered",
                    count: num.format(snapshot.data.recovered).toString(),
                  ),
                ],
              ),
            ],
          );
        } else if (snapshot.hasError &&
            snapshot.connectionState == ConnectionState.done) {
          return ErrorScreen();
        }
        return Center(
          child: CircularProgressIndicator(
            backgroundColor: kMainTextColor,
            valueColor: AlwaysStoppedAnimation<Color>(kMainAlternateColor),
          ),
        );
      },
    );
  }
}
