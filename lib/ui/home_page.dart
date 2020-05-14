import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import 'package:cat_dog_encyclopedia/extra/GoogleAds.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:cat_dog_encyclopedia/style/theme.dart' as Theme;
import 'package:cat_dog_encyclopedia/ui/list_animals.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({
    Key key,
    this.title,
  }) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  final String _catLogo = 'assets/images/cat_icon.png';
  final String _dogLogo = 'assets/images/dog_icon.png';

  static double _bodyContainerWidth;
  static double _bodyContainerHeight;

  static double _whiteContainerBorderRadius;
  static double _whiteContainerMargin;

  static double _padding;

  static double _titleFontSize;

  static double _iconSize;

  static double _typeContainerHeight;
  static double _typeContainerWidth;
  static double _typeContainerBorderRadius;
  static double _typeContainerMarginTop;
  static double _typeContainerMarginBottom;
  static double _typeContainerMarginLeft;
  static double _typeContainerMarginRight;
  static double _typeFontSize;

  BannerAd bannerAd;
  InterstitialAd interstitialAd;

  AnimationController _animationController;
  Animation _titleAnimation,
      _dogLogoAnimation,
      _catLogoAnimation,
      _typeAnimation;

  @override
  void initState() {
    // TODO: implement initState
    FirebaseAdMob.instance.initialize(appId: APP_ID);

    if (bannerAd == null) {
      bannerAd = GoogleAds.buildBanner()..load();
    }
    if (interstitialAd == null) {
      interstitialAd = GoogleAds.buildInterstitial()..load();
    }

    super.initState();
    setAnimation();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    bannerAd?.dispose();
    bannerAd = null;
    interstitialAd?.dispose();
    interstitialAd = null;

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    setSize();
    bannerAd?.show();
    return new WillPopScope(
      onWillPop: _onWillPop,
      child: new Scaffold(
        body: _buildBody(),
        resizeToAvoidBottomPadding: false,
      ),
    );
  }

  Widget _buildBody() {
    return Container(
      width: _bodyContainerWidth,
      height: _bodyContainerHeight,
      decoration: new BoxDecoration(
        gradient: new LinearGradient(
            colors: [
              Theme.Colors.primaryColor,
              Theme.Colors.secondaryColor,
            ],
            begin: const FractionalOffset(0.0, 0.0),
            end: const FractionalOffset(1.0, 1.0),
            stops: [0.4, 1.0],
            tileMode: TileMode.clamp),
      ),
      child: new Center(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(
              _whiteContainerBorderRadius,
            )),
            color: Theme.Colors.thirdColor.withOpacity(0.8),
          ),
          margin: EdgeInsets.all(
            _whiteContainerMargin,
          ),
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.all(
                    _padding,
                  ),
                  child: titleWidget(_titleAnimation)),
              Padding(
                padding: EdgeInsets.all(
                  _padding,
                ),
                child: animalWidget(
                  _typeAnimation,
                  _catLogoAnimation,
                  _dogLogoAnimation,
                  _catLogo,
                  _dogLogo,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget titleWidget(Animation animation) {
    return FadeTransition(
      opacity: animation,
      child: Container(
        child: Padding(
          padding: EdgeInsets.all(
            _padding,
          ),
          child: Column(
            children: <Widget>[
              Center(
                child: new Text(
                  "CAT - DOG",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: _titleFontSize,
                      fontFamily: Theme.Font.secondaryFont,
                      letterSpacing: 1.5,
                      fontWeight: FontWeight.w500,
                      color: Colors.black),
                ),
              ),
              Center(
                child: new Text(
                  "ENCYCLOPEDIA",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: _titleFontSize,
                      fontFamily: Theme.Font.secondaryFont,
                      letterSpacing: 1.5,
                      fontWeight: FontWeight.w500,
                      color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget animalWidget(
    Animation typeAnimation,
    Animation catLogoAnimation,
    Animation dogLogoAnimation,
    String catLogo,
    String dogLogo,
  ) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ListAnimalsPage(
                          type: 'cats',
                        )));
          },
          child: Stack(
            children: <Widget>[
              animalLogoWidget("Cat Encyclopedia", catLogo, catLogoAnimation),
              animalTypeWidget("CAT", typeAnimation),
            ],
          ),
        ),
        Padding(
            padding: EdgeInsets.all(_padding),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ListAnimalsPage(
                              type: 'dogs',
                            )));
              },
              child: Stack(
                children: <Widget>[
                  animalLogoWidget(
                      "Dog Encyclopedia", dogLogo, dogLogoAnimation),
                  animalTypeWidget("DOG", typeAnimation),
                ],
              ),
            )),
      ],
    );
  }

  Widget animalLogoWidget(String name, String image, Animation animation) {
    return RotationTransition(
      turns: animation,
      child: ScaleTransition(
        scale: animation,
        child: FadeTransition(
          opacity: animation,
          child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                new BoxShadow(
                  offset: Offset(1.0, 2.0),
                  color: Colors.black,
                  blurRadius: 5.0,
                ),
                new BoxShadow(
                  offset: Offset(0.0, 0.0),
                  color: Theme.Colors.thirdColor.withOpacity(0.8),
                  blurRadius: 5.0,
                ),
              ],
              shape: BoxShape.circle,
              color: Theme.Colors.thirdColor.withOpacity(0.8),
            ),
            child: new Image(
              width: _iconSize,
              height: _iconSize,
              image: AssetImage(image),
              fit: BoxFit.fill,
            ),
          ),
        ),
      ),
    );
  }

  Widget animalTypeWidget(String name, Animation animation) {
    return ScaleTransition(
      scale: animation,
      child: FadeTransition(
        opacity: animation,
        child: Container(
          height: _typeContainerHeight,
          width: _typeContainerWidth,
          margin: EdgeInsets.fromLTRB(
              _typeContainerMarginLeft,
              _typeContainerMarginTop,
              _typeContainerMarginRight,
              _typeContainerMarginBottom),
          decoration: new BoxDecoration(
            borderRadius:
                BorderRadius.all(Radius.circular(_typeContainerBorderRadius)),
            color: Theme.Colors.thirdColor.withOpacity(0.8),
            boxShadow: [
              new BoxShadow(
//                offset: Offset(1.0, 2.0),
                color: Colors.black,
                blurRadius: 5.0,
              ),
              new BoxShadow(
                offset: Offset(0.0, 0.0),
                color: Theme.Colors.thirdColor.withOpacity(1.0),
                blurRadius: 5.0,
              ),
            ],
          ),
          child: MaterialButton(
            child: Text(
              name,
              style: TextStyle(
                  color: Colors.black,
                  letterSpacing: 1.5,
                  fontWeight: FontWeight.w500,
                  fontSize: _typeFontSize,
                  fontFamily: Theme.Font.primaryFont),
            ),
            onPressed: () {},
          ),
        ),
      ),
    );
  }

  Future<bool> _onWillPop() {
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(

                title: new Text('Are you sure?'),
                content: new Text('Do you want to exit App?'),
                actions: <Widget>[
                  new FlatButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: new Text('No'),
                  ),
                  new FlatButton(
                    onPressed: () {
//                      interstitialAd?.show();
                      Navigator.of(context).pop(true);
                    },
                    child: new Text('Yes'),
                  ),
                ],
              ),
        ) ??
        false;
  }

  /// berdasarkan height
