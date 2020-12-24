import 'package:covid_tracker/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'counter_card.dart';

final num = NumberFormat("###,##0");

class PastData extends StatefulWidget {
  final Future previousDay;
  final Future twoDaysAgo;

  PastData({this.previousDay, this.twoDaysAgo});

  @override
  _PastDataState createState() => _PastDataState();
}

class _PastDataState extends State<PastData>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  List tabs;

  void initState() {
    super.initState();
    tabs = ['Yesterday', 'Two days ago'];
    _tabController = TabController(length: tabs.length, vsync: this);
  }

  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
        color: Colors.black54,
      ),
      child: Column(
        children: [
          Container(
            child: TabBar(
              indicatorColor: kMainAlternateColor,
              controller: _tabController,
              tabs: tabs.map((e) => Tab(text: e)).toList(),
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Container(
            height: 100.0,
            child: TabBarView(
              controller: _tabController,
              children: <Widget>[
                FutureBuilder(
                  future: widget.previousDay,
                  builder: (context, snapshot) {
                    if (snapshot.hasData &&
                        snapshot.connectionState == ConnectionState.done) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CounterCard(
                            color: kCasesCardColor,
                            title: "Cases",
                            count:
                                num.format(snapshot.data.pastCases).toString(),
                          ),
                          CounterCard(
                            color: kDeathCardColor,
                            title: "Deaths",
                            count:
                                num.format(snapshot.data.pastDeaths).toString(),
                          ),
                        ],
                      );
                    } else if (snapshot.hasError) {
                      return Container();
                    }
                    return Center(
                      child: CircularProgressIndicator(
                        backgroundColor: kMainTextColor,
                        valueColor:
                            AlwaysStoppedAnimation<Color>(kMainAlternateColor),
                      ),
                    );
                  },
                ),
                FutureBuilder(
                  future: widget.twoDaysAgo,
                  builder: (context, snapshot) {
                    if (snapshot.hasData &&
                        snapshot.connectionState == ConnectionState.done) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CounterCard(
                            color: kCasesCardColor,
                            title: "Cases",
                            count:
                                num.format(snapshot.data.pastCases).toString(),
                          ),
                          CounterCard(
                            color: kDeathCardColor,
                            title: "Deaths",
                            count:
                                num.format(snapshot.data.pastDeaths).toString(),
                          ),
                        ],
                      );
                    } else if (snapshot.hasError) {
                      return Container();
                    }
                    return Center(
                      child: CircularProgressIndicator(
                        backgroundColor: kMainTextColor,
                        valueColor:
                            AlwaysStoppedAnimation<Color>(kMainAlternateColor),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
