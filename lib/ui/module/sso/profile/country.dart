class Country {
  int _id;
  String _code;
  String _name;

  Country(this._id, this._code, this._name);

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  String get code => _code;

  set code(String value) {
    _code = value;
  }

  int get id => _id;

  set id(int value) {
    _id = value;
  }
}
