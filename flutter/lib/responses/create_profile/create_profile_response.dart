class CreateProfileResponse {
  int _statusCode;

  fromJson(Map<String, dynamic> jsonPayload){
    _statusCode = jsonPayload['status_code'];
  }

  int get statusCode => _statusCode;

  set statusCode(int value) {
    _statusCode = value;
  }
}