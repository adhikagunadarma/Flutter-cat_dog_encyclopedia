import 'dart:async';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cat_dog_encyclopedia/ui/cat_details_page.dart';
import 'package:cat_dog_encyclopedia/ui/dog_details_page.dart';
import 'package:cat_dog_encyclopedia/model/Cat.dart';
import 'package:cat_dog_encyclopedia/model/Dog.dart';

class ListAnimalsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _ListAnimalsPageState();

  final String type;

  const ListAnimalsPage({
    @required this.type,
  }) : assert(type != null);
}

class _ListAnimalsPageState extends State<ListAnimalsPage> {

  final double _borderRadius = 30.0;
  final double _iconBorderRadius = 30.0;
  final double _iconSize = 20.0;
  final double _searchTextSize = 20.0;
  final double _animalTextSize = 20.0;
  final double _animalIconSize = 75.0;

  final String _searchTextFamily = "MaliBold";
  final String _listTextFamily = "MaliSemiBold";

  final String _bgImage = 'assets/images/background.jpg';

  final TextEditingController _searchController = new TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();

  String _searchText = "";
  List animals = new List();
  List filteredAnimals = new List();
  StreamSubscription<QuerySnapshot> animalSub;

  Icon _searchIcon = new Icon(
    FontAwesomeIcons.search,
    color: Colors.black,
    size: 20.0,
  );

  Widget _appBarTitle = new Text("Encyclopedia List",
    style: TextStyle(
      color: Colors.black,
      fontFamily: "MaliBold",
      fontSize: 20.0
    ),
  );

  _ListAnimalsPageState() {
    _searchController.addListener(() {
      if (_searchController.text.isEmpty) {
        setState(() {
          _searchText = "";
          filteredAnimals = animals;
        });
      } else {
        setState(() {
          _searchText = _searchController.text;
        });
      }
    });
  }
  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildBar(context),
      body: _buildList(),
      resizeToAvoidBottomPadding: false,

    );
  }
  Widget getRow(int i) {
    return GestureDetector(
      child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(_borderRadius),
            ),
            child: Row(
//              mainAxisSize: MainAxisSize.max,
//              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(_iconBorderRadius)),

                    child: Image(
                      image: new AssetImage('${filteredAnimals[i].imageRef}'),
                      width: _animalIconSize,
                      height: _animalIconSize,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '${filteredAnimals[i].name}',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: _animalTextSize,
                        fontFamily: _listTextFamily
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )),
      onTap: () {
        Navigator.push(
            context,
            widget.type == 'cats'
                ? MaterialPageRoute(
                    builder: (context) => CatDetailsPage(
                          data: filteredAnimals[i],
                        ))
                : MaterialPageRoute(
                    builder: (context) => DogDetailsPage(
                          data: filteredAnimals[i],
                        )));
      },
    );
  }

  void getData() async{
    final CollectionReference animalCollections =
    Firestore.instance.collection(widget.type);
    Stream<QuerySnapshot> snapshots = animalCollections.snapshots();
    animalSub?.cancel();
    animalSub = snapshots.listen((QuerySnapshot snapshot) {

      if (widget.type == "cats") {
        final List<Cat> cats = snapshot.documents
            .map((documentSnapshot) => Cat.fromMap(documentSnapshot.data))
            .toList();
        setState(() {
          animals = cats;
          filteredAnimals = animals;
        });
      } else {
        final List<Dog> dogs = snapshot.documents
            .map((documentSnapshot) => Dog.fromMap(documentSnapshot.data))
            .toList();
        setState(() {
          animals = dogs;
          filteredAnimals = animals;
        });
      }
    });
  }

  Widget _buildBar(BuildContext context) {
    return new AppBar(
      backgroundColor: Color(0xFFfbab66),
      title: _appBarTitle,
      leading: new IconButton(
        icon: _searchIcon,
        onPressed: _searchPressed,
      ),
    );
  }


  Widget _buildList() {
    if (!(_searchText.isEmpty)) {
      List tempList = new List();
      for (int i = 0; i < filteredAnimals.length; i++) {
        if (filteredAnimals[i].name.toLowerCase().contains(_searchText.toLowerCase())) {
          tempList.add(filteredAnimals[i]);
        }
      }
      filteredAnimals = tempList;
    }
    return Container(
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
      child: ListView.builder(
        itemCount: animals == null ? 0 : filteredAnimals.length,
        padding: const EdgeInsets.all(4.0),
        itemBuilder: (BuildContext context, int index) {
          return getRow(index);
        },
      ),
    );
  }

  void _searchPressed() {
    setState(() {
      if (this._searchIcon.icon == FontAwesomeIcons.search) {
        this._searchIcon = new Icon(
          FontAwesomeIcons.times,
          color: Colors.black,
          size: _iconSize,
        );
        this._appBarTitle = new TextField(
          autofocus: true,
          keyboardType: TextInputType.text,
          focusNode: _searchFocusNode,
          controller: _searchController,
          style: TextStyle(
              fontFamily: _searchTextFamily,
              fontSize: _searchTextSize,
              color: Colors.black),
          decoration: InputDecoration(
            border: InputBorder.none,
            icon: Icon(
              FontAwesomeIcons.search,
              color: Colors.black,
              size: _iconSize,
            ),
            hintText: "Search...",
            hintStyle: TextStyle(
                fontFamily: _searchTextFamily,
                fontSize: 15.0),
          ),

        );
      } else {
        this._searchIcon = new Icon(
          FontAwesomeIcons.search,
          color: Colors.black,
          size: 20.0,
        );
        this._appBarTitle = new Text("Encyclopedia List",
          style: TextStyle(
              color: Colors.black,
              fontFamily: "MaliBold",
              fontSize: 20.0
          ),
        );
        filteredAnimals = animals;
        _searchController.clear();
      }
    });
  }
}
