import 'package:flutter/cupertino.dart';
import 'package:tourists/abstracts/module/yes_module.dart';
import 'package:tourists/user_authorization_module/ui/screens/create_profile/create_profile.dart';
import 'package:tourists/user_authorization_module/ui/screens/intention_profile/intention_profile.dart';
import 'package:tourists/user_authorization_module/ui/screens/register/register.dart';
import 'package:tourists/user_authorization_module/user_auth_routes.dart';

import 'ui/screens/login/login.dart';

class UserAuthorizationModule extends YesModule {
  LoginScreen _loginScreen;
  RegisterScreen _registerScreen;
  CreateProfileScreen _createProfileScreen;
  IntentionProfileScreen _intentionProfileScreen;

  @override
  Map<String, WidgetBuilder> getRoutes() {
    return {
      UserAuthorizationRoutes.login: (context) => _loginScreen,
      UserAuthorizationRoutes.register: (context) => _registerScreen,
      UserAuthorizationRoutes.createProfile: (context) => _createProfileScreen,
      UserAuthorizationRoutes.createIntentions: (context) =>
          _intentionProfileScreen,
    };
  }
}
