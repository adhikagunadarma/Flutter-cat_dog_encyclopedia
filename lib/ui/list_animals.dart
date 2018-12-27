import 'dart:async';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cat_dog_encyclopedia/ui/details_page.dart';
import 'package:cat_dog_encyclopedia/model/Cat.dart';
import 'package:cat_dog_encyclopedia/model/Dog.dart';
import 'package:flutter_advanced_networkimage/transition_to_image.dart';
import 'package:flutter_advanced_networkimage/flutter_advanced_networkimage.dart';
import 'package:flare_flutter/flare_actor.dart';

import 'package:connectivity/connectivity.dart';
import 'package:cat_dog_encyclopedia/style/theme.dart' as Theme;

class ListAnimalsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _ListAnimalsPageState();

  final String type;

  const ListAnimalsPage({
    @required this.type,
  }) : assert(type != null);
}

class _ListAnimalsPageState extends State<ListAnimalsPage> {

  static double _bodyContainerWidth;
  static double _bodyContainerHeight;

  static double _padding;

  static double _cardBorderRadius;
  static double _cardHeight;

  static double _animalIconSize;
  static double _animalFontSize;
  static double _animalIconBorderRadius;

  static double _searchIconSize;
  static double _searchFontSize;

  static double
      _miscFontSize;

  static double _loadingIndicatorSize;

  static double _bottomBarHeight;


  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final ScrollController _scrollController = new ScrollController();
  final TextEditingController _searchController = new TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();

  static bool _load;
  static bool _search;
  List<String> alphabets = ["A","B","C"];
  List<Cat> cats = new List();
  List<Dog> dogs = new List();
  List animals = new List();
  List filteredAnimals = new List();
  List searchAnimalsData = new List();
  StreamSubscription<QuerySnapshot> animalSub;

