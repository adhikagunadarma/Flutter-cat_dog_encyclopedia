import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import 'package:cat_dog_encyclopedia/extra/GoogleAds.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:cat_dog_encyclopedia/style/theme.dart' as Theme;
import 'package:cat_dog_encyclopedia/ui/list_animals.dart';

final double _borderRadiusTitle = 50.0;
final double _borderRadiusLogo = 75.0;
final double _borderRadiusType = 10.0;




class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title,}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  final String _catLogo = 'assets/images/catlogo.jpg';
  final String _dogLogo = 'assets/images/doglogo.jpg';

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

    bannerAd = GoogleAds.buildBanner()..load();
    interstitialAd = GoogleAds.buildInterstitial()..load();
    super.initState();
    setAnimation();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    bannerAd?.dispose();
    interstitialAd?.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    bannerAd?.show(
//      anchorType: AnchorType.top
    );
    return new WillPopScope(
      onWillPop: _onWillPop,
      child: new Scaffold(
        body: _buildBody(),
        resizeToAvoidBottomPadding: false,
        bottomNavigationBar: BottomAppBar(
          child: new Container(
            color: Theme.Colors.secondaryColor,
            height: 50.0,
          ),
        ),
      ),
    );
  }

  Widget _buildBody() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height >= 775.0
          ? MediaQuery.of(context).size.height
          : 775.0,
      decoration: new BoxDecoration(
//        image: new DecorationImage(
//            image: new AssetImage(Theme.Image.bgImage),
//            fit: BoxFit.cover
//        ),
          color: Theme.Colors.secondaryColor
      ),
      child: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.all(20.0),
                child: titleWidget(_titleAnimation)),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: animalWidget(_typeAnimation, _catLogoAnimation, _dogLogoAnimation,_catLogo , _dogLogo,),
            )
          ],
        ),
      ),
    );
  }

  Widget titleWidget(Animation animation){
    return FadeTransition(
      opacity: animation,
      child: Container(
        decoration: new BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(_borderRadiusTitle)),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Theme.Colors.primaryColor.withOpacity(1.0),
              offset: Offset(1.0, 6.0),
              blurRadius: 20.0,
            ),
            BoxShadow(
              color: Theme.Colors.primaryColor.withOpacity(1.0),
              offset: Offset(1.0, 6.0),
              blurRadius: 20.0,
            ),
          ],
          gradient: new RadialGradient(
              colors: [
                Theme.Colors.secondaryColor.withOpacity(1.0).withOpacity(1.0),
                Theme.Colors.secondaryColor.withOpacity(1.0).withOpacity(1.0)
              ],
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: <Widget>[
              Center(
                child: new Text(
                  "Select",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height >=
                          MediaQuery.of(context).size.width
                          ? MediaQuery.of(context).size.height / 20
                          : MediaQuery.of(context).size.width / 20,
                      fontFamily: Theme.Font.bold,
                      color: Colors.black
                  ),
                ),

              ),
              Center(
                child: new Text(
                  "Encyclopedia",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height >=
                          MediaQuery.of(context).size.width
                          ? MediaQuery.of(context).size.height / 20
                          : MediaQuery.of(context).size.width / 20,
                      fontFamily: Theme.Font.bold,
                      color: Colors.black
                  ),
                ),

              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget animalWidget(Animation typeAnimation, Animation catLogoAnimation, Animation dogLogoAnimation, String catLogo, String dogLogo, ){
    return Row(
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
              animalLogoWidget("Cat Encyclopedia", catLogo,
                  catLogoAnimation),
              animalTypeWidget("Cat", typeAnimation),
            ],
          ),
        ),
        Padding(
            padding: const EdgeInsets.all(8.0),
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
                  animalLogoWidget("Dog Encyclopedia",
                      dogLogo, dogLogoAnimation),
                  animalTypeWidget("Dog", typeAnimation),
                ],
              ),
            )),
      ],
    );
  }



  Widget animalLogoWidget(String name, String image,  Animation animation){
    return RotationTransition(
      turns: animation,
      child: ScaleTransition(
        scale: animation,
        child: FadeTransition(
          opacity: animation,
          child: Card(
            color: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(_borderRadiusLogo),
            ),
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(_borderRadiusLogo),
                child: new Image(
                  width: MediaQuery.of(context).size.height >=
                      MediaQuery.of(context).size.width
                      ? MediaQuery.of(context).size.height / 5
                      : MediaQuery.of(context).size.width / 5,
                  height: MediaQuery.of(context).size.height >=
                      MediaQuery.of(context).size.width
                      ? MediaQuery.of(context).size.height / 5
                      : MediaQuery.of(context).size.width / 5,
                  image: AssetImage(image),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget animalTypeWidget(String name, Animation animation){

    return ScaleTransition(
      scale: animation,
      child: FadeTransition(
        opacity: animation,
        child: Container(
          height:  MediaQuery.of(context).size.height >=
              MediaQuery.of(context).size.width
              ? MediaQuery.of(context).size.height / 23
              : MediaQuery.of(context).size.width / 23,
          width :  MediaQuery.of(context).size.height >=
              MediaQuery.of(context).size.width
              ? MediaQuery.of(context).size.height / 10
              : MediaQuery.of(context).size.width / 10,
          margin: EdgeInsets.fromLTRB(
              MediaQuery.of(context).size.height >=
                  MediaQuery.of(context).size.width
                  ? MediaQuery.of(context).size.height / 17
                  : MediaQuery.of(context).size.width / 17,
              MediaQuery.of(context).size.height >=
                  MediaQuery.of(context).size.width
                  ? MediaQuery.of(context).size.height / 4.5
                  : MediaQuery.of(context).size.width / 4.5,
              0.0,
              0.0),
          decoration: new BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(_borderRadiusType)),
              color: Colors.white,
              border: Border.all(color : Colors.black)

          ),
          child: MaterialButton(

            child: Text(
              name,
              style: TextStyle(
                  color: Colors.black,
                  fontSize:  MediaQuery.of(context).size.height >=
                      MediaQuery.of(context).size.width
                      ? MediaQuery.of(context).size.height / 45
                      : MediaQuery.of(context).size.width / 45,
                  fontFamily: Theme.Font.semiBold),
            ), onPressed: () {},
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
              interstitialAd?.show();
              Navigator.of(context).pop(true);
            } ,
            child: new Text('Yes'),
          ),
        ],
      ),
    ) ?? false;
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


