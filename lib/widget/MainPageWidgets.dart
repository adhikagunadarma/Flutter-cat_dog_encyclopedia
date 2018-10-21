
import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import 'package:cat_dog_encyclopedia/style/theme.dart' as Theme;

import 'package:cat_dog_encyclopedia/ui/list_animals.dart';


final double _borderRadiusTitle = 50.0;
final double _borderRadiusLogo = 75.0;
final double _borderRadiusType = 10.0;

final String _fontFamilyTitle = "MaliBold";
final String _fontFamilyType = "MaliSemiBold";

Widget titleWidget(Animation animation, BuildContext context){
  return FadeTransition(
    opacity: animation,
    child: Container(
      decoration: new BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(_borderRadiusTitle)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Theme.Colors.loginGradientStart,
            offset: Offset(1.0, 6.0),
            blurRadius: 20.0,
          ),
          BoxShadow(
            color: Theme.Colors.loginGradientEnd,
            offset: Offset(1.0, 6.0),
            blurRadius: 20.0,
          ),
        ],
        gradient: new LinearGradient(
            colors: [
              Theme.Colors.loginGradientEnd,
              Theme.Colors.loginGradientStart
            ],
            begin: const FractionalOffset(0.2, 0.2),
            end: const FractionalOffset(1.0, 1.0),
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
                    fontFamily: _fontFamilyTitle,
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
                    fontFamily: _fontFamilyTitle,
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

Widget animalWidget(Animation typeAnimation, Animation catLogoAnimation, Animation dogLogoAnimation, String catLogo, String dogLogo, BuildContext context){
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
            animalLogoWidget(context, "Cat Encyclopedia", catLogo,
                catLogoAnimation),
            animalTypeWidget(context, "Cat", typeAnimation),
          ],
        ),
      ),
      Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              print(MediaQuery.of(context).size.height);
              print(MediaQuery.of(context).size.width);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ListAnimalsPage(
                        type: 'dogs',
                      )));
            },
            child: Stack(
              children: <Widget>[
                animalLogoWidget(context, "Dog Encyclopedia",
                    dogLogo, dogLogoAnimation),
                animalTypeWidget(context, "Dog", typeAnimation),
              ],
            ),
          )),
    ],
  );
}



Widget animalLogoWidget(BuildContext context, String name, String image,  Animation animation){
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

Widget animalTypeWidget(BuildContext context, String name, Animation animation){

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
                    fontFamily: _fontFamilyType),
              ),
       ),
      ),
     ),
    );
}