import 'package:flutter/material.dart';
import 'package:inject/inject.dart';
import 'package:tourists/components/user/user_routes.dart';
import 'package:tourists/ui/user/account_type_selector/login_type_selector.dart';
import 'package:tourists/ui/user/create_profile/create_profile.dart';
import 'package:tourists/ui/user/event_details/event_details_screen.dart';
import 'package:tourists/ui/user/home/home.dart';
import 'package:tourists/ui/user/intention_profile/intention_profile.dart';
import 'package:tourists/ui/user/location_details/location_details.dart';
import 'package:tourists/ui/user/login/login.dart';
import 'package:tourists/ui/user/orders_page/orders_page.dart';
import 'package:tourists/ui/user/register/register.dart';
import 'package:tourists/ui/user/request_guide/request_guide_screen.dart';
import 'package:tourists/ui/user/request_guide_success/request_guide_success.dart';
import 'package:tourists/ui/user/tourist_create_general_request/tourist_create_general_request.dart';

@provide
class UserComponent {
  // This Screens is here because it needs to be injected!
  final LoginScreen _loginScreen;
  final RegisterScreen _registerScreen;
  final CreateProfileScreen _createProfileScreen;
  final IntentionProfileScreen _intentionProfileScreen;
  final HomeScreen _homeScreen;
  final LoginTypeSelectorScreen _loginSelectorScreen;
  final RequestGuideScreen _orderGuideScreen;
  final RequestGuideSuccessScreen _requestGuideSuccessScreen;
  final LocationDetailsScreen _locationDetailsScreen;
  final OrdersScreen _ordersScreen;
  final EventDetailsScreen _eventDetailsScreen;
  final TouristCreateGeneralRequestScreen _generalRequestScreen;

  Map<String, WidgetBuilder> _userRoutes;

  UserComponent(
      this._loginScreen,
      this._loginSelectorScreen,
      this._requestGuideSuccessScreen,
      this._registerScreen,
      this._createProfileScreen,
      this._ordersScreen,
      this._eventDetailsScreen,
      this._generalRequestScreen,
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
      UserRoutes.eventDetails: (context) => _eventDetailsScreen,
      UserRoutes.home: (context) => _homeScreen,
      UserRoutes.orderPage: (context) => _ordersScreen,
      UserRoutes.locationDetails: (context) => _locationDetailsScreen,
      UserRoutes.requestGuide: (context) => _orderGuideScreen,
      UserRoutes.requestGuideSent: (context) => _requestGuideSuccessScreen,
      UserRoutes.makeGeneralRequest: (context) => _generalRequestScreen
    };
  }

  Map<String, WidgetBuilder> getRoutes() {
    return _userRoutes;
  }
}
