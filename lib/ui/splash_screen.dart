import 'dart:async';

import 'package:flutter/material.dart';

import 'package:cat_dog_encyclopedia/ui/home_page.dart';
import 'package:cat_dog_encyclopedia/style/theme.dart' as Theme;

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {

  static double _bodyContainerHeight;
  static double _bodyContainerWidth;

  static double _iconHeight;
  static double _iconWidth;

  //Splash Screen effect
  @override
  void initState() {
    startTime();

    super.initState();
  }

  startTime() async {
    var _duration = new Duration(milliseconds: 3000);
    return new Timer(_duration, _navigationPage);
  }

  void _navigationPage() {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => MyHomePage(
              title: 'Cat - Dog Encyclopedia',
            )));
  }

  @override
  Widget build(BuildContext context) {
    setSize();
    return Scaffold(
      body: Container(
        width: _bodyContainerWidth,
        height: _bodyContainerHeight,
        decoration: new BoxDecoration(
          gradient: new LinearGradient(
              colors: [
                Theme.Colors.primaryColor,
                Theme.Colors.secondaryColor,
//              Theme.Colors.thirdColor,
              ],
              begin: const FractionalOffset(0.0, 0.0),
              end: const FractionalOffset(1.0, 1.0),
//              stops: [0.333,0.667, 1.0],
              stops: [0.4, 1.0],
              tileMode: TileMode.clamp),
        ),
//        color: Theme.Colors.secondaryColor,
        child: Center(
          child: new Image.asset(
            'assets/images/catdog_logo.png',
            height: _iconHeight,
            width: _iconWidth,
          ),
        ),
      ),
    );
  }

  void setSize() {
    _bodyContainerWidth = MediaQuery.of(context).size.width; //body container width
    _bodyContainerHeight = MediaQuery.of(context).size.height >= 775.0 //body container height
        ? MediaQuery.of(context).size.height
        : 775.0;
    _iconHeight = MediaQuery.of(context).size.height / 6.83; //icon size
    _iconWidth = MediaQuery.of(context).size.height / 6.83; //icon size
  }

  void dispose() {
    super.dispose();
  }
}
