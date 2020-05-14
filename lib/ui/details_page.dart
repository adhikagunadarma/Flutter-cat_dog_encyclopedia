import 'package:cat_dog_encyclopedia/extra/DotsIndicator.dart';
import 'package:cat_dog_encyclopedia/model/Cat.dart';
import 'package:cat_dog_encyclopedia/model/Dog.dart';
import 'package:cat_dog_encyclopedia/style/theme.dart' as Theme;
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_networkimage/flutter_advanced_networkimage.dart';
import 'package:flutter_advanced_networkimage/transition_to_image.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flare_flutter/flare_actor.dart';

class DetailsPage extends StatefulWidget {
  final Cat cat;
  final Dog dog;
  final String type;

  const DetailsPage({
    @required this.cat,
    this.dog,
    this.type,
  }) : assert(type != null);

  @override
  State<StatefulWidget> createState() => new _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  static const _kDuration = const Duration(milliseconds: 300);

  static const _kCurve = Curves.ease;

  static double _dotSize;

  static double _bodyContainerHeight;
  static double _bodyContainerWidth;

  static double _appBarIconSize;
  static double _appBarFontSize;

  static double _lineContainerSize;

  static double _bottomBarHeight;

  static double _topContainerHeight;
  static double _bottomContainerHeight;
  static double _middleContainerHeight;
  static double _titleFontSize;
  static double _valueFontSize;
  static double _miscFontSize;
//  static double _borderRadius;
  static double _15paddingSize;
  static double _08paddingSize;
  static double _topContainerTopMarginSize;
  static double _topContainerBorderRadius;

  static double _imageBorderRadius;
  static double _bottomContainerBorderRadius;

  static double _bottomContainerMainDataPaddingTop;
  static double _bottomContainerMainDataPaddingBottom;
  static double _bottomContainerMainDataPaddingLeft;
  static double _bottomContainerMainDataPaddingRight;
  static double _bottomContainerMainDataTitleWidth;

  static double _bottomContainerMainExtraPaddingTop;
  static double _bottomContainerMainExtraPaddingBottom;
  static double _bottomContainerMainExtraPaddingLeft;
  static double _bottomContainerMainExtraPaddingRight;

  static double _bottomContainerPositionFromTop;
  static double _bottomContainerPositionFromBottom;
  static double _bottomContainerPositionFromLeft;
  static double _bottomContainerPositionFromRight;

  static double _topContainerPositionFromTop;
  static double _topContainerPositionFromBottom;
  static double _topContainerPositionFromLeft;
  static double _topContainerPositionFromRight;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final _topController = new PageController();
  final _bottomController = new PageController();

  @override
  Widget build(BuildContext context) {
    setSize();

    List<Widget> _images = widget.type == "cats"
        ? <Widget>[
      _detailsImageContainer(widget.cat.imageRef),
      _detailsImageContainer(widget.cat.imageRef2),
    ]
        : <Widget>[
      _detailsImageContainer(widget.dog.imageRef),
      _detailsImageContainer(widget.dog.imageRef2),
    ];

    List<Widget> _pages = widget.type == "cats"
        ? <Widget>[
            _detailsBottomContainerMain(
              widget.cat.lifespan,
              widget.cat.size,
              widget.cat.about,
            ),
            _detailsBottomContainerExtra("Personality", widget.cat.personality),
            _detailsBottomContainerExtra("Care", widget.cat.care),
            _detailsBottomContainerExtra("Environment", widget.cat.environment),
            _detailsBottomContainerExtra("Grooming", widget.cat.grooming),
            _detailsBottomContainerExtra("Health", widget.cat.health),
          ]
        : <Widget>[
            _detailsBottomContainerMain(
              widget.dog.lifespan,
              widget.dog.size,
              widget.dog.about,
            ),
            _detailsBottomContainerExtra("Nutrition", widget.dog.nutrition),
            _detailsBottomContainerExtra("Training", widget.dog.training),
            _detailsBottomContainerExtra("Exercise", widget.dog.exercise),
            _detailsBottomContainerExtra("Grooming", widget.dog.grooming),
            _detailsBottomContainerExtra("Health", widget.dog.health),
          ];

    String name = widget.type == "cats" ? widget.cat.name : widget.dog.name;

    return Scaffold(
      backgroundColor: Theme.Colors.primaryColor,
      appBar: _buildAppBar(name, widget.type),
      key: _scaffoldKey,
      body: _buildBody(_pages, _images),
//      bottomNavigationBar: _buildBottomBar(_bottomBarSize),

      resizeToAvoidBottomPadding: false,
    );
  }

