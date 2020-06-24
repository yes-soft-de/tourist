import 'package:flutter/material.dart';
import 'package:inject/inject.dart';
import 'package:tourists/user/ui/screens/account_type_selector/login_type_selector.dart';
import 'package:tourists/user/ui/screens/create_profile/create_profile.dart';
import 'package:tourists/user/ui/screens/home/home.dart';
import 'package:tourists/user/ui/screens/intention_profile/intention_profile.dart';
import 'package:tourists/user/ui/screens/login/login.dart';
import 'package:tourists/user/ui/screens/register/register.dart';
import 'package:tourists/user/user_routes.dart';

@provide
class UserComponent {
  // This Screens is here because it needs to be injected!
  final LoginScreen _loginScreen;
  final RegisterScreen _registerScreen;
  final CreateProfileScreen _createProfileScreen;
  final IntentionProfileScreen _intentionProfileScreen;
  final HomeScreen _homeScreen;
  final LoginTypeSelectorScreen _loginSelectorScreen;

  Map<String, WidgetBuilder> _userRoutes;

  UserComponent(this._loginScreen, this._loginSelectorScreen, this._registerScreen, this._createProfileScreen, this._homeScreen, this._intentionProfileScreen) {
    _userRoutes = {
      UserRoutes.loginTypeSelector: (context) => _loginSelectorScreen,
      UserRoutes.login: (context) => _loginScreen,
      UserRoutes.register: (context) => _registerScreen,
      UserRoutes.createProfile: (context) => _createProfileScreen,
      UserRoutes.intentionProfile: (context) => _intentionProfileScreen,
      UserRoutes.home: (context) => _homeScreen,
    };
  }

  Map<String, WidgetBuilder> getRoutes() {
    return _userRoutes;
  }
}