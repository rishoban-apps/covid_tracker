import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkConnector {
  Future fetchData({String countryCode}) async {
    final response = await http.get(
        'https://disease.sh/v3/covid-19/countries/$countryCode?strict=true');

    if (response.statusCode == 200) {
      return Count.fromJson(
        jsonDecode(response.body),
      );
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  Future fetchPreviousDay(
      {String countryCode, bool yesterday, bool twoDaysAgo}) async {
    final response = await http.get(
        'https://disease.sh/v3/covid-19/countries/$countryCode?yesterday=$yesterday&twoDaysAgo=$twoDaysAgo&strict=true');

    if (response.statusCode == 200) {
      return PreviousCount.fromJson(
        jsonDecode(response.body),
      );
    } else {
      throw Exception('Failed to fetch data');
    }
  }
}

class Count {
  final int totalCases;
  final int deaths;
  final int recovered;
  final int active;
  final String countryName;
  final int date;
  final String flagUrl;

  Count(
      {this.totalCases,
      this.deaths,
      this.recovered,
      this.active,
      this.countryName,
      this.date,
      this.flagUrl});

  factory Count.fromJson(Map<String, dynamic> json) {
    return Count(
        totalCases: json['cases'],
        deaths: json['deaths'],
        recovered: json['recovered'],
        active: json['active'],
        countryName: json['country'],
        date: json['updated'],
        flagUrl: json['countryInfo']['flag']);
  }
}

class PreviousCount {
  final int pastCases;
  final int pastDeaths;

  PreviousCount({
    this.pastCases,
    this.pastDeaths,
  });

  factory PreviousCount.fromJson(Map<String, dynamic> json) {
    return PreviousCount(
      pastCases: json['todayCases'],
      pastDeaths: json['todayDeaths'],
    );
  }
}
