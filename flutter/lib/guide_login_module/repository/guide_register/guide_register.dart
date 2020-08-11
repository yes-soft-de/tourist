import 'dart:convert';
import 'dart:developer';

import 'package:inject/inject.dart';
import 'package:tourists/consts/urls.dart';
import 'package:tourists/network/http_client/http_client.dart';
import 'package:tourists/requests/register_guide/register_guide.dart';
import 'package:tourists/requests/update_guide/update_guide.dart';
import 'package:tourists/responses/guide_response/guides_response.dart';

@provide
class GuideRegisterRepository {
  final HttpClient _client;

  GuideRegisterRepository(this._client);

  registerGuide(RegisterGuideRequest requestGuideRequest) {
    this._client.post(Urls.loginGuideAPI, requestGuideRequest.toJson());
  }

  loginGuide() {
    return this._client.get(Urls.guideList);
  }

  Future<GuidesResponse> updateGuide(
      UpdateGuideRequest updateGuideRequest) async {
    String response =
        await this._client.put(Urls.loginGuideAPI, updateGuideRequest.toJson());

    if (response != null) {
      try {
        return GuidesResponse.fromJson(jsonDecode(response));
      } catch (e) {
        log(e.toString());
        return null;
      }
    }

    return null;
  }
}
