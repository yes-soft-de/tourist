import 'package:tourists/models/profile/profile.model.dart';

class CreateProfileBody {
  String uid;
  String name;
  String lang;
  String gender;
  String roles = "tourist";
  String nationality;
  String arrivalCity;
  String arrivalDate;
  String stayDays;
  String email;
  String password;
  String phoneNumber;
  String image;
  List<String> interests;

  CreateProfileBody(
      {this.uid,
      this.name,
      this.gender,
      this.lang,
      this.roles,
      this.nationality,
      this.arrivalCity,
      this.arrivalDate,
      this.stayDays,
      this.email,
      this.password,
      this.phoneNumber,
      this.interests,
      this.image});

  Map<String, dynamic> toMap() {
    Map<String, dynamic> object = new Map();
    // Map only the active parts
    if (uid != null) object['userID'] = uid;
    if (name != null) object['name'] = name;
    if (gender != null) object['sex'] = gender;
    if (lang != null) object['guideLanguage'] = lang;
    if (roles != null) object['roles'] = roles;
    if (nationality != null) object['nationality'] = nationality;
    if (arrivalCity != null) object['arrivalCity'] = arrivalCity;
    if (arrivalDate != null) object['arrivalDate'] = arrivalDate;
    if (stayDays != null) object['stayDays'] = stayDays;
    if (email != null) object['email'] = email;
    if (password != null) object['password'] = password;
    if (phoneNumber != null) object['phoneNumber'] = phoneNumber;
    if (image != null) object['image'] = image;
    if (interests != null && interests.length > 0) object['interests'] = interests;

    return object;
  }
}
