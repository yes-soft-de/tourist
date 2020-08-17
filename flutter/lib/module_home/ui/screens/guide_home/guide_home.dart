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
  final LocationListScreen _locationListScreen;
  final EventListScreen _eventListScreen;

  final SharedPreferencesHelper _preferencesHelper;

  GuideHomeScreen(this._ordersListScreen, this._locationListScreen,
      this._eventListScreen, this._preferencesHelper);

  @override
  State<StatefulWidget> createState() => GuideHomeScreenState(0);
}

class GuideHomeScreenState extends State<GuideHomeScreen> {
  int currentPosition;
  PageController _pageController = PageController();

  GuideHomeScreenState(this.currentPosition);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: 56,
            child: PageView(
              controller: _pageController,
              children: <Widget>[
                widget._ordersListScreen,
                Scaffold(
                  appBar: AppBar(
                    title: Text(S.of(context).map),
                  ),
                  body: widget._locationListScreen,
                ),
                widget._eventListScreen,
              ],
              onPageChanged: (pos) {
                // Update the Home Page
                currentPosition = pos;
                setState(() {});
              },
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: FutureBuilder(
              future: widget._preferencesHelper.getLoggedInState(),
              builder: (BuildContext context,
                  AsyncSnapshot<LoggedInState> snapshot) {
                return CustomGuideBottomNavigationBar(
                  onNavigationChanged: (int newPosition) {
                    _pageController.jumpToPage(newPosition);
                    if (this.mounted) setState(() {});
                  },
                  currentPosition: currentPosition,
                  loggedIn: snapshot.data == LoggedInState.GUIDE,
                );
              },
            ),
          )
        ],
      ),
    );
  }

  moveToPage(int position) {
    _pageController.jumpToPage(position);
  }
}
