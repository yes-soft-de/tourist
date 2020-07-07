import 'package:flutter/material.dart';
import 'package:inject/inject.dart';
import 'package:tourists/user/ui/screens/account_type_selector/login_type_selector.dart';
import 'package:tourists/user/ui/screens/create_profile/create_profile.dart';
import 'package:tourists/user/ui/screens/home/home.dart';
import 'package:tourists/user/ui/screens/intention_profile/intention_profile.dart';
import 'package:tourists/user/ui/screens/location_details/location_details.dart';
import 'package:tourists/user/ui/screens/login/login.dart';
import 'package:tourists/user/ui/screens/order_guide/order_guide.dart';
import 'package:tourists/user/ui/screens/register/register.dart';
import 'package:tourists/user/ui/screens/request_guide_success/request_guide_success.dart';
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
  final OrderGuideScreen _orderGuideScreen;
  final RequestGuideSuccessScreen _requestGuideSuccessScreen;
  final LocationDetailsScreen _locationDetailsScreen;

  Map<String, WidgetBuilder> _userRoutes;

  UserComponent(
      this._loginScreen,
      this._loginSelectorScreen,
      this._requestGuideSuccessScreen,
      this._registerScreen,
      this._createProfileScreen,
      this._homeScreen,
      this._intentionProfileScreen,
      this._locationDetailsScreen,
      this._orderGuideScreen) {
    _userRoutes = {
      UserRoutes.loginTypeSelector: (context) => _loginSelectorScreen,
      UserRoutes.login: (context) => _loginScreen,
      UserRoutes.register: (context) => _registerScreen,
      UserRoutes.createProfile: (context) => _createProfileScreen,
      UserRoutes.intentionProfile: (context) => _intentionProfileScreen,
      UserRoutes.home: (context) => _homeScreen,
      UserRoutes.locationDetails: (context) => _locationDetailsScreen,
      UserRoutes.requestGuide: (context) => _orderGuideScreen,
      UserRoutes.requestGuideSent: (context) => _requestGuideSuccessScreen
    };
  }

  Map<String, WidgetBuilder> getRoutes() {
    return _userRoutes;
  }
}
