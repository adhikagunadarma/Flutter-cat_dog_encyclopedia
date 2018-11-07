import 'package:flutter/material.dart';

final String _valueFontFamily = "MaliMedium";
final String _titleFontFamily = "MaliSemiBold";
final double _titleFontSize = 13.0;
final double _valueFontSize = 12.0;

final double _widthThreshold = 500.0;
final double _heightThreshold = 250.0;

final double _borderRadius = 30.0;

Widget detailsTopContainer(
    String imageTitle, String imageRef, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(_borderRadius))),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height >= _heightThreshold
            ? _heightThreshold
            : MediaQuery.of(context).size.height,

          child: ClipRRect(
            borderRadius: new BorderRadius.circular(_borderRadius),
            child: new Image.asset(
              imageRef,
              width: MediaQuery.of(context).size.width <= _widthThreshold
                  ? _widthThreshold
                  : MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height <= _heightThreshold
                  ? _heightThreshold
                  : MediaQuery.of(context).size.width,
              fit: BoxFit.fill,
            ),
          )),
  );
}

Widget detailsBottomContainerMainData(String title, String data) {
  return ListTile(
    title: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        data,
        style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: _valueFontSize,
            fontFamily: _valueFontFamily),
        textAlign: TextAlign.justify,
      ),
    ),
    leading: Container(
      width: 60.0,
      child: new Text(
        title,
        style: TextStyle(
          fontSize: _titleFontSize,
          fontFamily: _titleFontFamily,
        ),
      ),
    ),
  );
}

Widget detailsBottomContainerMain(String dataLifespan, String dataSize, String dataAbout){
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(_borderRadius),
      ),
      color: Color(0xFFe0dce0),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            detailsBottomContainerMainData("Lifespan", dataLifespan),
            detailsBottomContainerMainData("Size", dataSize),
            detailsBottomContainerMainData("About", dataAbout),
          ],
        ),
      ),
    ),
  );
}

Widget detailsBottomContainerExtra(String title, String data, int color) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Card(
      color: Color(color),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(_borderRadius),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                title,
                style: TextStyle(
                  fontSize: _titleFontSize,
                  fontFamily: _titleFontFamily,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                data,
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: _valueFontSize,
                    fontFamily: _valueFontFamily),
                textAlign: TextAlign.justify,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
