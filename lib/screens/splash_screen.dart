import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'home_screen.dart';

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 5,
      navigateAfterSeconds: Counter(),
      title: Text(
        'COVID-19 Statistics',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 30.0,
        ),
      ),
      image: Image.asset('images/coronavirus.png'),
      backgroundColor: Colors.white,
      loadingText: Text('Loading...'),
      styleTextUnderTheLoader: TextStyle(fontSize: 30.0),
      photoSize: 100.0,
      loaderColor: Colors.red,
    );
  }
}