  @override
  void initState() {
    _search = false;
    _load = true;
    getData();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void setSize() {
    _bodyContainerWidth = MediaQuery.of(context).size.width; // container page width
    _bodyContainerHeight = MediaQuery.of(context).size.height >= 775.0 // container page height
        ? MediaQuery.of(context).size.height
        : 775.0;

    _padding = MediaQuery.of(context).size.height / 85.375;//overall padding

    _cardHeight = MediaQuery.of(context).size.height / 6.83; //each card height/size
    _cardBorderRadius = MediaQuery.of(context).size.height / 13.66; //each card radius

    _animalIconSize = MediaQuery.of(context).size.height / 9.11;  //animal icon size
    _animalIconBorderRadius = MediaQuery.of(context).size.height / 18.213333; //animal icon radius
    _animalFontSize = MediaQuery.of(context).size.height / 34.15; //animal font size

    _searchIconSize = MediaQuery.of(context).size.height / 34.15; //search icon size
    _searchFontSize = MediaQuery.of(context).size.height / 34.15; //search font size

    _miscFontSize = MediaQuery.of(context).size.height / 45.5333; //misc font size like loading indicator, snackbar,search hint

    _loadingIndicatorSize = MediaQuery.of(context).size.height / 4.5533; //loading indicator container size


    _bottomBarHeight = MediaQuery.of(context).size.height / 13.66; //bottom bar size/height
  }

  @override
  Widget build(BuildContext context) {
    setSize(); // set weight,height, font size, etc
    Widget loadingIndicator = _load
        ? new Container(
            color: Theme.Colors.thirdColor.withOpacity(0.0),
            child: SizedBox(
              child: new Padding(
                  padding: EdgeInsets.all(_padding),
                  child: new Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[

                      SizedBox(
                        child: new FlareActor("assets/animations/loading.flr",
                          animation: "loadingPaw",
                          color : Colors.black,
                          alignment:Alignment.center,
                          fit:BoxFit.contain,),
                        width : 3*_loadingIndicatorSize/4 ,
                        height : 3*_loadingIndicatorSize/4
                      ),
                      new Text(
                        "Loading data...",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.black,
                            letterSpacing: 1.5,
                            fontWeight: FontWeight.w500,
                            fontSize: _miscFontSize,
                            fontFamily: Theme.Font.primaryFont),
                      )
                    ],
                  ))),
              height: _loadingIndicatorSize,
              width: _loadingIndicatorSize,
            ),
          )
        : new Container();
    return Scaffold(
      backgroundColor: Theme.Colors.primaryColor,
      appBar: _buildAppBar(),
      key: _scaffoldKey,
      body: _buildList(loadingIndicator),
//      bottomNavigationBar: _buildBottomBar(),
      resizeToAvoidBottomPadding: false,
    );
  }

  Widget getRow(int i) {
    return GestureDetector(
      child: Padding(
          padding: EdgeInsets.all(
            _padding,
          ),
          child: Container(
            key : Key(filteredAnimals[i].id),
            decoration: BoxDecoration(
              color: Theme.Colors.thirdColor.withOpacity(0.8),
              borderRadius:
                  BorderRadius.all(Radius.circular(_cardBorderRadius)),
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
            height: _cardHeight,
            child: Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(_padding),
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(
                        Radius.circular(_animalIconBorderRadius)),
                    child: TransitionToImage(
                      AdvancedNetworkImage(filteredAnimals[i].imageRef,
                          timeoutDuration: Duration(minutes: 1),
                          useDiskCache: true, loadFailedCallback: () {
                        showInSnackBar("Connection Timed Out");
                      }),
                      loadingWidget: FlareActor("assets/animations/loading.flr",
                        animation: "loadingPaw",
                        color : Colors.black,
                        alignment:Alignment.center,
                        fit:BoxFit.contain,),
                      // This is default duration
                      duration: Duration(milliseconds: 300),
                      fit: BoxFit.fill,
                      width: _animalIconSize,
                      height: _animalIconSize,
                      placeholder: const Icon(Icons.error),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(
                      _padding,
                    ),
                    child: Text(
                      '${filteredAnimals[i].name}',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: Colors.black,
                          letterSpacing: 1.5,
                          fontWeight: FontWeight.w500,
                          fontSize: _animalFontSize,
                          fontFamily: Theme.Font.primaryFont),
                    ),
                  ),
                ),
              ],
            ),
          )),
      onTap: () {
        _searchFocusNode.unfocus();
        Navigator.push(
            context,
            widget.type == 'cats'
                ? MaterialPageRoute(
                    builder: (context) => DetailsPage(
                        cat: filteredAnimals[i], dog: null, type: "cats"))
                : MaterialPageRoute(
                    builder: (context) => DetailsPage(
                        dog: filteredAnimals[i], cat: null, type: "dogs")));

      },
    );
  }

  Widget _buildAppBar() {
    if (_search) {
      return new AppBar(
      backgroundColor: Theme.Colors.primaryColor.withOpacity(0.8),
      elevation: 5.0,
      title: TextField(
        onChanged: (value) {
          filterSearchResults(value);
        },
        autofocus: true,
        keyboardType: TextInputType.text,
        focusNode: _searchFocusNode,
        controller: _searchController,
        style: TextStyle(
            fontFamily: Theme.Font.secondaryFont,
            fontSize: _searchFontSize,
            letterSpacing: 1.5,
            fontWeight: FontWeight.w500,
            color: Colors.black),
        decoration: InputDecoration(
          suffixIcon: IconButton(
            icon: Icon(
              FontAwesomeIcons.times,
              color: Colors.black,
              size: _searchIconSize,
            ),
            onPressed: (){
              {

                setState(() {
//                  searchAnimalsData.clear();
                  _searchController.clear();
                  filteredAnimals.clear();
                  filteredAnimals.addAll(animals);
                });
              }
            },
          ),
          border: InputBorder.none,
          hintText: "Enter name here..",
          hintStyle: TextStyle(
              letterSpacing: 1.5,
              fontWeight: FontWeight.w500,
              fontFamily: Theme.Font.secondaryFont,
              fontSize: _miscFontSize),
        ),
      ),
      leading: IconButton(
        icon: new Icon(
            FontAwesomeIcons.arrowLeft,
            color: Colors.black,
            size: _searchIconSize,
          ),
        onPressed: (){
          setState(() {
            _search = false;
            _searchFocusNode.unfocus();
            searchAnimalsData.clear();
            _searchController.clear();
            filteredAnimals.clear();
            filteredAnimals.addAll(animals);
          });
        },
      ),
    );
    } else {
      return new AppBar(
      backgroundColor: Theme.Colors.primaryColor.withOpacity(0.8),
      elevation: 5.0,
      title: new Text(
        "Encyclopedia List",
        style: TextStyle(
            fontFamily: Theme.Font.secondaryFont,
            fontSize: _searchFontSize,
            letterSpacing: 1.5,
            fontWeight: FontWeight.w500,
            color: Colors.black),

      ),
      leading: IconButton(
        icon: new Icon(
          FontAwesomeIcons.search,
          color: Colors.black,
          size: _searchIconSize,
        ),
        onPressed: (){
          setState(() {
            _search = true;

          });
        },
      ),
    );
    }
  }

  Widget _buildBottomBar() {
    return BottomAppBar(
      color: Theme.Colors.thirdColor.withOpacity(0.0),
      elevation: 0.0,
      child: new Container(
        height: _bottomBarHeight,
      ),
    );
  }

  Widget _buildList(Widget loadingIndicator) {

//    if (!(_searchText.isEmpty)) {
//      List tempList = new List();
//      for (int i = 0; i < filteredAnimals.length; i++) {
//        if (filteredAnimals[i].name.toLowerCase().contains(_searchText.toLowerCase())) {
//          tempList.add(filteredAnimals[i]);
//        }
//      }
//      filteredAnimals = tempList;
//    }

    return Stack(
      children: <Widget>[
        Container(
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
          child: ListView.builder(
            controller: _scrollController,
            itemCount: animals == null ? 0 : filteredAnimals.length,
            padding: EdgeInsets.all(_padding),
            itemBuilder: (BuildContext context, int index) {
              return getRow(index);
            },
          ),
        ),
        new Align(
          child: loadingIndicator,
          alignment: FractionalOffset.center,
        ),
      ],
    );
  }

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

  void getData() async {
    var connectivityResult = await (new Connectivity().checkConnectivity());
    final CollectionReference animalCollections =
        Firestore.instance.collection(widget.type);
    Stream<QuerySnapshot> snapshots = animalCollections.snapshots();
    animalSub?.cancel();
    animalSub = snapshots.listen((QuerySnapshot snapshot) {
      if (widget.type == "cats") {
        final List<Cat> dataCats = snapshot.documents
            .map((documentSnapshot) => Cat.fromMap(documentSnapshot.data))
            .toList();

        setState(() {
          animals.addAll(dataCats);
          filteredAnimals.addAll(animals);
          _load = false;
        });
      } else {
        final List<Dog> dataDogs = snapshot.documents
            .map((documentSnapshot) => Dog.fromMap(documentSnapshot.data))
            .toList();
        setState(() {
          animals.addAll(dataDogs);
          filteredAnimals.addAll(animals);
          _load = false;
        });
      }
      if (connectivityResult == ConnectivityResult.none) {
        showInSnackBar("No Internet Connection");
      } else if (snapshot.documents.length < 1) {
        showInSnackBar("Connection Timed Out");
//    print (connectivityResult.toString());
      }
    });
  }

  void filterSearchResults(String query) {
    if(query.isNotEmpty) {
      searchAnimalsData.clear();
      animals.forEach((item) {
        if(item.name.toLowerCase().contains(query.toLowerCase())) {
          searchAnimalsData.add(item);
        }
      });
      setState(() {
        filteredAnimals.clear();
        filteredAnimals.addAll(searchAnimalsData);
      });
//      return;
    } else {
      setState(() {
//        searchAnimalsData.clear();
        _searchController.clear();
        filteredAnimals.clear();
        filteredAnimals.addAll(animals);
      });
    }
  }

}
