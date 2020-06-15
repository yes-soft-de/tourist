import 'dart:convert';

import 'package:inject/inject.dart';
import 'package:tourists/consts/urls.dart';
import 'package:tourists/models/profile/profile.model.dart';
import 'package:tourists/network/http_client/http_client.dart';
import 'package:tourists/requests/create_profile/create_profile_body.dart';
import 'package:tourists/responses/create_profile/create_profile_response.dart';

@provide
class ProfileRepository {
  HttpClient _httpClient;

  ProfileRepository(this._httpClient);

  Future<CreateProfileResponse> createProfile(CreateProfileBody profile) async {
    var stringResponse = await _httpClient.post(Urls.createProfileAPI, profile.toMap());
    CreateProfileResponse parsedResponse = new CreateProfileResponse().fromJson(json.decode(stringResponse));
    return parsedResponse;
  }

  Future<CreateProfileResponse> getProfile(String uid) async {
    var stringResponse = await _httpClient.get(Urls.getProfileAPI + '/' + uid);
    CreateProfileResponse parsedResponse = new CreateProfileResponse().fromJson(json.decode(stringResponse));
    return parsedResponse;
  }
}