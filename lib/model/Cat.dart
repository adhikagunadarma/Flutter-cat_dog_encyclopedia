
class Cat {
  String _id;
  String _name;
  String _size;
  String _lifespan;
  String _about;
  String _imageRef;
  String _imagePath;

  String _health;
  String _grooming;

  String _care;
  String _environment;
  String _personality;


  Cat(this._id, this._name, this._size, this._lifespan, this._about, this._imageRef, this._imagePath, this._health, this._grooming, this._care, this._environment, this._personality,);

  Cat.map(dynamic obj) {
    this._id = obj['id'];
    this._name = obj['name'];
    this._size = obj['size'];
    this._lifespan = obj['lifespan'];
    this._about = obj['about'];
    this._imageRef = obj['imageRef'];
    this._imagePath = obj['imagePath'];
    this._health = obj['health'];
    this._grooming = obj['grooming'];
    this._care = obj['care'];
    this._environment = obj['environment'];
    this._personality = obj['personality'];
  }

  Cat.from(String id, String name, String size, String about, String lifespan, String imageRef, String imagePath, String health, String grooming, String care, String environment, String personality) {
    this._id = id;
    this._name = name;
    this._size = size;
    this._lifespan = lifespan;
    this._about = about;
    this._imageRef = imageRef;
    this._imagePath = imagePath;
    this._health = health;
    this._grooming = grooming;
    this._care = care;
    this._environment = environment;
    this._personality = personality;
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

  String get care => _care;
  String get environment => _environment;
  String get personality => _personality;

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
    map['care'] = _care;
    map['environment'] = _environment;
    map['personality'] = _personality;

    return map;
  }

  Cat.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._name = map['name'];
    this._size = map['size'];
    this._lifespan = map['lifespan'];
    this._about = map['about'];
    this._imageRef = map['imageRef'];
    this._imagePath = map['imagePath'];
    this._health = map['health'];
    this._grooming = map['grooming'];
    this._care = map['care'];
    this._environment = map['environment'];
    this._personality = map['personality'];
  }
}