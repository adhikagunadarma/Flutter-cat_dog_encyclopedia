
class Dog {
  String _id;
  String _name;
  String _size;
  String _lifespan;
  String _about;
  String _imageRef;
  String _imagePath;

  String _health;
  String _grooming;

  String _nutrition;
  String _exercise;
  String _training;


  Dog(this._id, this._name, this._size, this._lifespan, this._about, this._imageRef, this._imagePath, this._health, this._grooming, this._nutrition, this._exercise, this._training,);

  Dog.map(dynamic obj) {
    this._id = obj['id'];
    this._name = obj['name'];
    this._size = obj['size'];
    this._lifespan = obj['title'];
    this._about = obj['lifespan'];
    this._imageRef = obj['imageRef'];
    this._imagePath = obj['imagePath'];
    this._health = obj['health'];
    this._grooming = obj['grooming'];
    this._nutrition = obj['nutrition'];
    this._exercise = obj['exercise'];
    this._training = obj['training'];
  }

  String get id => _id;
  String get name => _name;
  String get size => _size;
  String get lifespan => _lifespan;
  String get about => _about;
  String get imageRef => _imageRef;
  String get imagePath => _imagePath;

  String get health => _health;
  String get grooming => _grooming;

  String get nutrition => _nutrition;
  String get exercise => _exercise;
  String get training => _training;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    if (_id != null) {
      map['id'] = _id;
    }
    map['name'] = _name;
    map['size'] = _size;
    map['lifespan'] = _lifespan;
    map['about'] = _about;
    map['imageRef'] = _imageRef;
    map['imagePath'] = _imagePath;
    map['health'] = _health;
    map['grooming'] = _grooming;
    map['nutrition'] = _nutrition;
    map['exercise'] = _exercise;
    map['training'] = _training;

    return map;
  }

  Dog.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._name = map['name'];
    this._size = map['size'];
    this._lifespan = map['lifespan'];
    this._about = map['about'];
    this._imageRef = map['imageRef'];
    this._imagePath = map['imagePath'];
    this._health = map['health'];
    this._grooming = map['grooming'];
    this._nutrition = map['nutrition'];
    this._exercise = map['exercise'];
    this._training = map['training'];
  }
}