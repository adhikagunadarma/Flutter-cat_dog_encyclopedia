
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:cat_dog_encyclopedia/ui/splash_screen.dart';


void main() {
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(new MyApp());
  });
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title : "Cat Dog Encyclopedia",
      home: SplashScreen(),
    );
  }
}


