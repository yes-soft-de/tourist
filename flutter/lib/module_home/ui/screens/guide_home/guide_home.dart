import 'package:flutter/material.dart';
import 'package:inject/inject.dart';
import 'package:tourists/generated/l10n.dart';
import 'package:tourists/module_home/ui/widget/custom_bottom_navigation_bar/custom_bottom_navigation_bar.dart';
import 'package:tourists/module_locations/ui/screens/event_list/event_list.dart';
import 'package:tourists/module_locations/ui/screens/location_list/location_list_screen.dart';
import 'package:tourists/module_orders/ui/screen/guide_orders/guide_orders.dart';
import 'package:tourists/module_persistence/sharedpref/shared_preferences_helper.dart';

@provide
class GuideHomeScreen extends StatefulWidget {
  final GuideOrdersScreen _ordersListScreen;

  final SharedPreferencesHelper _preferencesHelper;

  GuideHomeScreen(
    this._ordersListScreen,
    this._preferencesHelper,
  );

  @override
  State<StatefulWidget> createState() => GuideHomeScreenState(0);
}

class GuideHomeScreenState extends State<GuideHomeScreen> {
  int currentPosition;
  final PageController _pageController = PageController();

  GuideHomeScreenState(this.currentPosition);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget._ordersListScreen,
    );
  }
}