  void checkConnection() async {
    var connectivityResult = await (new Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      showInSnackBar("No internet connection detected");
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    checkConnection();
    super.initState();
  }

  //berdasarkan width
  void setSize() {
    _bodyContainerWidth =
        MediaQuery.of(context).size.width; //container whole page width
    _bodyContainerHeight = MediaQuery.of(context).size.height >=
            775.0 //  container whole page height
        ? MediaQuery.of(context).size.height
        : 775.0;

    _appBarIconSize =
        MediaQuery.of(context).size.width / 20.55; //app bar icon size/height
    _appBarFontSize =
        MediaQuery.of(context).size.width / 20.55; //app bar icon size/height
    _lineContainerSize = MediaQuery.of(context).size.width / 20.55;

    _bottomBarHeight = MediaQuery.of(context).size.height /
        13.66; //bottom bar size/height if any

    _dotSize =
        MediaQuery.of(context).size.width / 51.375; //dot size on the middle

    _topContainerHeight = 0.45 *
        MediaQuery.of(context).size.height; //top/image container size/height
    _bottomContainerHeight = 0.55 *
        MediaQuery.of(context)
            .size
            .height; //bottom/details container size/height
    _middleContainerHeight = MediaQuery.of(context).size.height/13.66;

    _titleFontSize = MediaQuery.of(context).size.width /
        28.345; //title font size like name, and mostly the referenca value
    _valueFontSize = MediaQuery.of(context).size.width /
        34.25; //value of the reference font size

    _miscFontSize =
        MediaQuery.of(context).size.width / 27.4; //snacckbar font size
    _15paddingSize = MediaQuery.of(context).size.width / 27.4; //15.0 padding
    _08paddingSize = MediaQuery.of(context).size.width / 51.375; //8.0 padding

    _topContainerBorderRadius =
        MediaQuery.of(context).size.width / 8.22; //radius for top container
    _topContainerTopMarginSize = MediaQuery.of(context).size.width /
        41.1; //top margin from top container
//    _imageWidth = MediaQuery.of(context).size.width; //image width
//    _imageHeight = MediaQuery.of(context).size.height >= //image height
//            MediaQuery.of(context).size.height / 2.732
//        ? MediaQuery.of(context).size.height / 2.732
//        : MediaQuery.of(context).size.height;
    _imageBorderRadius = MediaQuery.of(context).size.width /
        8.22; //image border radius, should be same as top container

    _bottomContainerBorderRadius =
        MediaQuery.of(context).size.width / 8.22; //radius for bottom container

    //margin for bottom container with main DATA within, the range from edge to text ///Lifespan,About,etc
    _bottomContainerMainDataPaddingBottom =
        MediaQuery.of(context).size.width / 82.2;
    _bottomContainerMainDataPaddingTop =
        MediaQuery.of(context).size.width / 82.2;
    _bottomContainerMainDataPaddingLeft =
        MediaQuery.of(context).size.width / 27.4;
    _bottomContainerMainDataPaddingRight =
        MediaQuery.of(context).size.width / 27.4;

    _bottomContainerMainDataTitleWidth = MediaQuery.of(context).size.width /
        5.043; //container for reference type

    //margin for bottom container with main EXTRA within, the range from edge to text ///The Rest
    _bottomContainerMainExtraPaddingBottom =
        MediaQuery.of(context).size.width / 27.4;
    _bottomContainerMainExtraPaddingTop =
        MediaQuery.of(context).size.width / 27.4;
    _bottomContainerMainExtraPaddingLeft =
        MediaQuery.of(context).size.width / 13.7;
    _bottomContainerMainExtraPaddingRight =
        MediaQuery.of(context).size.width / 13.7;

    //position for bottom container so it should be below middle container
    _bottomContainerPositionFromTop = MediaQuery.of(context).size.height / 18.9;
    _bottomContainerPositionFromLeft = 0.0;
    _bottomContainerPositionFromRight = 0.0;
    _bottomContainerPositionFromBottom =
        MediaQuery.of(context).size.height / 13.66;

    _topContainerPositionFromTop = MediaQuery.of(context).size.height / 2.56;
    _topContainerPositionFromLeft = 0.0;
    _topContainerPositionFromRight = 0.0;
    _topContainerPositionFromBottom = 0.0;
  }

  // berdasarkan height
//  void setSize() {
//    _bodyContainerWidth = MediaQuery.of(context).size.width; //container whole page width
//    _bodyContainerHeight = MediaQuery.of(context).size.height >= 775.0 //  container whole page height
//        ? MediaQuery.of(context).size.height
//        : 775.0;
//
//    _appBarIconSize = MediaQuery.of(context).size.height / 34.15; //app bar icon size/height
//    _appBarFontSize = MediaQuery.of(context).size.height / 34.15; //app bar icon size/height
//    _lineContainerSize = MediaQuery.of(context).size.height / 34.15;
//
//    _bottomBarHeight = MediaQuery.of(context).size.height / 13.66; //bottom bar size/height if any
//
//    _dotSize = MediaQuery.of(context).size.height / 85.375; //dot size on the middle
//
//    _middleContainerHeight = 0.1 * MediaQuery.of(context).size.height; //middle/dot container size/height
//    _topContainerHeight = 0.4 * MediaQuery.of(context).size.height; //top/image container size/height
//    _bottomContainerHeight = 0.6 * MediaQuery.of(context).size.height; //bottom/details container size/height
//
//    _titleFontSize = MediaQuery.of(context).size.height / 47.0; //title font size like name, and mostly the referenca value
//    _valueFontSize = MediaQuery.of(context).size.height / 56.92; //value of the reference font size
//
//    _miscFontSize =
//        MediaQuery.of(context).size.height / 45.5333; //snacckbar font size
//    _15paddingSize = MediaQuery.of(context).size.height / 45.5333; //15.0 padding
//    _08paddingSize = MediaQuery.of(context).size.height / 85.375; //8.0 padding
//
//    _topContainerBorderRadius = MediaQuery.of(context).size.height / 13.66; //radius for top container
//    _topContainerTopMarginSize = MediaQuery.of(context).size.height / 68.3; //top margin from top container
//    _imageWidth = MediaQuery.of(context).size.width; //image width
//    _imageHeight = MediaQuery.of(context).size.height >= //image height
//        MediaQuery.of(context).size.height / 2.732
//        ? MediaQuery.of(context).size.height / 2.732
//        : MediaQuery.of(context).size.height;
//    _imageBorderRadius = MediaQuery.of(context).size.height / 13.66; //image border radius, should be same as top container
//
//    _bottomContainerBorderRadius = MediaQuery.of(context).size.height / 13.66; //radius for bottom container
//
//    //margin for bottom container with main DATA within, the range from edge to text ///Lifespan,About,etc
//    _bottomContainerMainDataPaddingBottom =
//        MediaQuery.of(context).size.height / 136.6;
//    _bottomContainerMainDataPaddingTop =
//        MediaQuery.of(context).size.height / 136.6;
//    _bottomContainerMainDataPaddingLeft =
//        MediaQuery.of(context).size.height / 45.533;
//    _bottomContainerMainDataPaddingRight =
//        MediaQuery.of(context).size.height / 45.533;
//
//    _bottomContainerMainDataTitleWidth =
//        MediaQuery.of(context).size.height / 8.3833; //container for reference type
//
//
//    //margin for bottom container with main EXTRA within, the range from edge to text ///The Rest
//    _bottomContainerMainExtraPaddingBottom =
//        MediaQuery.of(context).size.height / 45.533;
//    _bottomContainerMainExtraPaddingTop =
//        MediaQuery.of(context).size.height / 45.533;
//    _bottomContainerMainExtraPaddingLeft =
//        MediaQuery.of(context).size.height / 22.7;
//    _bottomContainerMainExtraPaddingRight =
//        MediaQuery.of(context).size.height / 22.7;
//
//    //position for bottom container so it should be below middle container
//    _bottomContainerPositionFromTop = MediaQuery.of(context).size.height / 9.76;
//    _bottomContainerPositionFromLeft = 0.0;
//    _bottomContainerPositionFromRight = 0.0;
//    _bottomContainerPositionFromBottom =
//        MediaQuery.of(context).size.height / 13.66;
//
//    _chevronLeftMarginLeft = MediaQuery.of(context).size.height / 68.3;
//    _chevronLeftMarginTop = MediaQuery.of(context).size.height  /5.464;
//    _chevronRightMarginLeft =  MediaQuery.of(context).size.height  / 1.81;
//    _chevronRightMarginTop = MediaQuery.of(context).size.height  /5.464;
//  }

  void showInSnackBar(String value) {
    FocusScope.of(context).requestFocus(new FocusNode());
    _scaffoldKey.currentState?.removeCurrentSnackBar();
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(
        value,
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Colors.black,
            fontSize: _miscFontSize,
            letterSpacing: 1.5,
            fontWeight: FontWeight.w500,
            fontFamily: Theme.Font.primaryFont),
      ),
      backgroundColor: Theme.Colors.thirdColor.withOpacity(0.8),
      duration: Duration(seconds: 3),
    ));
  }

  Widget _buildAppBar(name, _type) {
    return new AppBar(
      elevation: 5.0,
      leading: new Icon(
        _type == "cats" ? FontAwesomeIcons.cat : FontAwesomeIcons.dog,
        color: Colors.black,
        size: _appBarIconSize,
      ),
      title: new Text(
        name,
        style: TextStyle(
            color: Colors.black,
            letterSpacing: 1.5,
            fontWeight: FontWeight.w500,
            fontFamily: Theme.Font.secondaryFont,
            fontSize: _appBarFontSize),
      ),
      backgroundColor: Theme.Colors.primaryColor.withOpacity(0.8),
    );
  }

  Widget _buildBody(
    pages,
    images,
  ) {
    return Container(
      width: _bodyContainerWidth,
      height: _bodyContainerHeight,
      decoration: new BoxDecoration(
        gradient: new LinearGradient(
            colors: [
              Theme.Colors.primaryColor,
              Theme.Colors.secondaryColor,
//                Theme.Colors.thirdColor,
            ],
            begin: const FractionalOffset(0.0, 0.0),
            end: const FractionalOffset(1.0, 1.0),
//              stops: [0.333,0.667, 1.0],
            stops: [0.4, 1.0],
            tileMode: TileMode.clamp),
//            color: Theme.Colors.secondaryColor
      ),
      child: SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              _topContainer(
                images
              ),
              _bottomContainer(pages)
            ]),
      ),
    );
  }

  Widget _buildBottomBar() {
    return BottomAppBar(
      color: Theme.Colors.thirdColor.withOpacity(0.8),
      elevation: 0.0,
      child: new Container(
        height: _bottomBarHeight,
      ),
    );
  }

  Widget _detailsImageContainer(String imageRef){
    return Padding(
      padding:  EdgeInsets.all(_15paddingSize),
      child: Container(
        margin: EdgeInsets.only(top: _topContainerTopMarginSize),
        decoration: BoxDecoration(
          borderRadius:
          BorderRadius.all(Radius.circular(_topContainerBorderRadius)),
//            shape: BoxShape.circle, //kalo dibuletin ke crop :(

          boxShadow: [
            new BoxShadow(
              offset: Offset(1.0, 3.0),
              color: Colors.black,
              blurRadius: 5.0,
            ),
            new BoxShadow(
              offset: Offset(0.0, 0.0),
              color: Theme.Colors.primaryColor.withOpacity(0.8),
              blurRadius: 5.0,
            ),
          ],
        ),
        height: _topContainerHeight,
        width: _bodyContainerWidth,
        child: ClipRRect(
          borderRadius:
          BorderRadius.all(Radius.circular(_imageBorderRadius)),
          child: TransitionToImage(
            AdvancedNetworkImage(imageRef,
                timeoutDuration: Duration(minutes: 1),
                useDiskCache: true, loadFailedCallback: () {
                  showInSnackBar("Failed to Load the image");
                }, loadedCallback: () {
                  ///if successful
                  ///showInSnackBar("Success load image");
                }),

            loadingWidget: FlareActor(
              "assets/animations/loading.flr",
              animation: "loadingPaw",
              alignment: Alignment.center,
              color: Colors.black,
              fit: BoxFit.fill,
            ),
            // This is default duration
            height: _topContainerHeight,
            width: _bodyContainerWidth,
            duration: Duration(milliseconds: 300),
            fit: BoxFit.fill,
            placeholder: const Icon(Icons.error),
          ),
        ),
      ),
    );
  }

  ///ini nutrition,dsbdsb
  Widget _detailsBottomContainerExtra(String title, String data) {
    return Padding(
      ///buat jarak dari ujung layar dengan container
      padding: EdgeInsets.all(_15paddingSize),
      child: Stack(
        children: <Widget>[
          Container(
            height: _bottomContainerHeight * 0.9,
            width: _bodyContainerWidth,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                  Radius.circular(_bottomContainerBorderRadius)),
              color: Theme.Colors.thirdColor.withOpacity(1.0),
              boxShadow: [
                new BoxShadow(
                  offset: Offset(1.0, 2.0),
                  color: Colors.black,
                  blurRadius: 5.0,
                ),
                new BoxShadow(
                  offset: Offset(0.0, 0.0),
                  color: Theme.Colors.primaryColor.withOpacity(0.8),
                  blurRadius: 5.0,
                ),
              ],
            ),
            child: Row(
              children: <Widget>[
                Container(
                  child: Icon(
                    FontAwesomeIcons.chevronLeft,
                    color: Colors.black.withOpacity(0.2),
                    size: _appBarIconSize,
                  ),
                ),
                Flexible(
                  fit: FlexFit.loose,
                  child: SizedBox(
                    height: _bottomContainerHeight,
                    width: _bodyContainerWidth,
                    child: Padding(
                      ///buat jarak antara ujung container dengan batas
                      padding: EdgeInsets.all(_15paddingSize),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Padding(
                              ///buat jarak dari batas(kiri kanan) dengan text
                              padding: EdgeInsets.fromLTRB(
                                  _bottomContainerMainExtraPaddingLeft,
                                  _bottomContainerMainExtraPaddingTop,
                                  _bottomContainerMainExtraPaddingRight,
                                  _bottomContainerMainExtraPaddingBottom),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    decoration: BoxDecoration(
                                      gradient: new LinearGradient(
                                          colors: [
                                            Colors.black.withOpacity(0.0),
                                            Colors.black.withOpacity(0.3),
                                          ],
                                          begin:
                                              const FractionalOffset(0.0, 0.0),
                                          end: const FractionalOffset(1.0, 1.0),
                                          stops: [0.0, 1.0],
                                          tileMode: TileMode.clamp),
                                    ),
                                    width: _lineContainerSize,
                                    height: 1.0,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: _08paddingSize,
                                        right: _08paddingSize),
                                    child: Text(
                                      title,
                                      style: TextStyle(
                                        fontSize: _titleFontSize,
                                        letterSpacing: 1.5,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: Theme.Font.primaryFont,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      gradient: new LinearGradient(
                                          colors: [
                                            Colors.black.withOpacity(0.3),
                                            Colors.black.withOpacity(0.0),
                                          ],
                                          begin:
                                              const FractionalOffset(0.0, 0.0),
                                          end: const FractionalOffset(1.0, 1.0),
                                          stops: [0.0, 1.0],
                                          tileMode: TileMode.clamp),
                                    ),
                                    width: _lineContainerSize,
                                    height: 1.0,
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(
                                  _bottomContainerMainExtraPaddingLeft,
                                  _bottomContainerMainExtraPaddingTop,
                                  _bottomContainerMainExtraPaddingRight,
                                  _bottomContainerMainExtraPaddingBottom),
                              child: Text(
                                data,
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: _valueFontSize,
                                  letterSpacing: 1.5,
                                  fontFamily: Theme.Font.primaryFont,
                                  wordSpacing: 2.0,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                title != "Health"
                    ? Container(
                        child: Icon(
                          FontAwesomeIcons.chevronRight,
                          color: Colors.black.withOpacity(0.2),
                          size: _appBarIconSize,
                        ),
                      )
                    : Container(
                        child: Icon(
                          FontAwesomeIcons.chevronRight,
                          color: Colors.black.withOpacity(0.0),
                          size: _appBarIconSize,
                        ),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  ///container untuk lifespan ,about dan size
  Widget _detailsBottomContainerMain(
      String dataLifespan, String dataSize, String dataAbout) {
    List<String> explode = dataSize.split(';');
    String size = '';
    explode.forEach((value) => size = size + "\n" + value + "\n");

    ///buat jarak antara ujung layar dengan container
    return Padding(
      padding: EdgeInsets.all(_15paddingSize),
      child: Container(
        height: _bottomContainerHeight * 0.9,
        width: _bodyContainerWidth,
        decoration: BoxDecoration(
            color: Theme.Colors.thirdColor.withOpacity(1.0),
            boxShadow: [
              new BoxShadow(
                offset: Offset(1.0, 2.0),
                color: Colors.black,
                blurRadius: 5.0,
              ),
              new BoxShadow(
                offset: Offset(0.0, 0.0),
                color: Theme.Colors.primaryColor.withOpacity(0.8),
                blurRadius: 5.0,
              ),
            ],
            borderRadius: BorderRadius.all(
                Radius.circular(_bottomContainerBorderRadius))),
        child: Row(
          children: <Widget>[
            Container(
              child: Icon(
                FontAwesomeIcons.chevronLeft,
                color: Colors.black.withOpacity(0.0),
                size: _appBarIconSize,
              ),
            ),
            Flexible(
              fit: FlexFit.loose,
              child: SizedBox(
                height: _bottomContainerHeight,
                width: _bodyContainerWidth,
                child: Padding(
                  ///buat jarak antara ujung layar dengan container
                  padding: EdgeInsets.all(_15paddingSize),
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        Padding(
                          ///buat jarak dari batas(kiri kanan) dengan text
                          padding: EdgeInsets.fromLTRB(
                              _bottomContainerMainExtraPaddingLeft,
                              _bottomContainerMainExtraPaddingTop,
                              _bottomContainerMainExtraPaddingRight,
                              _bottomContainerMainExtraPaddingBottom),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                decoration: BoxDecoration(
                                  gradient: new LinearGradient(
                                      colors: [
                                        Colors.black.withOpacity(0.0),
                                        Colors.black.withOpacity(0.3),
                                      ],
                                      begin: const FractionalOffset(0.0, 0.0),
                                      end: const FractionalOffset(1.0, 1.0),
                                      stops: [0.0, 1.0],
                                      tileMode: TileMode.clamp),
                                ),
                                width: _lineContainerSize,
                                height: 1.0,
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: _08paddingSize,
                                    right: _08paddingSize),
                                child: Text(
                                  "Basic Info",
                                  style: TextStyle(
                                    fontSize: _titleFontSize,
                                    letterSpacing: 1.5,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: Theme.Font.primaryFont,
                                  ),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  gradient: new LinearGradient(
                                      colors: [
                                        Colors.black.withOpacity(0.3),
                                        Colors.black.withOpacity(0.0),
                                      ],
                                      begin: const FractionalOffset(0.0, 0.0),
                                      end: const FractionalOffset(1.0, 1.0),
                                      stops: [0.0, 1.0],
                                      tileMode: TileMode.clamp),
                                ),
                                width: _lineContainerSize,
                                height: 1.0,
                              ),
                            ],
                          ),
                        ),
                        _detailsBottomContainerMainData(
                            "Lifespan", dataLifespan),
                        _detailsBottomContainerMainData("Size", size),
                        _detailsBottomContainerMainData("About", dataAbout),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Container(
              child: Icon(
                FontAwesomeIcons.chevronRight,
                color: Colors.black.withOpacity(0.2),
                size: _appBarIconSize,
              ),
            ),
          ],
        ),
      ),
    );
  }

  ///data dari lifespan,about,dsb
  Widget _detailsBottomContainerMainData(String title, String data) {
    return Padding(
      ///jarak(kiri kanan) antara batas dengan text
      padding: EdgeInsets.fromLTRB(
          _bottomContainerMainDataPaddingLeft,
          _bottomContainerMainDataPaddingTop,
          _bottomContainerMainDataPaddingRight,
          _bottomContainerMainDataPaddingBottom),
      child: ListTile(
        title: Text(
          data,
          style: TextStyle(
              fontSize: _valueFontSize,
              letterSpacing: 1.5,
              fontWeight: FontWeight.w500,
              fontFamily: Theme.Font.primaryFont),
          textAlign: TextAlign.start,
        ),
        leading: Container(
          width: _bottomContainerMainDataTitleWidth,
          child: new Text(
            title,
            style: TextStyle(
              fontSize: _titleFontSize,
              letterSpacing: 1.5,
              fontWeight: FontWeight.w500,
              fontFamily: Theme.Font.primaryFont,
            ),
          ),
        ),
      ),
    );
  }

  Widget _detailsTopContainer(images) {
    return Stack(
      children: <Widget>[
        Container(
          height : _topContainerHeight *0.9,
          child: new PageView.builder(
              physics: new AlwaysScrollableScrollPhysics(),
              controller: _topController,
              itemCount: 2,
              itemBuilder: (BuildContext context, int index) {
                return images[index % images.length];
              }),
        ),
        Positioned(
            top: _topContainerPositionFromTop,
            right: _topContainerPositionFromRight,
            left: _topContainerPositionFromLeft,
            bottom: _topContainerPositionFromBottom,
            child: _middleTopContainer())
      ],
    );
  }

  Widget _middleTopContainer() {
    return Container(
      height: _middleContainerHeight,
      child: new Center(
        child: new DotsIndicator(
          kDotSize: _dotSize,
          controller: _topController,
          itemCount: 2,
          onPageSelected: (int page) {
            _topController.animateToPage(
              page,
              duration: _kDuration,
              curve: _kCurve,
            );
          },
        ),
      ),
    );
  }

  Widget _middleBottomContainer() {
    return Container(
      height: _middleContainerHeight,
      child: new Center(
        child: new DotsIndicator(
          kDotSize: _dotSize,
          controller: _bottomController,
          itemCount: 6,
          onPageSelected: (int page) {
            _bottomController.animateToPage(
              page,
              duration: _kDuration,
              curve: _kCurve,
            );
          },
        ),
      ),
    );
  }

  Widget _topContainer(images) {
    return Container(
      height: _topContainerHeight,
      child: _detailsTopContainer(
          images
      ),
    );
  }

  Widget _bottomContainer(pages) {
    return Container(
      height: _bottomContainerHeight,
      child: Stack(
        children: <Widget>[
          Positioned(
            top: _bottomContainerPositionFromTop,
            right: _bottomContainerPositionFromLeft,
            left: _bottomContainerPositionFromRight,
            bottom: _bottomContainerPositionFromBottom,
            child: new PageView.builder(
                physics: new AlwaysScrollableScrollPhysics(),
                controller: _bottomController,
                itemCount: 6,
                itemBuilder: (BuildContext context, int index) {
                  return pages[index % pages.length];
                }),
          ),
          _middleBottomContainer()
        ],
      ),
    );
  }
}
