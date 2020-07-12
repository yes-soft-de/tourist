import 'package:inject/inject.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tourists/services/login/login.service.dart';

@provide
class LoginBloc {
  LoginService _loginService;

  LoginBloc(this._loginService);

  final _loginChecker = PublishSubject<String>();

  Stream<String> get loginStatus => _loginChecker.stream;

  login(String username, String password) async {
    String loginResponse = await _loginService.login(username, password);

    _loginChecker.add(loginResponse);
  }

  dispose() {
    _loginChecker.close();
  }
}