import 'package:inject/inject.dart';
import 'package:tourists/consts/urls.dart';
import 'package:tourists/network/http_client/http_client.dart';
import 'package:tourists/requests/register_guide/register_guide.dart';
import 'package:tourists/requests/request_guide/request_guide.dart';

@provide
class GuideRegisterRepository {
  final HttpClient _client;
  GuideRegisterRepository(this._client);

  registerGuide(RegisterGuideRequest requestGuideRequest){
    this._client.post(Urls.loginGuideAPI, requestGuideRequest.toJson());
  }

  loginGuide() {
    this._client.get(Urls.guideList);
  }
}