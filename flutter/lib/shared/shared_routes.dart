import 'package:tourists/user/ui/screens/account_type_selector/login_type_selector.dart';
import 'package:tourists/user/ui/screens/login/login.dart';
import 'package:tourists/user/ui/screens/register/register.dart';

class SharedRoutes {
  final LoginTypeSelectorScreen _loginTypeSelectorScreen;
  final LoginScreen _loginScreen;
  final RegisterScreen _registerScreen;

  SharedRoutes(this._registerScreen, this._loginScreen, this._loginTypeSelectorScreen);
}