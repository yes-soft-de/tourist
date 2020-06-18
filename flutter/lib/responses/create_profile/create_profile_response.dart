class CreateProfileResponse {
  String _name;
  String _gender;
  String _language;


  fromJson(Map<String, dynamic> jsonPayload){
    _gender = jsonPayload['sex'];
    _name = jsonPayload['name'];
    _language = jsonPayload['guideLanguage'];
  }

  CreateProfileResponse();

  set language(String value) {
    _language = value;
  }

  set gender(String value) {
    _gender = value;
  }

  set name(String value) {
    _name = value;
  }

  String get language => _language;

  String get gender => _gender;

  String get name => _name;
}