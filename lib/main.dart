import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:cat_dog_encyclopedia/ui/home_page.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:cat_dog_encyclopedia/style/theme.dart' as Theme;

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
      home: CatDogEncyclopedia(),
    );
  }
}

class CatDogEncyclopedia extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _CatDogEncyclopediaState();
}


class _CatDogEncyclopediaState extends State<CatDogEncyclopedia> {
  @override
  Widget build(BuildContext context) {
    return new SplashScreen(
      seconds: 5,
      navigateAfterSeconds: new MyHomePage(title: 'Cat - Dog Encyclopedia'),
      title: new Text('Cat Dog Encyclopedia',
        style: new TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20.0
        ),),
      image: new Image.asset('assets/images/icon_logo.jpg'),
      backgroundColor: Theme.Colors.secondaryColor,
      styleTextUnderTheLoader: new TextStyle(),
      photoSize: 100.0,
      onClick: ()=> {},
      loaderColor: Colors.white,
    );
  }
}