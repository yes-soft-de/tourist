import 'dart:convert';

import 'package:inject/inject.dart';
import 'package:tourists/consts/urls.dart';
import 'package:tourists/network/http_client/http_client.dart';
import 'package:tourists/responses/guide_response/guides_response.dart';

@provide
class GuidesRepository {
  HttpClient _client;

  GuidesRepository(this._client);

  Future<GuidesResponse> getGuidesList() async {
    String response = await _client.get(Urls.guideList);

    if (response != null) {
      return GuidesResponse.fromJson(jsonDecode(response));
    }

    return null;
  }

  Future<GuidesResponse> getGuidesByArea(String areaId) async {
    String response = await _client.get(Urls.guidesByRegion + '/' + areaId);

    if (response != null) {
      return GuidesResponse.fromJson(jsonDecode(response));
    }

    return null;
  }
}