//  void setSize() {
//    _bodyContainerWidth = MediaQuery.of(context).size.width;
//    _bodyContainerHeight = MediaQuery.of(context).size.height >= 775.0
//        ? MediaQuery.of(context).size.height
//        : 775.0;
//    _whiteContainerBorderRadius =
//        MediaQuery.of(context).size.height / 9.11; // white container border
//    _whiteContainerMargin =
//        MediaQuery.of(context).size.height / 22.7; // white container margin
//    _padding =
//        MediaQuery.of(context).size.height / 85.375; // overall all padding
//    _titleFontSize =
//        MediaQuery.of(context).size.height / 22.5; // title font size
//    _iconSize = MediaQuery.of(context).size.height / 5; // icon size
//    _typeContainerHeight = MediaQuery.of(context).size.height /
//        23; //container untuk text dibawah icon
//    _typeContainerWidth = MediaQuery.of(context).size.height /
//        7; //container untuk text dibawah icon
//    _typeContainerBorderRadius = MediaQuery.of(context).size.height /
//        68.3; //border radius untuk container di bawah icon
//    _typeContainerMarginLeft = MediaQuery.of(context).size.height /
//        34.2; //margin untuk container di bawah icon
//    _typeContainerMarginTop = MediaQuery.of(context).size.height / 5.5;
//    _typeContainerMarginRight = 0.0;
//    _typeContainerMarginBottom = MediaQuery.of(context).size.height / 142.292;
//    _typeFontSize = MediaQuery.of(context).size.height /
//        45; //font size untuk text dalam container di bawah icon
//  }

  /// berdasarkan width
  void setSize() {
//    print(MediaQuery.of(context).size.height);
//    print(MediaQuery.of(context).size.width);
    _bodyContainerWidth = MediaQuery.of(context).size.width;
    _bodyContainerHeight = MediaQuery.of(context).size.height >= 775.0
        ? MediaQuery.of(context).size.height
        : 775.0;
    _whiteContainerBorderRadius =
        MediaQuery.of(context).size.width / 5.48; // white container border
    _whiteContainerMargin =
        MediaQuery.of(context).size.width / 13.7; // white container margin
    _padding =
        MediaQuery.of(context).size.width / 51.375; // overall all padding
    _titleFontSize =
        MediaQuery.of(context).size.width / 13.7; // title font size
    _iconSize = MediaQuery.of(context).size.width / 3; // icon size
    _typeContainerHeight = MediaQuery.of(context).size.width /
        13.84; //container untuk text dibawah icon
    _typeContainerWidth = MediaQuery.of(context).size.width /
        4.21; //container untuk text dibawah icon
    _typeContainerBorderRadius = MediaQuery.of(context).size.width /
        41.1; //border radius untuk container di bawah icon
    _typeContainerMarginLeft = MediaQuery.of(context).size.width /
        20.55; //margin untuk container di bawah icon
    _typeContainerMarginTop = MediaQuery.of(context).size.width / 3.31;
    _typeContainerMarginRight = 0.0;
    _typeContainerMarginBottom = MediaQuery.of(context).size.width / 85.625;
    _typeFontSize = MediaQuery.of(context).size.width /
        27.075; //font size untuk text dalam container di bawah icon
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
