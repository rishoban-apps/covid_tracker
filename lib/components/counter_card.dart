import 'package:covid_tracker/utils/constants.dart';
import 'package:flutter/material.dart';

class CounterCard extends StatelessWidget {
  final String title;
  final String count;
  final Color color;

  CounterCard(
      {@required this.title, @required this.color, @required this.count});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150.0,
      height: 100.0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: kCardTextStyle,
            ),
            Text(count,
                style: kCardTextStyle.copyWith(fontWeight: FontWeight.w800)),
          ],
        ),
      ),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10.0),
      ),
    );
  }
}
