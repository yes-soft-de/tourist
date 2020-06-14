import 'package:tourists/models/profile/profile.model.dart';

class CreateProfileBody {
  String _uid;
  String _name;
  String _lang;
  int _age;

  CreateProfileBody(this._uid, this._name, this._lang, this._age);

  Map<String, dynamic> toMap() {
    Map<String, dynamic> object = new Map();
    object['userID'] = _uid;
    object['name'] = _name;
    object['language'] = _lang;
    object['age'] = _age;

    return object;
  }

  int get age => _age;

  set age(int value) {
    _age = value;
  }

  String get lang => _lang;

  set lang(String value) {
    _lang = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  String get uid => _uid;

  set uid(String value) {
    _uid = value;
  }
}