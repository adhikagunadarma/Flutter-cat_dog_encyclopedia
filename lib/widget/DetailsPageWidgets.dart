import 'package:flutter/material.dart';

final String _valueFontFamily = "MaliMedium";
final String _titleFontFamily = "MaliSemiBold";
final double _titleFontSize = 13.0;
final double _valueFontSize = 12.0;

final double _widthThreshold = 500.0;
final double _heightThreshold = 250.0;

final double _borderRadius = 30.0;

Widget detailsTopWidget(
    String imageTitle, String imageRef, BuildContext context) {
  return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(_borderRadius))),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height >= _heightThreshold
          ? _heightThreshold
          : MediaQuery.of(context).size.height,

        child: ClipRRect(
          borderRadius: new BorderRadius.circular(_borderRadius),
          child: new Image.asset(
            '${imageRef}',
            width: MediaQuery.of(context).size.width <= _widthThreshold
                ? _widthThreshold
                : MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height <= _heightThreshold
                ? _heightThreshold
                : MediaQuery.of(context).size.width,
            fit: BoxFit.fill,
          ),
        ));
}

Widget detailsMiddleWidget(String text_title, String text_value) {
  return ListTile(
    title: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        "${text_value}",
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
        text_title,
        style: TextStyle(
          fontSize: _titleFontSize,
          fontFamily: _titleFontFamily,
        ),
      ),
    ),
  );
}

Widget detailsBottomWidget(String text_title, String text_value, int color) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Card(
      color: Color(color),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(_borderRadius),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "${text_title}",
              style: TextStyle(
                fontSize: _titleFontSize,
                fontFamily: _titleFontFamily,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  "${text_value}",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: _valueFontSize,
                      fontFamily: _valueFontFamily),
                  textAlign: TextAlign.justify,
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
