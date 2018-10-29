
import 'package:flutter/material.dart';
import 'package:cat_dog_encyclopedia/model/Cat.dart';
import 'package:cat_dog_encyclopedia/widget/DetailsPageWidgets.dart';
import 'package:cat_dog_encyclopedia/extra/DotsIndicator.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CatDetailsPage extends StatefulWidget {

  final Cat data;

  const CatDetailsPage({
    @required this.data,
  }) : assert(data != null);

  @override
  State<StatefulWidget> createState() => new _CatDetailsPageState();
}

class _CatDetailsPageState extends State<CatDetailsPage> {

  final _controller = new PageController();

  static const _kDuration = const Duration(milliseconds: 300);

  static const _kCurve = Curves.ease;

  final double _borderRadius = 30.0;

  final String _nameFontFamily = "MaliMedium";

  final String _bgImage = 'assets/images/background.jpg';

  @override
  Widget build(BuildContext context) {



    List<Widget> _pages = <Widget>[
      detailsBottomWidget("Personality", widget.data.personality, 0xFFfebee5),
      detailsBottomWidget("Care", widget.data.care,0xFFe7a6fd),
      detailsBottomWidget("Environment", widget.data.environment,0xFFbcc4f8),
      detailsBottomWidget("Grooming", widget.data.grooming, 0xFFecf8bc),
      detailsBottomWidget("Health", widget.data.health, 0xFFace3c8),
    ];

    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(_pages),
      resizeToAvoidBottomPadding: false,
    );
  }

  Widget _buildAppBar() {
    return new AppBar(
      leading: new IconButton(
        icon: new Icon(
          FontAwesomeIcons.cat,
          color: Colors.black,
          size: 20.0,
        ), onPressed: () {},
      ),
      title: Text("${widget.data.name}",
        style: TextStyle(
          fontFamily: _nameFontFamily,
          color: Colors.black,
        ),
      ),

      backgroundColor: Color(0xFFfbab66),
    );
  }

  Widget _buildBody(List<Widget> pages) {
    return SingleChildScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height >= 775.0
            ? MediaQuery.of(context).size.height
            : 775.0,
        decoration: new BoxDecoration(
          image: new DecorationImage(
              image: new AssetImage(_bgImage),
              fit: BoxFit.cover
          ),
        ),
        child: new Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: detailsTopWidget("Image", widget.data.imageRef, context),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(_borderRadius),
                    ),
                    color: Color(0xFFe0dce0),
                    child: Column(
                      children: <Widget>[
                        detailsMiddleWidget("Lifespan", widget.data.lifespan),
                        detailsMiddleWidget("Size", widget.data.size),
                        detailsMiddleWidget("About", widget.data.about),
                      ],
                    ),
                  ),
                ),
                Flexible(
                  fit: FlexFit.loose,
                  child: SizedBox(
                    height: 300.0,
                    width: MediaQuery.of(context).size.width,
                    child: Stack(
                      children: <Widget>[
                        new PageView.builder(
                            physics: new AlwaysScrollableScrollPhysics(),
                            controller: _controller,
                            itemCount: 5,
                            itemBuilder: (BuildContext context, int index) {
                              return pages[index % pages.length];
                            }),
                        new Positioned(
                          bottom: 0.0,
                          left: 0.0,
                          right: 0.0,
                          child: new Container(
                            color: Colors.grey[800].withOpacity(0.5),
                            padding: const EdgeInsets.all(20.0),
                            child: new Center(
                              child: new DotsIndicator(
                                controller: _controller,
                                itemCount: 5,
                                onPageSelected: (int page) {
                                  _controller.animateToPage(
                                    page,
                                    duration: _kDuration,
                                    curve: _kCurve,
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}
