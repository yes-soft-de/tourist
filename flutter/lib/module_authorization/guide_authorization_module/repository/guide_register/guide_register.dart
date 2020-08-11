import 'dart:convert';
import 'dart:developer';

import 'package:inject/inject.dart';
import 'package:tourists/consts/urls.dart';
import 'package:tourists/module_authorization/guide_authorization_module/request/register_guide/register_guide.dart';
import 'package:tourists/module_authorization/guide_authorization_module/request/update_guide/update_guide.dart';
import 'package:tourists/module_guide/response/guide_response/guides_response.dart';
import 'package:tourists/module_network/http_client/http_client.dart';

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
