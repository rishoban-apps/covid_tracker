import 'dart:async';

import 'package:country_picker/country_picker.dart';
import 'package:covid_tracker/components/country_picker.dart';
import 'package:covid_tracker/components/main_count.dart';
import 'package:covid_tracker/components/past_data.dart';
import 'package:covid_tracker/utils/constants.dart';
import 'package:flutter/material.dart';

import '../services/network_connector.dart';

class Counter extends StatefulWidget {
  @override
  _CounterState createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  NetworkConnector _networkConnector = NetworkConnector();
  Future _countData, _previousDayData, _twoDaysAgoData;

  void fetchCount(countryCode) {
    _countData = _networkConnector.fetchData(countryCode: countryCode);
    _previousDayData = _networkConnector.fetchPreviousDay(
        countryCode: countryCode, yesterday: true, twoDaysAgo: false);
    _twoDaysAgoData = _networkConnector.fetchPreviousDay(
        countryCode: countryCode, yesterday: false, twoDaysAgo: true);
  }

  @override
  void initState() {
    super.initState();
    fetchCount('LK');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text('COVID-19 Statistics'),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        actions: [
          Builder(
            builder: (context) => IconButton(
              onPressed: () {
                setState(
                  () {
                    fetchCount('LK');
                    Scaffold.of(context).showSnackBar(
                      SnackBar(
                        duration: Duration(seconds: 1),
                        content: Text(
                          'Checking for new data...',
                          style: TextStyle(color: Colors.black),
                        ),
                        backgroundColor: kMainTextColor,
                      ),
                    );
                  },
                );
              },
              icon: Icon(
                Icons.refresh,
                color: kMainTextColor,
              ),
            ),
          ),
        ],
      ),
      body: Container(
        decoration: kBackgroundDecoration,
        margin: EdgeInsets.all(0.0),
        child: SafeArea(
          child: Column(
            children: [
              Builder(
                builder: (context) => CountryPicker(
                  onSelect: (Country country) {
                    Scaffold.of(context).showSnackBar(
                      SnackBar(
                        duration: Duration(seconds: 1),
                        content: Text('Fetching data...'),
                      ),
                    );
                    setState(
                      () {
                        fetchCount(country.countryCode);
                      },
                    );
                  },
                ),
              ),
              Expanded(
                flex: 2,
                child: MainCount(
                  countData: _countData,
                ),
              ),
              Expanded(
                flex: 1,
                child: PastData(
                  previousDay: _previousDayData,
                  twoDaysAgo: _twoDaysAgoData,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
