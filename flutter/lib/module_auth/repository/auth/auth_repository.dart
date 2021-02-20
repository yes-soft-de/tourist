import 'package:tourists/consts/urls.dart';
import 'package:tourists/module_auth/request/login_request/login_request.dart';
import 'package:tourists/module_auth/request/register_request/register_request.dart';
import 'package:tourists/module_auth/response/login_response/login_response.dart';
import 'package:tourists/module_network/http_client/http_client.dart';
import 'package:inject/inject.dart';

@provide
class AuthRepository {
  final _apiClient = HttpClient();

  AuthRepository();

  Future<bool> createUser(RegisterRequest request) async {
    var result = await _apiClient.post(
      request.roles == 'guide'
          ? Urls.registerGuideAPI
          : Urls.registerTouristsAPI,
      request.toJson(),
    );

    return result != null;
  }

  Future<LoginResponse> getToken(LoginRequest loginRequest) async {
    var result = await _apiClient.post(
      Urls.loginAPI,
      loginRequest.toJson(),
    );

    if (result == null) {
      return null;
    }
    return LoginResponse.fromJson(result);
  }
}
