import 'package:inject/inject.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tourists/module_authorization/user_authorization_module/service/login/login.service.dart';

@provide
class LoginBloc {
  final LoginService _loginService;
  LoginBloc(this._loginService);

  final _loginChecker = PublishSubject<String>();

  Stream<String> get loginStatus => _loginChecker.stream;

  void login(String username, String password) async {
    String loginResponse = await _loginService.login(username, password);

    _loginChecker.add(loginResponse);
  }

  void loginWithGoogle() async {
    String loginResponse = await _loginService.loginWithGoogle();
    _loginChecker.add(loginResponse);
  }

  void dispose() {
    _loginChecker.close();
  }
}
