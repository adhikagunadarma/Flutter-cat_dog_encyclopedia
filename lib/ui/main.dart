import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import 'package:cat_dog_encyclopedia/widget/MainPageWidgets.dart';

void main() {
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(new MyApp());
  });
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Cat - Dog Encyclopedia',
      home: new MyHomePage(title: 'Cat - Dog Encyclopedia'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  final String _catLogo = 'assets/images/catlogo.jpg';
  final String _dogLogo = 'assets/images/doglogo.jpg';
  final String _bgImage = 'assets/images/background.jpg';

  AnimationController _animationController;
  Animation _titleAnimation,
      _dogLogoAnimation,
      _catLogoAnimation,
      _typeAnimation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setAnimation();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: _buildBody(),
      resizeToAvoidBottomPadding: false,
    );
  }

  Widget _buildBody() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height >= 775.0
          ? MediaQuery.of(context).size.height
          : 775.0,
      decoration: new BoxDecoration(
        image: new DecorationImage(
            image: new AssetImage(_bgImage), fit: BoxFit.cover),
      ),
      child: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.all(20.0),
                child: titleWidget(_titleAnimation, context)),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: animalWidget(_typeAnimation, _catLogoAnimation, _dogLogoAnimation,_catLogo , _dogLogo, context),
            )
          ],
        ),
      ),
    );
  }

  void setAnimation() {
    _animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    _titleAnimation = CurvedAnimation(
        parent: _animationController,
        curve: Interval(0.0, 0.5, curve: Curves.fastOutSlowIn));
    _dogLogoAnimation = CurvedAnimation(
        parent: _animationController,
        curve: Interval(0.55, 0.85, curve: Curves.fastOutSlowIn));
    _catLogoAnimation = CurvedAnimation(
        parent: _animationController,
        curve: Interval(0.4, 0.7, curve: Curves.fastOutSlowIn));
    _typeAnimation = CurvedAnimation(
        parent: _animationController,
        curve: Interval(0.85, 1.0, curve: Curves.fastOutSlowIn));

    _animationController.forward();
  }
}
