import 'package:inject/inject.dart';

@provide
class Routes {
  static const String home = '/home';
  static const String login = '/login';
  static const String register = '/register';
  static const String loginTypeSelector = '/login_type_selector';
  static const String createProfile = '/createProfile';
  static const String intentionProfile = '/intentionProfile';
  static const String locationDetails = '/locationDetails';

  static const String touristChat = '/touristChat';
  static const String touristOrders = '/touristOrders';
}