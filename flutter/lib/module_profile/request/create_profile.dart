class CreateProfileRequest {
  String userName;
  String userID;
  String story;
  String image;
  String phoneNumber;
  List<String> location;
  List<String> services;
  List<String> languages;

  CreateProfileRequest({
    this.userID,
    this.story,
    this.userName,
    this.phoneNumber,
    this.location,
    this.image,
    this.languages,
    this.services,
  });

  Map<String, dynamic> toJson() {
    return {
      'user': this.userID,
      'userName': this.userName,
      'name': this.userName,
      'story': this.story,
      'location': this.location,
      'places': this.location,
      'image': this.image,
      'service': this.services,
      'language': this.languages,
      'phoneNumber': this.phoneNumber,
    };
  }
}
